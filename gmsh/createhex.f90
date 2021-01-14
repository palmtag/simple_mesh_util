   program createhex
   use mod_input
   implicit none
!=======================================================================
!
!  Program to create GMESH input for hex mesh
!
!  Scott Palmtag
!  2019-11-15 - original version for triangles
!  2020-01-14 - convert to hex geometry
!
!  1. Run this program to generate ".geo" files
!  2. Load ".geo" file into GMSH
!  3. Mesh -> 2D  to generate 2D triangle mesh
!  4. Export -> GMSH -> Version 2.0 Ascii to save the mesh to a ".msh" file
!  5. Run the "msh2vtk" utility to convert to VTK
!
!  Usage:
!    createhex [input]
!
!-----------------------------------------------------------------------
!  GMSH Notes:
!   * You have to export to version 2 msh file, the new version is 4 and doesn't work
!        They added a lot of new information to version 4
!   * GMSH will export a VTK file, but it is only the mesh.  It doesn't contain material info.
!
!-----------------------------------------------------------------------
!  Programming Notes:
!
!    Benefits of hex is that you don't have to support partial rods on boundaries.
!    This makes clad regions much easier to handle
!
!-----------------------------------------------------------------------
!  Future work:
!    1. Reading user input instead of hardwired geometry values
!    2. Input rod maps to have different rod sizes
!    3. Investigate - it does not look like gmsh preserves the rod area?
!
!=======================================================================

      integer :: i
      integer :: ia
      integer :: nrod      ! rod counter

      character(len=200) :: fname    ! input file name

      real(8), parameter :: pi=3.1415926535897932384d0

! rod data arrays

      real(8), allocatable :: rodxy(:,:)    ! (2,numrod)  rod coordinates
      integer, allocatable :: rodtype(:)    ! (numrod)    rod types (define edge rods)

! values in input module

!!    real(8) :: xedge=4.5d0     ! number of hexes across edge of triangle (default if not read from command line)
!!    real(8) :: hflat=1.60d0    ! hexagon flat to flat distance
!!    real(8) :: rfuel=0.706d0   ! radius of fuel rod
!!    integer :: irodside  ! number of rods along triangle edge
!!    real(8) :: totedge   ! total length of one side of triangle
!!    logical :: iffull    ! flag for full rods across bottom

!--- read input file from command line

      ia=iargc()
      if (ia.ne.1) then
        stop 'usage: createhex [input]'
      endif
      call getarg(1,fname)

      fbase=fname
      i=len_trim(fbase)    ! remove suffix
      if (i.gt.4) then
        if (fbase(i-3:i).eq.'.inp') fbase(i-3:i)=' '
      endif

!--- read input

      call readinput(fname)

!--- count rods

      nrod=1   ! center
      do i=2, irodside
        nrod=nrod+(i-1)*6
      enddo

      write (*,*) 'number of rows of rods              ', irodside
      write (*,*) 'total number of rods in problem     ', nrod

      write (*,*) 'total hexagon area                  ', 6.0d0*totedge*totedge*0.25d0*sqrt(3.0d0)
      write (*,*) 'single rod area                     ', pi*rfuel*rfuel

      allocate (rodxy(2,nrod))
      allocate (rodtype(nrod))
      rodxy(:,:)=10000.0d0
      rodtype(:)=0

      call hexcenter(hflat, nrod, irodside, rodxy)

!--- create geo file

!d    write (*,*) 'list of rods:'
!d    do i=1, nrod
!d      write (*,100) i, rodtype(i), rodxy(:,i)
!d    enddo
!d100 format (2i4,2f12.6)

      call hexgeo(nrod, rodxy, rodtype)

      end program createhex

!=======================================================================
!
!  Subroutine to write list of rods to ".geo" file
!
!=======================================================================

      subroutine hexgeo(numrod, rodxy, rodtype)
      use mod_input, only : fbase, rfuel, rinner, totedge, apitch
      implicit none

      integer, intent(in) :: numrod   ! total number of rods
      real(8), intent(in) :: rodxy(2,numrod)  ! center coordinates
      integer, intent(in) :: rodtype(numrod)  ! rod types

!--- local


      integer :: ifl=20   ! output file unit

      integer :: j
      integer :: np       ! point number
      integer :: ir       ! region number
      integer :: nrod     ! rod counter

      integer :: nc       ! pointer for center of rod
      integer :: irline   ! rod surface number
      integer :: irline1  ! rod surface number
      integer :: np1, np2, np3, np4   ! pointers

      integer :: nos                    ! number of rod regions
      integer, allocatable :: nsave(:)  ! save rod regions to define final coolant region

      real(8) :: xc, yc
      real(8) :: rad1, rad0

