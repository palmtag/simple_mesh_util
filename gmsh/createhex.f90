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
!  Future work:
!    1. Input rod maps to have different rod sizes
!    2. Investigate - it does not look like gmsh preserves the rod area?
!    3. Add channel box (boxth) and outer gap
!
!=======================================================================

      integer :: i
      integer :: ia
      integer :: nrod      ! rod counter

      character(len=200) :: fname    ! input file name

      real(8), parameter :: pi=3.1415926535897932384d0

! rod data arrays

      real(8), allocatable :: rodxy(:,:)    ! (2,numrod)  rod coordinates

!--- read input file name from command line

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

!--- count rods and expand hex map

      call expand_hex_map(nrod)

      write (*,*) 'number of rows of rods  ', irodside
      write (*,*) 'total number of rods    ', nrod

      write (*,*) 'total hexagon area      ', 6.0d0*totedge*totedge*0.25d0*sqrt(3.0d0)

!--- calculate rod coordinates

      allocate (rodxy(2,nrod))
      rodxy(:,:)=10000.0d0

      call hexcenter(ppitch, nrod, irodside, rodxy)

!d    write (*,*) 'list of rods:'
!d    do i=1, nrod
!d      write (*,100) i, rodtype(i), rodxy(:,i)
!d    enddo
!d100 format (2i4,2f12.6)

!--- create geo file

      call hexgeo(nrod, rodxy)

      end program createhex

!=======================================================================
!
!  Subroutine to write list of rods to ".geo" file
!
!=======================================================================

      subroutine hexgeo(numrod, rodxy)
      use mod_input, only : fbase, pintype, totedge, apitch, matbox, matcool, hexmap
      implicit none

      integer, intent(in) :: numrod   ! total number of rods
      real(8), intent(in) :: rodxy(2,numrod)  ! center coordinates

!--- local

      integer :: ifl=20   ! output file unit

      integer :: j
      integer :: np       ! point number
      integer :: ir       ! region number
      integer :: nrod     ! rod counter
      integer :: iptype   ! pin type
      integer :: kring    ! ring loop

      integer :: nc       ! pointer for center of rod
      integer :: ibcout   ! pointer to outerBC surface
      integer :: irline   ! rod surface number
      integer :: irline1  ! rod surface number
      integer :: np1, np2, np3, np4   ! pointers

      integer :: nos                    ! number of rod outer surfaces
      integer, allocatable :: nsave(:)  ! save rod outer surface to define final coolant region

      real(8) :: xc, yc
      real(8) :: rad0

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

  130 format ('  Point(',i0,') = {',f12.8,',',f12.8,', 0, lc};')

  ! circles are defined with circle arcs - input start point, center, end point
  140 format ('  Circle(',i0,') = {',i0,',',i0,',',i0,'};')
  142 format ('  Line(',i0,') = {',i0,',',i0,'};')

  150 format ('  Line Loop(',i0,') = {',i0,3(',',i0),'};',a)  ! 4 pts
  154 format ('  Line Loop(',i0,') = {',i0,5(',',i0),'};',a)  ! 6 pts

  120 format (/,'//==============================', &
              /,'//  Define rod ',i0,/)

!--- write rod data

      do nrod=1, numrod

        xc=rodxy(1,nrod)
        yc=rodxy(2,nrod)

        iptype=hexmap(nrod)

        irline=0
        irline1=0

        write (ifl,120) nrod

        np=np+1
        nc=np  ! save rod center point
        write (ifl,130) nc, xc, yc

        irline1=0   ! previous ring

! inner fuel region

        do kring=1, pintype(iptype)%nring

          rad0=pintype(iptype)%pinrad(kring)

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
          irline=ir
          write (ifl,150) irline, ir-4, ir-3, ir-2, ir-1

          if (kring.eq.pintype(iptype)%nring) then
            nos=nos+1
            nsave(nos)=irline   ! save outer rod loop line to define coolant
          endif

          ir=ir+1
          if (irline1.eq.0) then   ! inside ring
            write (ifl,160) ir, irline, kring
            write (ifl,240) pintype(iptype)%pinmat(kring), nrod, kring, ir
          else
            write (ifl,162) ir, irline, irline1, kring
            write (ifl,240) pintype(iptype)%pinmat(kring), nrod, kring, ir
          endif
          irline1=irline  ! save for next ring

        enddo  ! kring

!-------------------------------------------------------------------
      enddo    ! loop over rods

  160 format ('  Plane Surface(',i0,') = {',i0,'};      // rod ring ',i0)
  162 format ('  Plane Surface(',i0,') = {',i0,",",i0,'};  // rod ring ',i0)
!o230 format ('  Physical Surface("RegFuel',i3.3,'")={',i0,'};')
!o232 format ('  Physical Surface("RegClad',i3.3,'")={',i0,'};')
!o260 format ('  Physical Surface("RegCool")={',i0,'};')
  240 format ('  Physical Surface("Mat',i3.3,'R',i3.3,'K',i1,'")={',i0,'};')
  244 format ('  Physical Surface("Mat',i3.3,'Cool")={',i0,'};')

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
      ibcout=ir   ! save for outerbc
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
      write (ifl,154) ir, ir-6, ir-5, ir-4, ir-3, ir-2, ir-1

      nos=nos+1
      nsave(nos)=ir       ! save outer loop line

      write (ifl,'(/,a)') '//===================================================='
      write (ifl,'(a)')   '//  Define coolant region and label'
      write (ifl,*)

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

!o    write (ifl,260) ir
      write (ifl,244) matcool, ir

  246 format ('  Physical Line("OutBC")={',i0,5(',',i0),'};')
  250 format ('  Plane Surface(',i0,')={',10(i0,','))
  255 format ('  Plane Surface(',i0,')={',i0,'};')
  252 format (i0,',')
  254 format (i0,'};')

      write (ifl,*)

!--- write outer boundary of problem (boundary conditions)

      write (ifl,'(/,a)') '//===================================================='
      write (ifl,'(  a)') '//  Define outer boundary of problem'
      write (ifl,*)

  ! the physical line has to be list of lines, not a line loop

      write (ifl,246) ibcout, ibcout+1, ibcout+2, ibcout+3, ibcout+4, ibcout+5

!--- close file

      close (ifl)

      write (*,'(3a)') ' finished writing geo file: ',trim(fbase),'.geo'
      write (*,'(3a)') ' gmsh ',trim(fbase), '.geo -format msh22 -2'
      write (*,'(3a)') ' ./msh2vtk.exe ',trim(fbase),'.msh'


      return
      end subroutine hexgeo
