   program createtri
   implicit none
!=======================================================================
!
!  Program to create GMESH input for triangle mesh
!
!  To generate different lattice sizes, change the value of "nedge" below
!
!  Scott Palmtag
!  2019-11-15 - original version
!  2019-12-05 - major revision to change orientation to support full rods along bottom
!
!  1. Run this program to generate ".geo" files
!  2. Load ".geo" file into GMSH
!  3. Mesh -> 2D  to generate 2D triangle mesh
!  4. Export -> GMSH -> Version 2.0 Ascii to save the mesh to a ".msh" file
!  5. Run the "msh2vtk" utility to convert to VTK
!
!  Usage:
!    createtri [nedge] {irodside}
!
!  where:
!    [nedge]    is the number of hex edges (flat to flat) on the boundary (length)
!    {irodside} is the number of rods along one side (partial or full) (integer) (optional)
!
!  Sample problems:
!   * trilat3.vtk   use nedge=3
!   * trilat24.vtk  use nedge=24.8   (adds boundary)
!
!  Usage Notes:
!   * You have to export to version 2 msh file, the new version is 4 and doesn't work
!        They added a lot of new information to version 4
!   * GMSH will export a VTK file, but it is only the mesh.  It doesn't contain material info.
!
!-----------------------------------------------------------------------
!  Programming Notes:
!
!    Rod numbers start at top corner, then work around boundary CCW
!    After all of the boundary rods are numbered, the center rods are numbered
!      starting in bottom left
!
!    One "tricky" part is building up list of lines around the outer coolant,
!       which does not include any boundary rods
!
!    Another tricky part is building up all the lines on the outer boundary,
!       which does include the boundary rods
!
!  Future work:
!    1. Reading user input instead of hardwired geometry values
!    2. Input rod maps to have different rod sizes
!    3. Investigate - it does not look like gmsh preserves the rod area?
!
!=======================================================================

      integer :: i
      integer :: ia
      integer :: nrod      ! rod counter
      integer :: nrodsave  ! rod counter
      integer :: irodside  ! number of rods along triangle edge
      integer :: jrow
      integer :: iend

      real(8) :: xc, yc    ! rod center coordinates
      real(8) :: totedge   ! total length of one side of triangle

      logical :: iffull    ! flag for full rods across bottom

      character(len=20) :: clopt    ! command line option

! hardwire geometry (should come from input in the future)

      real(8) :: xedge=4.5d0     ! number of hexes across edge of triangle (default if not read from command line)
      real(8) :: hflat=1.60d0    ! hexagon flat to flat distance
      real(8) :: rfuel=0.706d0   ! radius of fuel rod

      real(8), parameter :: pi=3.1415926535897932384d0

! rod data arrays

      real(8), allocatable :: rodxy(:,:)    ! (2,numrod)  rod coordinates
      integer, allocatable :: rodtype(:)    ! (numrod)    rod types (define edge rods)

!--- read number of rods across from command line (optional)

      irodside=0

      ia=iargc()
      if (ia.gt.0) then
        call getarg(1,clopt)
        read (clopt,*) xedge
        if (xedge.lt.0.999d0) stop 'minimum problem size is 1'
      endif
      if (ia.gt.1) then   ! read number of rods explicitly
        call getarg(2,clopt)
        read (clopt,*) irodside
        if (irodside.lt.2) stop 'minimum problem size is 2 rods'
      endif

      write (*,*) 'number of hexes across edge of assembly (flat to flat) = ', xedge,' (input)'

!--- initialize

      totedge=xedge*hflat

      write (*,*) 'hex size ', hflat,' (flat to flat) (hard-wire)'
      write (*,*) 'total length on one side of triangle ', totedge

      iffull=.true.
      if (irodside.eq.0) then    ! calculate size, was not input
        if (abs(xedge - nint(xedge)).lt.0.001) then
          iffull=.false.
          write (*,*) 'bottom row is split rods'
          irodside=nint(xedge)+1
        else
          write (*,*) 'bottom row is full rods'
          irodside=int(xedge)+1
        endif
      endif