!--- initialize

      nos=0    ! save rod outer surface pointer
      allocate (nsave(numrod+1))
      nsave=0

      np=0   ! number of points so far
      ir=0   ! region number so far  (lines and loops)

      open (ifl,file=trim(fbase)//'.geo')

!--- create mesh header info

      write (ifl,*)
      write (ifl,'(a)') '//  Hexagon Mesh Generator '
      write (ifl,*)
      write (ifl,'(a)') '// set characteristic length'
      write (ifl,'(a)') '// lc=0.05;'
      write (ifl,'(a)') 'lc=0.1;'
      write (ifl,*)
      write (ifl,'(a)') 'lcb=0.05;  // characteristic length on border'
      write (ifl,*)
      write (ifl,'(a)') 'General.BackgroundGradient=0; '
      write (ifl,'(a)') 'General.Color.Background={63,255,50};'

!--- loop over each fuel rod

  120 format (/,'// ==============================', &
              /,'//    define rod ',i0,1x,a/)

  130 format ('  Point(',i0,') = {',f12.8,',',f12.8,', 0, lc};')

  ! circles are defined with circle arcs - input start point, center, end point
  140 format ('  Circle(',i0,') = {',i0,',',i0,',',i0,'};')
  142 format ('  Line(',i0,') = {',i0,',',i0,'};')

  150 format ('  Line Loop(',i0,') = {',i0,3(',',i0),'};   // ',a)  ! 4 pts
! 152 format ('  Line Loop(',i0,') = {',i0,2(',',i0),'};   // ',a)  ! 3 pts
  154 format ('  Line Loop(',i0,') = {',i0,5(',',i0),'};   // ',a)  ! 6 pts

!--- write rod data

      do nrod=1, numrod

        xc=rodxy(1,nrod)
        yc=rodxy(2,nrod)

        rad1=rfuel       ! outer fuel rod   ! look up rod sizes here
        rad0=rinner      ! inner fuel rod   ! look up rod sizes here

        irline=0
        irline1=0

        write (ifl,120) nrod, 'full'

        np=np+1
        nc=np  ! save rod center point
        write (ifl,130) nc, xc, yc

! inside fuel

        if (rad0.gt.0.0d0) then    ! check if inner region
          write (ifl,*)
          np=np+1
          np1=np  ! save
          write (ifl,130) np, xc-rad0, yc      ! left point on curve
          np=np+1
          np2=np  ! save
          write (ifl,130) np, xc, yc+rad0      ! top  point on curve
          np=np+1
          np3=np  ! save
          write (ifl,130) np, xc+rad0, yc      ! right point on curve
          np=np+1
          np4=np  ! save
          write (ifl,130) np, xc, yc-rad0      ! bott  point on curve

          ir=ir+1
          write (ifl,140) ir, np1, nc, np2     ! fuel circles
          ir=ir+1
          write (ifl,140) ir, np2, nc, np3
          ir=ir+1
          write (ifl,140) ir, np3, nc, np4
          ir=ir+1
          write (ifl,140) ir, np4, nc, np1

          ir=ir+1
          irline1=ir
          write (ifl,150) irline1, ir-4, ir-3, ir-2, ir-1, 'inside fuel rod surface'
          write (ifl,*)

        endif  ! rad0

! outer clad or fuel region

        np=np+1
        np1=np  ! save
        write (ifl,130) np, xc-rad1, yc      ! left point on curve
        np=np+1
        np2=np  ! save
        write (ifl,130) np, xc, yc+rad1      ! top  point on curve
        np=np+1
        np3=np  ! save
        write (ifl,130) np, xc+rad1, yc      ! right point on curve
        np=np+1
        np4=np  ! save
        write (ifl,130) np, xc, yc-rad1      ! bott  point on curve

        ir=ir+1
        write (ifl,140) ir, np1, nc, np2     ! fuel circles
        ir=ir+1
        write (ifl,140) ir, np2, nc, np3
        ir=ir+1
        write (ifl,140) ir, np3, nc, np4
        ir=ir+1
        write (ifl,140) ir, np4, nc, np1

        ir=ir+1
        irline=ir
        write (ifl,150) irline, ir-4, ir-3, ir-2, ir-1, 'fuel rod surface'

        nos=nos+1           ! only save full rods, not partial rods on boundary
        nsave(nos)=irline   ! save rod loop line to define coolant


        if (irline1.gt.0) then
          ir=ir+1
          write (ifl,160) ir, irline1
          write (ifl,230) nrod, ir    ! physical surface of last rod
          ir=ir+1
          write (ifl,162) ir, irline, irline1
          write (ifl,232) nrod, ir    ! physical surface of last rod
        else
          ir=ir+1
          write (ifl,160) ir, irline
          write (ifl,230) nrod, ir    ! physical surface of last rod
        endif

!-------------------------------------------------------------------
      enddo    ! loop over rods

  160 format ('  Plane Surface(',i0,') = {',i0,'};      // fuel region')
  162 format ('  Plane Surface(',i0,') = {',i0,",",i0,'};  // clad region')
  230 format ('  Physical Surface("RegFuel',i3.3,'")={',i0,'};')
  232 format ('  Physical Surface("RegClad',i3.3,'")={',i0,'};')

      write (ifl,'(/,a)') '//===================================================='
      write (ifl,'(a)')   '//  Define outer hex surface'
      write (ifl,*)

      xc=0.0d0    ! define outer channel box
      yc=0.0d0
      np=np+1
      np1=np  ! save spp
      write (ifl,130) np, totedge, yc   ! corner of hex
      np=np+1
      write (ifl,130) np, totedge*0.5d0, apitch*0.5d0
      np=np+1
      write (ifl,130) np,-totedge*0.5d0, apitch*0.5d0
      np=np+1
      write (ifl,130) np,-totedge, yc
      np=np+1
      write (ifl,130) np,-totedge*0.5d0,-apitch*0.5d0
      np=np+1
      write (ifl,130) np, totedge*0.5d0,-apitch*0.5d0

      ir=ir+1
      irline=ir   ! save for outerbc
      write (ifl,142) ir, np1,   np1+1   ! line
      ir=ir+1
      write (ifl,142) ir, np1+1, np1+2   ! line
      ir=ir+1
      write (ifl,142) ir, np1+2, np1+3   ! line
      ir=ir+1
      write (ifl,142) ir, np1+3, np1+4   ! line
      ir=ir+1
      write (ifl,142) ir, np1+4, np1+5   ! line
      ir=ir+1
      write (ifl,142) ir, np1+5, np1     ! line

      ir=ir+1
      write (ifl,154) ir, ir-6, ir-5, ir-4, ir-3, ir-2, ir-1, 'outer hex surface'

      nos=nos+1
      nsave(nos)=ir       ! save outer loop line

      write (ifl,'(/,a)') '//===================================================='
      write (ifl,'(a)')   '//  Define coolant region and label'

      ir=ir+1  ! surface
      if (nos.eq.1) then    ! special case for small problem
        write (ifl,255) ir, nsave(1)
      else
        write (ifl,250, advance='NO') ir, nsave(1)
        do j=2, nos-1
          write (ifl,252, advance='NO') nsave(j)
          if (mod(j,10).eq.0) write (ifl,*)  ! break line
        enddo
        j=nos
          write (ifl,254) nsave(j)
      endif

      write (ifl,260) ir

! 240 format ('  Line Loop(',i0,')={',10(i0,','))
!x244 format ('  Physical Line("CoolBnd")={',i0,',')
  246 format ('  Physical Line("OutBC")={',i0,5(',',i0),'};')
  250 format ('  Plane Surface(',i0,')={',10(i0,','))
  255 format ('  Plane Surface(',i0,')={',i0,'};')
  252 format (i0,',')
  254 format (i0,'};')
  260 format ('  Physical Surface("RegCool")={',i0,'};')

      write (ifl,*)

!--- write outer boundary of problem (boundary conditions)

      write (ifl,'(/,a)') '//===================================================='
      write (ifl,'(  a)') '//  define outer boundary of problem'
      write (ifl,*)

  ! the physical line has to be list of lines, not a line loop

      write (ifl,246) irline, irline+1, irline+2, irline+3, irline+4, irline+5

!--- close file

      close (ifl)

      write (*,'(3a)') ' finished writing geo file: ',trim(fbase),'.geo'
      write (*,'(3a)') ' gmsh ',trim(fbase), '.geo -format msh22 -2'

      return
      end subroutine hexgeo