!  **** need to error check that we don't partially split rods in bottom row

      nrod=(irodside*(irodside+1))/2    ! total rods in problem
      nrodsave=nrod

      write (*,*) 'number of rods across triangle edge ', irodside
      write (*,*) 'total number of rods in problem     ', nrod

      write (*,*) 'total triangle area                  ', totedge*totedge*0.25d0*sqrt(3.0d0)
      write (*,*) 'single rod area                      ', pi*rfuel*rfuel

      allocate (rodxy(2,nrod))
      allocate (rodtype(nrod))
      rodxy(:,:)=10000.0d0
      rodtype(:)=0

!--- loop over each fuel rod and determine coordinates and type of each rod
!--- Work around outer boundary fist, start at top and work counter-clockwise

      nrod=0

!--- top center corner rod (partial rod)

      nrod=nrod+1
      rodxy(1,nrod)=totedge*0.5d0
      rodxy(2,nrod)=totedge*0.5d0*sqrt(3.0d0)
      rodtype(nrod)=1

!--- rods across left side of triangle (half rods)

      do i=2, irodside        ! half rods
         nrod=nrod+1
         rodxy(1,nrod)=rodxy(1,nrod-1)-hflat*0.5d0
         rodxy(2,nrod)=rodxy(2,nrod-1)-hflat*0.5d0*sqrt(3.0d0)
         rodtype(nrod)=4      ! half rod left side
      enddo

!--- lower left rod in corner of triangle (partial rod)

      if (.not.iffull) then   ! reset corner code if it is in corner
        rodxy(1,nrod)=0.0d0
        rodxy(2,nrod)=0.0d0
        rodtype(nrod)=2       ! corner rod lower left
      endif

!--- edge rods bottom side of triangle (type 5)

      if (.not.iffull) then   ! fill half rods, otherwise skip
        do i=2, irodside-1    ! half rods
           nrod=nrod+1
           rodxy(1,nrod)=rodxy(1,nrod-1) + hflat
           rodxy(2,nrod)=rodxy(2,nrod-1)
           rodtype(nrod)=5    ! half rod on bottom
        enddo
      endif

!--- lower right rod in triangle (partial rod)

      nrod=nrod+1
      if (iffull) then
        rodxy(1,nrod)=(totedge+(irodside-1)*hflat)*0.5d0
      else
        rodxy(1,nrod)=rodxy(1,nrod-1) + hflat
      endif
      rodxy(2,nrod)=rodxy(2,nrod-1)
      if (iffull) then
        rodtype(nrod)=6   ! half rod
      else
        rodtype(nrod)=3   ! corner rod lower right
      endif

!--- edge rods right side of triangle  (type 6)

      do i=2, irodside-1     ! half rods
         nrod=nrod+1
         rodxy(1,nrod)=rodxy(1,nrod-1)-hflat*0.5d0
         rodxy(2,nrod)=rodxy(2,nrod-1)+hflat*0.5d0*sqrt(3.0d0)
         rodtype(nrod)=6     ! half rod right side
      enddo

      write (*,*) 'number of rods on boundary ', nrod

!---- full rods away from edges
!   start on top and right then down

      iend=irodside                      ! full rods on bottom
      if (.not.iffull) iend=irodside-1   ! half rods on bottom

      do jrow=3, iend
        xc=rodxy(1,jrow)
        yc=rodxy(2,jrow)
        do i=1, jrow-2        ! number of rods across in center
           xc=xc + hflat
           nrod=nrod+1
           rodxy(1,nrod)=xc
           rodxy(2,nrod)=yc
           rodtype(nrod)=0    ! full rod
         enddo
      enddo      ! jrow

!--- create geo file

      write (*,*) 'number of rods in problem  ', nrod
      if (nrod.ne.nrodsave) stop 'rod count error'

      write (*,*) 'deltax', hflat*0.5d0
      write (*,*) 'deltay', hflat*0.5d0*sqrt(3.0d0)

      write (*,*) 'list of rods:'
      do i=1, nrod
        write (*,100) i, rodtype(i), rodxy(:,i)
      enddo
  100 format (2i4,2f12.6)

      call trigeo(rfuel, nrod, rodxy, rodtype, iffull, irodside, totedge)

      end

!=======================================================================
!
!  Subroutine to write list of rods to ".geo" file
!
!=======================================================================

      subroutine trigeo(rfuel, numrod, rodxy, rodtype, iffull, irodside, totedge)
      implicit none

      real(8), intent(in) :: rfuel    ! fuel rod radii (should be array)
      integer, intent(in) :: numrod   ! total number of rods
      real(8), intent(in) :: rodxy(2,numrod)  ! center coordinates
      integer, intent(in) :: rodtype(numrod)  ! rod types
      logical, intent(in) :: iffull           ! flag for full rods across bottom
      integer, intent(in) :: irodside         ! flag for full assembly
      real(8), intent(in) :: totedge          ! total length of triangle

!--- local


      integer :: ifl=20   ! output file unit

      integer :: j
      integer :: np       ! point number
      integer :: ir       ! region number
      integer :: nrod     ! rod counter

      integer :: nc       ! pointer for center of rod
      integer :: irline   ! rod surface number
      integer :: np1, np2, np3, np4   ! pointers
      integer :: npstart              ! pointers

      integer :: nos                    ! number of rod regions
      integer :: ncool                  ! number of coolant boundary lines
      integer :: nbound                 ! number of outer boundary lines
      integer :: lastbpt                ! save last boundary point for connecting line
      integer, allocatable :: nsave(:)  ! save rod regions to define final coolant region
      integer, allocatable :: coollines(:)   ! save boundary lines for final coolant region
      integer, allocatable :: boundlines(:)  ! save boundary lines for final outer boundary

      real(8) :: xc, yc
      real(8) :: rad1

!--- initialize

      nos=0    ! save rod outer surface pointer
      allocate (nsave(numrod+1))
      nsave=0

      allocate (coollines(4*numrod))    ! over allocate
      allocate (boundlines(4*numrod))   ! over allocate
      ncool=0
      nbound=0

      np=0   ! number of points so far
      ir=0   ! region number so far  (lines and loops)

      open (ifl,file='tri.geo')

!--- create mesh header info

      write (ifl,*)
      write (ifl,'(a)') '//  Triangle Mesh Generator '
      write (ifl,*)
      write (ifl,'(a)') '// set characteristic length'
      write (ifl,'(a)') 'lc=0.2;'
      write (ifl,*)
      write (ifl,'(a)') 'General.BackgroundGradient=0; '
      write (ifl,'(a)') 'General.Color.Background={63,255,50};'
      write (ifl,*)
      write (ifl,'(a)') 'Mesh.MshFileVersion = 2.2;'

!--- loop over each fuel rod

  120 format (/,'// ==============================', &
              /,'//    define rod ',i0,1x,a/)

  130 format ('  Point(',i0,') = {',f12.8,',',f12.8,', 0, lc};')

  ! circles are defined with circle arcs - input start point, center, end point
  140 format ('  Circle(',i0,') = {',i0,',',i0,',',i0,'};')
  142 format ('  Line(',i0,') = {',i0,',',i0,'};')

  150 format ('  Line Loop(',i0,') = {',i0,',',i0,',',i0,',',i0,'};   // ',a)  ! 4 pts
  152 format ('  Line Loop(',i0,') = {',i0,',',i0,',',i0,       '};   // ',a)  ! 3 pts

!--- write rod data

      do nrod=1, numrod

        xc=rodxy(1,nrod)
        yc=rodxy(2,nrod)

        rad1=rfuel  ! fuel rod   ! look up rod sizes here

        irline=0

        if (rodtype(nrod).eq.1) then   ! top corner rod sixth

          write (ifl,120) nrod, 'upper partial rod'

          np=np+1
          nc=np  ! save rod center
          write (ifl,130) np, xc, yc
          np=np+1
          np1=np  ! save
          npstart=np  ! save starting point of boundary
          write (ifl,130) np, xc+rad1*0.5d0, yc-rad1*0.5d0*sqrt(3.0d0)  ! right point on curve
          np=np+1
          np2=np  ! save
          write (ifl,130) np, xc-rad1*0.5d0, yc-rad1*0.5d0*sqrt(3.0d0)  ! left point on curve

          ir=ir+1
          write (ifl,140) ir, np1, nc, np2    ! fuel circles
          ncool=ncool+1
          coollines(ncool)=ir  ! save circle arc for coolant boundary
          lastbpt=np2            ! save last point of boundary arc
          ir=ir+1
          write (ifl,142) ir, np2, nc         ! line
          ir=ir+1
          write (ifl,142) ir, nc, np1         ! line
          nbound=nbound+1
          boundlines(nbound)=-ir    ! save outer boundary
          nbound=nbound+1
          boundlines(nbound)=-(ir-1)    ! save outer boundary

          ir=ir+1
          irline=ir
          write (ifl,152) irline, ir-3, ir-2, ir-1, 'rod surface'

        elseif (rodtype(nrod).eq.2) then     ! lower left corner sixth rod

          write (ifl,120) nrod, 'lower left partial rod'

          np=np+1
          nc=np  ! save rod center
          write (ifl,130) np, xc, yc

          np=np+1
          np1=np  ! save
          write (ifl,130) np, xc+rad1*0.5d0, yc+rad1*0.5d0*sqrt(3.0d0)   ! top point on curve
          np=np+1
          np2=np  ! save
          write (ifl,130) np, xc+rad1, yc      ! bottom point on curve

          ir=ir+1
          write (ifl,142) ir, lastbpt, np1  ! boundary line between rods
          ncool=ncool+1
          coollines(ncool)=ir
          nbound=nbound+1
          boundlines(nbound)=ir

          ir=ir+1
          write (ifl,142) ir, nc, np1          ! line
          nbound=nbound+1
          boundlines(nbound)=-ir    ! save outer boundary
          ir=ir+1
          write (ifl,140) ir, np1, nc, np2     ! circle arc
          ncool=ncool+1
          coollines(ncool)=ir    ! save circle arc for coolant boundary
          lastbpt=np2            ! save last point of boundary arc
          ir=ir+1
          write (ifl,142) ir, np2, nc          ! line
          nbound=nbound+1
          boundlines(nbound)=-ir    ! save outer boundary

          ir=ir+1
          irline=ir
          write (ifl,152) irline, ir-3, ir-2, ir-1, 'surface for partial rod'

        elseif (rodtype(nrod).eq.3) then   ! lower right corner rod sixth

          write (ifl,120) nrod, 'lower right partial rod'

          np=np+1
          nc=np  ! save rod center
          write (ifl,130) np, xc, yc
          np=np+1
          np1=np  ! save
          write (ifl,130) np, xc-rad1, yc      ! bottom point on curve
          np=np+1
          np2=np  ! save
          write (ifl,130) np, xc-rad1*0.5d0, yc+rad1*0.5d0*sqrt(3.0d0)   ! top point on curve

          ir=ir+1
          write (ifl,142) ir, lastbpt, np1  ! boundary line between rods
          ncool=ncool+1
          coollines(ncool)=ir
          nbound=nbound+1
          boundlines(nbound)=ir

          ir=ir+1
          write (ifl,140) ir, np1, nc, np2     ! fuel circles
          ncool=ncool+1
          coollines(ncool)=ir  ! save circle arc for coolant boundary
          lastbpt=np2            ! save last point of boundary arc
          ir=ir+1
          write (ifl,142) ir, np2, nc          ! line
          ir=ir+1
          write (ifl,142) ir, nc, np1         ! line
          nbound=nbound+1
          boundlines(nbound)=-ir    ! save outer boundary
          nbound=nbound+1
          boundlines(nbound)=-(ir-1)    ! save outer boundary

          ir=ir+1
          irline=ir
          write (ifl,152) irline, ir-3, ir-2, ir-1, 'rod surface'

        elseif (rodtype(nrod).eq.5) then

          write (ifl,120) nrod, 'bottom row half rod'

          np=np+1
          nc=np  ! save rod center point for fuel
          write (ifl,130) nc, xc, yc
          np=np+1
          np1=np
          write (ifl,130) np, xc-rad1, yc   ! left
          np=np+1
          np2=np
          write (ifl,130) np, xc, yc+rad1   ! top
          np=np+1
          np3=np
          write (ifl,130) np, xc+rad1, yc   ! right

          ir=ir+1
          write (ifl,142) ir, lastbpt, np1  ! boundary line between rods
          ncool=ncool+1
          coollines(ncool)=ir
          nbound=nbound+1
          boundlines(nbound)=ir

          ir=ir+1
          write (ifl,140) ir, np1, nc, np2   ! fuel circles
          ncool=ncool+1
          coollines(ncool)=ir  ! save circle arc for coolant boundary
          ir=ir+1
          write (ifl,140) ir, np2, nc, np3
          ncool=ncool+1
          coollines(ncool)=ir  ! save circle arc for coolant boundary
          lastbpt=np3            ! save last point of boundary arc
          ir=ir+1
          write (ifl,142) ir, np3, nc    ! line
          ir=ir+1
          write (ifl,142) ir, nc,  np1   ! line
          nbound=nbound+1
          boundlines(nbound)=-ir    ! save outer boundary
          nbound=nbound+1
          boundlines(nbound)=-(ir-1)  ! save outer boundary

          ir=ir+1
          irline=ir
          write (ifl,150) irline, ir-4, ir-3, ir-2, ir-1, 'fuel rod surface'

        elseif (rodtype(nrod).eq.6) then

          write (ifl,120) nrod, 'right edge half rod'

          np=np+1
          nc=np  ! save rod center point for fuel
          write (ifl,130) nc, xc, yc
          np=np+1
          np1=np
          write (ifl,130) np, xc+rad1*0.5d0, yc-rad1*0.5d0*sqrt(3.0d0)   ! bottom
          np=np+1
          np2=np
          write (ifl,130) np, xc-rad1, yc   ! middle
          np=np+1
          np3=np
          write (ifl,130) np, xc-rad1*0.5d0, yc+rad1*0.5d0*sqrt(3.0d0)   ! top

          ir=ir+1
          write (ifl,142) ir, lastbpt, np1  ! boundary line between rods
          ncool=ncool+1
          coollines(ncool)=ir
          nbound=nbound+1
          boundlines(nbound)=ir

          ir=ir+1
          write (ifl,140) ir, np1, nc, np2   ! fuel circles
          ncool=ncool+1
          coollines(ncool)=ir  ! save circle arc for coolant boundary
          ir=ir+1
          write (ifl,140) ir, np2, nc, np3
          ncool=ncool+1
          coollines(ncool)=ir  ! save circle arc for coolant boundary
          lastbpt=np3          ! save last point of boundary arc
          ir=ir+1
          write (ifl,142) ir, np3, nc    ! line
          ir=ir+1
          write (ifl,142) ir, nc,  np1   ! line
          nbound=nbound+1
          boundlines(nbound)=-ir    ! save outer boundary
          nbound=nbound+1
          boundlines(nbound)=-(ir-1)  ! save outer boundary

          ir=ir+1
          irline=ir
          write (ifl,150) irline, ir-4, ir-3, ir-2, ir-1, 'fuel rod surface'

        elseif (rodtype(nrod).eq.4) then

          write (ifl,120) nrod, 'left edge half rod'

          np=np+1
          nc=np  ! save rod center point for fuel
          write (ifl,130) nc, xc, yc
          np=np+1
          np1=np
          write (ifl,130) np, xc+rad1*0.5d0, yc+rad1*0.5d0*sqrt(3.0d0)   ! top
          np=np+1
          np2=np
          write (ifl,130) np, xc+rad1, yc   ! middle
          np=np+1
          np3=np
          write (ifl,130) np, xc-rad1*0.5d0, yc-rad1*0.5d0*sqrt(3.0d0)   ! bottom

          ir=ir+1
          write (ifl,142) ir, lastbpt, np1  ! boundary line between rods
          ncool=ncool+1
          coollines(ncool)=ir
          nbound=nbound+1
          boundlines(nbound)=ir

          ir=ir+1
          write (ifl,140) ir, np1, nc, np2   ! fuel circles
          ncool=ncool+1
          coollines(ncool)=ir  ! save circle arc for coolant boundary
          ir=ir+1
          write (ifl,140) ir, np2, nc, np3
          ncool=ncool+1
          coollines(ncool)=ir  ! save circle arc for coolant boundary
          lastbpt=np3          ! save last point of boundary arc
          ir=ir+1
          write (ifl,142) ir, np3, nc   ! line
          ir=ir+1
          write (ifl,142) ir, nc,  np1  ! line
          nbound=nbound+1
          boundlines(nbound)=-ir    ! save outer boundary
          nbound=nbound+1
          boundlines(nbound)=-(ir-1)  ! save outer boundary

          ir=ir+1
          irline=ir
          write (ifl,150) irline, ir-4, ir-3, ir-2, ir-1, 'fuel rod surface'

        else    ! standard rod

          write (ifl,120) nrod, 'full'

          np=np+1
          nc=np  ! save rod center point
          write (ifl,130) nc, xc, yc
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

        endif

        ir=ir+1
        write (ifl,160) ir, irline
        write (ifl,230) nrod, ir    ! physical surface of last rod

!--- write straight boundary on right side of triangle iffull
!      just wrote last rod on lower boundary

        if (iffull .and. nrod.eq.irodside) then
          np=np+1
          xc=0.0d0   ! lower left  corner of triangle
          yc=0.0d0   ! lower left  corner of triangle
          np1=np
          write (ifl,130) np, xc, yc

          ir=ir+1
          write (ifl,142) ir, lastbpt, np  ! boundary line between rods
          ncool=ncool+1
          coollines(ncool)=ir
          nbound=nbound+1
          boundlines(nbound)=ir

          xc=totedge                       ! lower right corner of triangle
          yc=0.0d0
          np=np+1
          write (ifl,130) np, xc, yc

          ir=ir+1
          write (ifl,142) ir, np1, np      ! right side of triangle
          ncool=ncool+1
          coollines(ncool)=ir
          nbound=nbound+1
          boundlines(nbound)=ir

          lastbpt=np

        endif


      enddo

  160 format ('  Plane Surface(',i0,') = {',i0,'};      // fuel region')
  230 format ('  Physical Surface("RegFuel',i3.3,'")={',i0,'};')

!--- write outer box

      write (ifl,'(/,a)') '//===================================================='
      write (ifl,'(  a)') '//  define outer surface of coolant'
      write (ifl,*)

      ir=ir+1
      write (ifl,142) ir, lastbpt, npstart  ! last connecting boundary line
      ncool=ncool+1
      coollines(ncool)=ir
      nbound=nbound+1
      boundlines(nbound)=ir

      write (ifl,*)
      ir=ir+1
      write (ifl,240, advance='NO') ir, coollines(1)    ! line loop over outer coolant boundary
      do j=2, ncool-1
        write (ifl,252, advance='NO') coollines(j)
        if (mod(j,10).eq.0) write (ifl,*)  ! break line
      enddo
      j=ncool
        write (ifl,254) coollines(j)

      nos=nos+1
      nsave(nos)=ir       ! save outer loop line

! the physical line has to be list of lines, not a line loop

!--- define final surface labels
!  this is tricky because we have to write a long line of numbers that
!  can vary with the problem size

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

  240 format ('  Line Loop(',i0,')={',10(i0,','))
!x244 format ('  Physical Line("CoolBnd")={',i0,',')
  246 format ('  Physical Line("OutBC")={',i0,',')
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

      write (ifl,246, advance='NO') boundlines(1)    ! line loop over outer boundary
      do j=2, nbound-1
        write (ifl,252, advance='NO') boundlines(j)
        if (mod(j,10).eq.0) write (ifl,*)  ! break line
      enddo
      j=nbound
        write (ifl,254) boundlines(j)

!--- close file

      close (ifl)

      write (*,*) 'finished writing geo file: tri.geo'
      write (*,*) 'gmsh tri.geo -format msh22 -2'

      return
      end subroutine trigeo
