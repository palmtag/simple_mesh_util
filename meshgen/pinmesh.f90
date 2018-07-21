   program pinmesh
!=======================================================================
!
!   Program to (attempt to) draw a triangular mesh for a pincell
!   In progress!
!
!   Method 1 adds multiple rings of pins to fill out a circle
!      The difficulty with this method is that each ring must use the same
!      number of triangles/ring or twice the number of triangles as previous ring
!
!   Method 2 defines a hex grid in the center of the problem, then "fills out the circle"
!      Things to try: Is there space to add more than one hex element?  For each row
!         check to see how far from boundary (or nearest point on circle)
!         if greater than some criteria, connect, otherwise add mesh
!
!  Scott Palmtag
!  August 2012
!
!   Usage:
!      pinmesh {nring} {ndiv}
!        nring - number of rings in method1
!        ndiv  - number of divisions in method2 (must be multiple of 6)
!
!
!  2012/08/23 - method 2 (hex) is working
!  2012/09/19 - add output to mesh file, add material and mask arrays
!  2012/09/22 - fixed alignment of triangles in problem 1
!             - changed problem 1 to use a center octagon instead of hexagon
!  2012/09/24 - add postscript output
!             - add automatic method of doubling in method 1
!  2013/01/19 - modify mask array to be surfaces 1 and 2, instead of just outer boundary
!             - updated to use new Mod_vtklib3
!
! @version CVS $Id: pincell.f90,v 1.30 2018/07/20 22:40:39 scott Exp $
!
!=======================================================================
      use mod_vtklib3
      implicit none

      integer, parameter :: maxnode=5000   ! max node or element
      integer, parameter :: maxelem=10000   ! max node or element

      integer :: i
      integer :: nelem
      integer :: nnode
      integer :: nring     ! number of rings in method 1
      integer :: ndiv
      integer :: gg(3,maxelem)        ! node connections
      integer :: matl(maxelem)        ! element materials
      integer :: msurf(maxnode)       ! surface numbers of each node
      integer :: ringnum(maxnode)     ! node ring number
      real(8) :: x(maxnode)           ! node coordinates
      real(8) :: y(maxnode)           ! node coordinates
      real(8) :: elarea(maxelem)      ! element area
      real(8) :: rpin1, rpin2         ! outer pin radii

      real(8), allocatable  :: xi(:,:)   ! temp node coordinates

      real(8), parameter :: pi=3.1415926535897932384d0

      logical :: ifdebug=.false.

      integer :: ia         ! command line
      integer :: ln         ! command line
      integer :: istat      ! command line
      character(len=20) :: ctemp ! command line

      ringnum(:)=0
      matl(:)=-100
      msurf(:)=0

!--- define problem

      rpin1=19.0d0   ! outer radius (only used in method2)
      rpin2=20.0d0   ! outer radius
      write (*,*) 'pin radii = ', rpin1, rpin2

      nring=8     ! number of rings in method1
      ndiv=48     ! number of divisions in method2 (must be multiple of 6)

!--- read command line

      ia=command_argument_count()
      if (ia.ge.1) then
         call get_command_argument(1,ctemp,ln,istat)
         read (ctemp,*) ndiv
      endif
      if (ia.ge.2) then
         call get_command_argument(2,ctemp,ln,istat)
         read (ctemp,*) nring
         write (*,*) 'command line nring = ', nring
      endif


!============== METHOD 1 =====================================

!--- define pincell mesh with method 1 (rings of triangles)

      call pin_method1(nnode, nelem, nring, rpin2, x, y, gg, elarea, ringnum, matl, msurf, maxnode, maxelem)

!--- final edits

      write (*,*)
      write (*,*) 'final number of nodes    ', nnode
      write (*,*) 'final number of elements ', nelem
 
      if (ifdebug) then
        write (*,240)
        do i=1, nelem
          write (*,250) i, gg(:,i), elarea(i), ringnum(gg(1,i)), ringnum(gg(2,i)), ringnum(gg(3,i))
        enddo
      endif
  240 format ('    i        gg(3)      area         node_ring(3)')
  250 format (i6,' -', 3i5, f12.8, 3i6)

!--- create vtk

      allocate (xi(3,nnode))  ! temp array for call to vtklib
      do i=1, nnode
         xi(1,i)=x(i)
         xi(2,i)=y(i)
         xi(3,i)=0.0d0
      enddo

      open (22,file='pin1.vtk')
      call vtk_tri1(22, nnode, nelem, 3, xi, gg)
      call vtk_tri2(22, nnode, ringnum, 'ring-number', 'n')
      call vtk_tri2(22, nnode, msurf,'bc',       ' ')
      call vtk_tri2(22, nelem, matl, 'material', 'e')
      close (22)

      deallocate (xi)

!============== METHOD 2 ================================

      nnode=0    ! reset
      nelem=0    ! reset

      call pin_method2(ndiv, rpin1, rpin2, nnode, nelem, x, y, gg, elarea, ringnum, matl, msurf, maxnode, maxelem)

!--- final edits

      write (*,*)
      write (*,*) 'final number of nodes    ', nnode
      write (*,*) 'final number of elements ', nelem

      if (ifdebug) then
        write (*,240)
        do i=1, nelem
          write (*,250) i, gg(:,i), elarea(i), ringnum(gg(1,i)), ringnum(gg(2,i)), ringnum(gg(3,i))
        enddo
      endif

!--- create vtk

      allocate (xi(3,nnode))  ! temp array for call to vtklib
      do i=1, nnode
         xi(1,i)=x(i)
         xi(2,i)=y(i)
         xi(3,i)=0.0d0
      enddo

      open (22,file='pin2.vtk')
      call vtk_tri1(22, nnode, nelem, 3, xi, gg)
      call vtk_tri2(22, nnode, ringnum, 'row-number', 'n')
      call vtk_tri2(22, nnode, msurf,'bc',       ' ')
      call vtk_tri2(22, nelem, matl, 'material', 'e')
      close (22)

      deallocate (xi)

      end
!=======================================================================
!
!  Subroutine to compare the sum of the element areas to the expected
!  area of a circle
!
!=======================================================================
      subroutine check_area(rad, nelem, elarea)
      implicit none
      integer, intent(in) :: nelem          ! number of elements
      real(8), intent(in) :: rad            ! circle radius (unadjusted)
      real(8), intent(in) :: elarea(nelem)  ! element areas

      integer :: i
      real(8) :: xsum
      real(8), parameter :: pi=3.1415926535897932384d0

      write (*,*) 'checking area'
      xsum=0.0d0
      do i=1, nelem
         xsum=xsum+elarea(i)
      enddo
      write (*,*) ' sum of areas', xsum
      write (*,*) ' expecting   ', pi*rad*rad
      if (abs(xsum-pi*rad*rad).gt.1.0d-8) write (*,*) '*** AREA TEST FAILED'

      return
      end subroutine check_area

!=======================================================================
!
!   Subroutine to create a mesh using multiple rings of triangles
!
!   The limitation to this method is that each ring must use the same
!   number of points as the last ring, or double the points.
!   How do we automatically choose whether to double or not?
!
!=======================================================================
      subroutine pin_method1(nnode, nelem, nring, rpin, x, y, &
                gg, elarea, ringnum, matl, msurf, maxnode, maxelem)
      use mod_vtklib3, only : vtk_areatri
      implicit none

      integer, intent(in) :: maxnode, maxelem
      integer, intent(in) :: nring        ! number of rings
      real(8), intent(in) :: rpin         ! input pin radius

      integer :: nnode           ! number of nodes
      integer :: nelem           ! number of elements
      integer :: matl(maxelem)   ! element materials
      integer :: msurf(maxnode)  ! boundary conditions
      real(8) :: x(maxnode)
      real(8) :: y(maxnode)
      real(8) :: elarea(maxelem)
      integer :: ringnum(maxnode)
      integer :: gg(3,maxelem)

!--- local

      integer :: ndiv      ! number of divisions in ring
      integer :: nr        ! ring counter
      integer :: i, j
      integer :: isave
      integer :: msave
      integer :: n1, n2
      integer :: npre
      real(8) :: r2, rad, hr
      real(8) :: rdelta
      real(8) :: alpha
      real(8) :: theta

      real(8), parameter :: pi=3.1415926535897932384d0

      rdelta=rpin/dble(nring)

      matl(:)=1
      msurf(:)=0

!--- define center node

      nelem=0
      nnode=1
      x(nnode)=0.0d0
      y(nnode)=0.0d0

!--- define first ring, 6 triangles

      r2=rdelta
      ndiv=8        ! was 6
      nr=1          ! ring number
      n1=2          ! starting node on ring
      n2=n1+ndiv-1  ! ending node on ring

      alpha=2.0d0*pi/dble(ndiv)
      rad=r2/sqrt(sin(alpha)/alpha)
      write (*,*) '---------------------------------'
      write (*,*) 'ring 1'
      write (*,*) 'actual    radius ', r2
      write (*,*) 'effective radius ', rad

      isave=nnode      ! center node number

! zero degrees is to the east, move cc, like a unit circle

      theta=0.0d0
      do j=1, ndiv
        nnode=nnode+1
        x(nnode)=rad*cos(theta)
        y(nnode)=rad*sin(theta)
        theta=theta+2.0d0*pi/dble(ndiv)
        ringnum(nnode)=nr
      enddo

      do i=1, ndiv
        nelem=nelem+1
        gg(1,nelem)=isave        ! center node
        gg(2,nelem)=isave+i
        gg(3,nelem)=isave+i+1
        if (gg(3,nelem).gt.n2) gg(3,nelem)=gg(3,nelem)-ndiv
        elarea(nelem)=vtk_areatri(x(gg(1,nelem)),y(gg(1,nelem)), &
                                  x(gg(2,nelem)),y(gg(2,nelem)), &
                                  x(gg(3,nelem)),y(gg(3,nelem)))
!x      matl(nelem)=nr
      enddo

      call check_area(r2, nelem, elarea)

      hr=2.0d0*pi*r2/ndiv
      write (*,70) nr, ndiv, hr,  hr/rdelta
  70  format ('ring', i3,'  ndiv=',i3,': hr=', f10.6, 'hr/dr ', f10.6)

!--- subsequent rings (double the number of points on each ring)

      do nr=2, nring
        r2=nr*rdelta
        npre=ndiv          ! number of divisions on previous ring
        isave=nnode        ! last node on previous ring
        msave=nelem        ! last elem on previous ring

        hr=2.0d0*pi*r2/ndiv
        if (hr/rdelta.gt.0.8d0) then
           ndiv=2*ndiv     ! double the number of triangles on mesh
           hr=hr*0.5d0
        endif
        write (*,70) nr, ndiv, hr,  hr/rdelta

!!      if (nr.ne.5 .and. nr.ne.7) ndiv=2*ndiv   ! *** set double rings
!!      if (nr.lt.5) ndiv=2*ndiv                 ! *** set double rings
        write (*,*) '----------------------------------------------'
        write (*,*) 'add ring ', nr
        call addring(ndiv, npre, r2, nnode, nelem, x, y, gg, elarea, maxnode, maxelem)

        do i=isave+1, nnode   ! fill with ring number for now
          ringnum(i)=nr
        enddo

!x      if (nr.eq.nring-1) then
!x        do i=isave+1, nnode   ! set surface flags
!x          msurf(i)=1
!x        enddo
!x      endif
        if (nr.eq.nring) then
          do i=isave+1, nnode   ! set surface flags
            msurf(i)=3
          enddo
        endif

!x      do i=msave+1, nelem   ! fill material numbers
!x        matl(i)=nr
!x      enddo

        call check_area(r2, nelem, elarea)


      enddo

      return
      end subroutine pin_method1

!=======================================================================
!
!   Add an additional ring of meshes to an existing circular mesh
!
!=======================================================================
      subroutine addring(ndiv, npre, r1, nnode, nelem, x, y, gg, elarea, maxnode, maxelem)
      use mod_vtklib3, only : vtk_areatri
      implicit none

      integer, intent(in) :: ndiv   ! number of divisions in ring
      integer, intent(in) :: npre   ! number of divisions in previous ring
      real(8), intent(in) :: r1     ! ring radius (actual, not adjusted)
      integer, intent(in) :: maxnode, maxelem

      integer :: nnode   ! number of nodes
      integer :: nelem   ! number of elements
      real(8) :: x(maxnode)
      real(8) :: y(maxnode)
      real(8) :: elarea(maxelem)
      integer :: gg(3,maxelem)

!--- local

      integer :: i, j
      integer :: j1     ! inner ring node counter
      integer :: j2     ! outer ring node counter
      integer :: n1     ! starting node number for outer ring
      integer :: n2     ! ending   node number for outer ring
      integer :: nesave
      integer :: ioff
      real(8) :: alpha
      real(8) :: rad
      real(8) :: areaave
      real(8) :: theta, y0
      real(8), parameter :: pi=3.1415926535897932384d0

      nesave=nelem+1   ! save old number of elements

      n1=nnode+1       ! start node on new ring
      n2=nnode+ndiv    ! end   node on new ring

      j1=nnode-npre+1      ! inner ring start
      j2=n1                ! outer ring start

      alpha=2.0d0*pi/dble(ndiv)
      rad=r1/sqrt(sin(alpha)/alpha)
      write (*,*) 'add ring:'
      write (*,30) 'ndiv  ', ndiv, npre
      write (*,30) 'nnode ', nnode
      write (*,30) 'n1 n2 ', n1, n2, 'start/end node of outer ring'
      write (*,30) 'j1 j2 ', j1, j2, 'start of inner/outer ring'
      write (*,30) 'ne    ', nesave, 0, 'start element number outer ring' 
      write (*,*) '   alpha ', alpha
      write (*,*) '   actual    radius ', r1
      write (*,*) '   effective radius ', rad
  30  format (4x,a,2i6,2x,a)

! Is there an offset?
!   No offset to single - offset down
!
      ioff=0
      theta=0.0d0
      y0=y(j1)
      write (*,*) '   old ring started at y=', y0
      if (ndiv.eq.npre) then   ! introduces offset in angle
        if (abs(y0).lt.1.0d-6) then   ! introduce angle offset low
          theta=-pi/dble(ndiv)        ! offset in angle
          write (*,*) '   adding negative offset to angle'
        else
          ioff=-1
          write (*,*) '   adding negative offset to ring numbers'
        endif
        ! if it was already offset, keep start at zero
      else
        if (abs(y0).gt.1.0d-6) then   ! offset numbers because previous ring was offset
          ioff=-1
          write (*,*) '   adding negative offset to ring numbers'
        endif
      endif

! zero degrees is at right and move counter-clockwise (unit circle)
      do j=1, ndiv
        nnode=nnode+1
        x(nnode)=rad*cos(theta)
        y(nnode)=rad*sin(theta)
        theta=theta+2.0d0*pi/dble(ndiv)
      enddo

      if (npre.eq.ndiv) then

!--- keep the same number of divisions

        do i=1, npre      ! 2 elements per flat surface of previous ring
!!   write (*,*) ' j1 j2 ', j1, j2

          nelem=nelem+1
          gg(1,nelem)=j1
          gg(2,nelem)=j2     + ioff
          gg(3,nelem)=j2 + 1 + ioff
          if (gg(1,nelem).ge.n1) gg(1,nelem)=gg(1,nelem)-npre
          if (gg(2,nelem).lt.n1) gg(2,nelem)=gg(2,nelem)+ndiv
          if (gg(2,nelem).gt.n2) gg(2,nelem)=gg(2,nelem)-ndiv
          if (gg(3,nelem).lt.n1) gg(3,nelem)=gg(3,nelem)+ndiv
          if (gg(3,nelem).gt.n2) gg(3,nelem)=gg(3,nelem)-ndiv

          nelem=nelem+1
          gg(1,nelem)=j1
          gg(2,nelem)=j2 + 1 + ioff
          gg(3,nelem)=j1 + 1
          if (gg(1,nelem).ge.n1) gg(1,nelem)=gg(1,nelem)-npre
          if (gg(2,nelem).lt.n1) gg(2,nelem)=gg(2,nelem)+ndiv
          if (gg(2,nelem).gt.n2) gg(2,nelem)=gg(2,nelem)-ndiv
          if (gg(3,nelem).ge.n1) gg(3,nelem)=gg(3,nelem)-npre


          j1=j1+1    ! small ring number
          j2=j2+1    ! big   ring number
        enddo


      else

!--- double the number of triangles (divisions)

        if (ndiv.ne.npre*2) stop 'double divisions assertion failed'
        do i=1, npre      ! 3 elements per flat surface of previous ring

          nelem=nelem+1
          gg(1,nelem)=j1
          gg(2,nelem)=j2    + ioff
          gg(3,nelem)=j2 +1 + ioff
          if (gg(1,nelem).ge.n1) gg(1,nelem)=gg(1,nelem)-npre
          if (gg(2,nelem).lt.n1) gg(2,nelem)=gg(2,nelem)+ndiv
          if (gg(2,nelem).gt.n2) gg(2,nelem)=gg(2,nelem)-ndiv
          if (gg(3,nelem).gt.n2) gg(3,nelem)=gg(3,nelem)-ndiv

          nelem=nelem+1
          gg(1,nelem)=j1
          gg(2,nelem)=j2+1 + ioff
          gg(3,nelem)=j1+1
          if (gg(1,nelem).ge.n1) gg(1,nelem)=gg(1,nelem)-npre
          if (gg(2,nelem).gt.n2) gg(2,nelem)=gg(2,nelem)-ndiv
          if (gg(3,nelem).ge.n1) gg(3,nelem)=gg(3,nelem)-npre

          nelem=nelem+1
          gg(1,nelem)=j1+1
          gg(2,nelem)=j2+1 + ioff
          gg(3,nelem)=j2+2 + ioff
          if (gg(1,nelem).ge.n1) gg(1,nelem)=gg(1,nelem)-npre
          if (gg(2,nelem).gt.n2) gg(2,nelem)=gg(2,nelem)-ndiv
          if (gg(3,nelem).gt.n2) gg(3,nelem)=gg(3,nelem)-ndiv

          j1=j1+1    ! small ring number
          j2=j2+2    ! big   ring number
        enddo
      endif

      if (j2.ne.n2+1) stop 'j2 assertion failed'

! 250 format (2x, i6,' -', 3i5, f12.8)

!--- calculate areas

      areaave=0.0d0
      do j=nesave, nelem
        if (gg(1,j).le.0) write (*,*) '****** error gg1 element ', j
        if (gg(2,j).le.0) write (*,*) '****** error gg2 element ', j
        if (gg(3,j).le.0) write (*,*) '****** error gg3 element ', j
        elarea(j)=vtk_areatri(x(gg(1,j)),y(gg(1,j)), &
                              x(gg(2,j)),y(gg(2,j)), &
                              x(gg(3,j)),y(gg(3,j)))
        areaave=areaave+elarea(j)
      enddo

      if (nelem-nesave+1.gt.0) areaave=areaave/dble(nelem-nesave+1)

      write (*,*) '   new nnode ', nnode
      write (*,*) '   new nelem ', nelem
      write (*,*) '   new ndiv  ', ndiv
      write (*,*) '   average area in ring ', areaave

      return
      end subroutine addring

!=======================================================================
!
!  Utility to replace a node number with another, then remove
!  the old node from the grid
!
!  The final number of nodes will be reduced by 1
!
!  The x,y coordinates of the old and new node must align
!
!=======================================================================
      subroutine replace_reduce(nold, nnew, nnode, nelem, x, y, gg, ringnum, msurf, maxnode, maxelem)
      implicit none

      integer, intent(in) :: maxnode
      integer, intent(in) :: maxelem
      integer, intent(in) :: nold     ! old node number
      integer, intent(in) :: nnew     ! new node number
      integer, intent(in) :: nelem    ! number of elements

!--- output

      integer :: nnode   ! number of nodes (will be reduced)
      real(8) :: x(maxnode)
      real(8) :: y(maxnode)
      integer :: ringnum(maxnode)
      integer :: msurf  (maxnode)
      integer :: gg(3,maxelem)

!--- local

      integer :: i

!--- replace

      write (*,*) 'replacing node ', nold,' with ', nnew

      if (abs(x(nold)-x(nnew)).gt.1.0d-8) then
        write (*,*) 'xy old ', nold, x(nold), y(nold)
        write (*,*) 'xy new ', nnew, x(nnew), y(nnew)
        stop 'x values do not agree in node replace'
      endif
      if (abs(y(nold)-y(nnew)).gt.1.0d-8) then
        write (*,*) 'xy old ', nold, x(nold), y(nold)
        write (*,*) 'xy new ', nnew, x(nnew), y(nnew)
        stop 'y values do not agree in node replace'
      endif
      x(nold)=x(nnew)
      y(nold)=y(nnew)
      ringnum(nold)=ringnum(nnew)
      msurf(nold)=msurf(nnew)

      do i=1, nelem
        if (gg(1,i).eq.nold) gg(1,i)=nnew
        if (gg(2,i).eq.nold) gg(2,i)=nnew
        if (gg(3,i).eq.nold) gg(3,i)=nnew
      enddo

!--- reduce

      do i=1, nelem
        if (gg(1,i).gt.nold) gg(1,i)=gg(1,i)-1
        if (gg(2,i).gt.nold) gg(2,i)=gg(2,i)-1
        if (gg(3,i).gt.nold) gg(3,i)=gg(3,i)-1
      enddo
      nnode=nnode-1
      do i=nold, nnode
        x(i)=x(i+1)
        y(i)=y(i+1)
        ringnum(i)=ringnum(i+1)
        msurf(i)=msurf(i+1)
      enddo

      return
      end subroutine replace_reduce

!=======================================================================
!
!  Meshing method 2 - use hexagonal interior then fill in the area
!  between the hex and the circle
!
!=======================================================================
      subroutine pin_method2(ndiv, rpin1, rpin2, nnode, nelem, x, y, gg, elarea, ringnum, matl, msurf, maxnode, maxelem)
      use mod_vtklib3, only : vtk_areatri
      implicit none

      integer, intent(in) :: maxnode, maxelem
      integer, intent(in) :: ndiv     ! number of divisions of large circle (must be multiple of 6)
      real(8), intent(in) :: rpin1, rpin2  ! input inner and outer radii

!--- output

      integer :: nnode   ! number of nodes
      integer :: nelem   ! number of elements
      real(8) :: x(maxnode)
      real(8) :: y(maxnode)
      real(8) :: elarea(maxelem)
      integer :: ringnum(maxnode)
      integer :: gg(3,maxelem)
      integer :: matl(maxelem)   ! element materials
      integer :: msurf(maxnode)   ! boundary conditions

!--- local

      integer :: i, j, j1, j2
      integer :: n1, n2, nx
      integer :: nrg
      integer :: nrow
      integer :: k1, k2, k3
      integer :: korn(6)     ! corner nodes
      integer :: ilist(6)     ! corner nodes
      integer :: jring, jold
      integer :: msave, ksave
      real(8) :: rad
      real(8) :: alpha
      real(8) :: rpin
      real(8) :: theta
      real(8) :: b
      real(8) :: hxx, bxx
      real(8) :: xsum
      real(8) :: arexp  ! expected area

      integer :: ibeg(100)
      integer :: iend(100)
      integer :: jhex(ndiv+1)   ! automatic

      real(8), parameter :: pi=3.1415926535897932384d0

!--- define

      if (mod(ndiv,6).ne.0) stop 'ndiv must be divisible by 6 for hex mesh'

      if (rpin1.gt.rpin2) stop 'pin radii must be in increasing order'

      rpin=rpin1
      nelem=0
      nnode=0
      x(:)=0.0d0
      y(:)=0.0d0
      elarea(:)=-10.0d0
      ringnum(:)=-10
      gg(:,:)=0
      matl(:)=0
      msurf(:)=0

      korn(:)=0
      ibeg(:)=0
      iend(:)=0

      alpha=2.0d0*pi/dble(ndiv)
      rad=rpin/sqrt(sin(alpha)/alpha)   ! effective radius

  ! rad is also the length of side of an inscribed hex
  ! b is the "height" of the triangle
      b=rad*cos(pi/6.0d0)

      write (*,*)
      write (*,*) '============ CREATING HEX MESH ================'
      write (*,*) 'effective radius ', rad
      write (*,*) 'b     =          ', b

      write (*,*) ' b**2 + (h/2)**2 - rad**2 ', b*b + rad*rad*0.25d0 - rad*rad

      nx=ndiv/6   ! number of divisions per face
      hxx=rad/dble(nx)
      bxx=hxx*cos(pi/6.0d0)

      write (*,*) 'hxx ', hxx,' (distance on one side of small triangles)'

!!    write (*,*) 'sin pi/6 ', sin(pi/6.0d0)
!!    write (*,*) 'cos pi/6 ', cos(pi/6.0d0), sqrt(3.0d0)*0.5d0
!!    write (*,*) 'tan pi/6 ', tan(pi/6.0d0), 1.0d0/sqrt(3.0d0)

!--- define hex nodes

! top row

      nrow=1   ! global row count
      nrg=0

      nnode=nnode+1
      x(nnode)=-rad*0.5d0
      y(nnode)= b
      ringnum(nnode)=nrow
      n1=nnode    ! save starting point of row
      ibeg(nrow)=nnode
!!    write (*,*) 'initial x y ', nnode, x(nnode), y(nnode)

      do i=1, nx
        nnode=nnode+1
        x(nnode)=x(nnode-1)+hxx
        y(nnode)=y(nnode-1)
        ringnum(nnode)=nrow
      enddo
      iend(nrow)=nnode
!!    write (*,*) 'final   x y ', nnode, x(nnode), y(nnode)

!!    write (*,177) nrow, nnode, nelem, x(nnode), y(nnode)
! 177 format (' end of row', i3,'  nnode=', 2i5, 2f12.8)

!  other rows including center

      do nrg=1, nx
        nrow=nrow+1

        j1=n1   ! previous row counter
        nnode=nnode+1
        x(nnode)=x(n1)-hxx*0.5d0
        y(nnode)=y(n1)-bxx
        ringnum(nnode)=nrow
        n1=nnode    ! save starting point of row
        j2=n1   ! current row counter
        ibeg(nrow)=nnode

        if (nrg.eq.nx) then   ! y should be zero
          if (abs(y(nnode)-0.0d0).gt.1.0d-10) stop 'zero test failed'
          y(nnode)=0.0d0   ! make exact
        endif

        do i=1, nx+nrg
          nnode=nnode+1
          x(nnode)=x(nnode-1)+hxx
          y(nnode)=y(nnode-1)
          ringnum(nnode)=nrow
        enddo
        iend(nrow)=nnode

!!      write (*,177) nrow, nnode, nelem, x(nnode), y(nnode)
      enddo

!  bottom row - work backwards and make rows smaller

      do nrg=nx-1, 0, -1
        nrow=nrow+1

        j1=n1   ! previous row counter
        nnode=nnode+1
        x(nnode)=x(n1)+hxx*0.5d0
        y(nnode)=y(n1)-bxx
        ringnum(nnode)=nrow
        n1=nnode    ! save starting point of row
        j2=n1   ! current row counter
        ibeg(nrow)=nnode

        do i=1, nx+nrg
          nnode=nnode+1
          x(nnode)=x(nnode-1)+hxx
          y(nnode)=y(nnode-1)
          ringnum(nnode)=nrow
        enddo
        iend(nrow)=nnode

!!      write (*,177) nrow, nnode, nelem, x(nnode), y(nnode)
      enddo
!!    write (*,*) 'final   x y ', x(nnode), y(nnode)

      korn(1)=iend((nrow+1)/2)
      korn(2)=iend(1)
      korn(3)=ibeg(1)
      korn(4)=ibeg((nrow+1)/2)
      korn(5)=ibeg(nrow)
      korn(6)=iend(nrow)

      ringnum(korn(1))=nrow+5
      ringnum(korn(2))=nrow+5
      ringnum(korn(3))=nrow+5
      ringnum(korn(4))=nrow+5
      ringnum(korn(5))=nrow+5
      ringnum(korn(6))=nrow+5

      write (*,'(a,6i5)') ' corner nodes ', korn(:)
      write (*,*) 'beginning/end nodes of each row'
      do i=1, nrow
        write (*,'(i4,2x,2i5)') i, ibeg(i), iend(i)
      enddo

!--- define elements

      write (*,*) 'defining elements'
      do nrg=1, nx
        j1=ibeg(nrg)
        j2=ibeg(nrg+1)
        nelem=nelem+1
        gg(1,nelem)=j2
        gg(2,nelem)=j2+1
        gg(3,nelem)=j1
        j2=j2+1
        do i=1, nx+nrg-1
          nelem=nelem+1
          gg(1,nelem)=j1
          gg(2,nelem)=j1+1
          gg(3,nelem)=j2
          nelem=nelem+1
          gg(1,nelem)=j2
          gg(2,nelem)=j2+1
          gg(3,nelem)=j1+1
          j1=j1+1
          j2=j2+1
        enddo
        write (*,188) nrg, nelem
     enddo
     do nrg=nx, 1, -1
        j1=ibeg(2*nx-nrg+1)
        j2=ibeg(2*nx-nrg+2)
        do i=1, nx+nrg-1
          nelem=nelem+1
          gg(1,nelem)=j1
          gg(2,nelem)=j1+1
          gg(3,nelem)=j2
          nelem=nelem+1
          gg(1,nelem)=j2
          gg(2,nelem)=j2+1
          gg(3,nelem)=j1+1
          j1=j1+1
          j2=j2+1
        enddo
        nelem=nelem+1
        gg(1,nelem)=j1
        gg(2,nelem)=j1+1
        gg(3,nelem)=j2
        write (*,188) nrg, nelem
      enddo
  188 format ('  end of row', i3,' nelem = ', i6)

!--- calculate element areas

      xsum=0.0d0
      do i=1, nelem
        k1=gg(1,i)
        k2=gg(2,i)
        k3=gg(3,i)
        elarea(i)=vtk_areatri(x(k1), y(k1), x(k2), y(k2), x(k3), y(k3))
        xsum=xsum+elarea(i)
        if (abs(elarea(i)-elarea(1)).gt.1.0d-8) write (*,*) '***** area mismatch ****'
      enddo

      write (*,*) 'calculated area of hex = ', xsum
      arexp=3.0d0*rad*rad*cos(pi/6.0d0)                 ! 0.5d0*n*rad*rad*sin(2*pi/n)
      write (*,*) 'expected               = ', arexp
      if (abs(arexp-xsum).gt.1.0d-10) stop 'geometry assertion failed'
      arexp=bxx*hxx*0.5d0*nelem
      write (*,*) 'expected               = ', arexp
      if (abs(arexp-xsum).gt.1.0d-10) stop 'geometry assertion failed'

!--- stop here if you just need a hex mesh !!! (need to define bc)

!!    return

!--- define nodes on outer ring - note that the 6 hex corners are also on the outer ring
!---  so we will have to remove them later

      alpha=2.0d0*pi/dble(ndiv)   ! delta angle

      jring=nnode   ! offset for start of ring

      write (*,*) 'adding ring nodes'
      do i=0, ndiv-1
        nnode=nnode+1
        theta=dble(i)*alpha
        x(nnode)=rad*cos(theta)
        y(nnode)=rad*sin(theta)
        ringnum(nnode)=20
        msurf(nnode)=0            ! inner ring surface
        write (*,'(i6,2f12.8)') nnode, x(nnode), y(nnode)
      enddo

!--- define array of node numbers on surface of hexagon

      j1=0
      do nrow=nx+1, 2, -1
        j1=j1+1
        jhex(j1)=iend(nrow)
      enddo
      nrow=1
      do i=iend(nrow), ibeg(nrow), -1
        j1=j1+1
        jhex(j1)=i
      enddo
      do nrow=2, 2*nx
        j1=j1+1
        jhex(j1)=ibeg(nrow)
      enddo
      nrow=2*nx+1
      do i=ibeg(nrow), iend(nrow)
        j1=j1+1
        jhex(j1)=i
      enddo
      do nrow=2*nx, nx+2, -1
        j1=j1+1
        jhex(j1)=iend(nrow)
      enddo
!!    do i=1, ndiv
!!      write (*,*) 'jhex ', i, jhex(i)
!!    enddo
      if (j1.ne.ndiv) stop 'error counting hex surface nodes'
      jhex(j1+1)=jhex(1)  ! protect bounds when circle loops around

!--- define elements between hex and circle

      j1=0
      do nrg=1, 6  ! sides of hex
!!      write (*,*) 'begin side ', nrg
        do i=1, nx/2
          j1=j1+1      ! circle counter
          if (i.gt.1) then    ! right triangle
            nelem=nelem+1
            gg(1,nelem)=jhex(j1)
            gg(2,nelem)=j1+jring
            gg(3,nelem)=j1+jring+1
!!          write (*,*) 'nelem ', nelem, gg(:,nelem)
          endif
          nelem=nelem+1     ! left triangle
          gg(1,nelem)=jhex(j1)
          gg(2,nelem)=j1+jring+1
          gg(3,nelem)=jhex(j1+1)
!!        write (*,*) 'nelem ', nelem, gg(:,nelem)
        enddo
        do i=nx/2+1, nx   ! "flip" the triangle for last node
          j1=j1+1      ! circle counter
          nelem=nelem+1     ! left triangle
          gg(1,nelem)=jhex(j1)
          gg(2,nelem)=j1+jring
          gg(3,nelem)=jhex(j1+1)
!!        write (*,*) 'nelem ', nelem, gg(:,nelem)
          if (i.lt.nx) then
            nelem=nelem+1
            gg(1,nelem)=jhex(j1+1)
            gg(2,nelem)=j1+jring
            gg(3,nelem)=j1+jring+1
!!          write (*,*) 'nelem ', nelem, gg(:,nelem)
          endif
        enddo

        i=j1+1
        if (i.gt.ndiv) i=1   ! loop back   ! check that corners align
        if (abs(x(i+jring)-x(jhex(j1+1))).gt.1.0d-8) stop 'x assertion fail corn 2'
        if (abs(y(i+jring)-y(jhex(j1+1))).gt.1.0d-8) stop 'y assertion fail corn 2'
      enddo

!--- replace and remove 6 duplicate nodes on hex corners that are also on circle

      write (*,*) 'replacing duplicate nodes that are on hex and circle'
      do i=1, 6
        ilist(i)= jring + 1 + (i-1)*nx
      enddo
      do j=1, 6          ! old new   70 128
        jold=korn(j)
        call replace_reduce(jold, ilist(j), nnode, nelem, x, y, gg, ringnum, msurf, maxnode, maxelem)
        do i=1, 6   ! reduce temp arrays
          if (ilist(i).eq.jold) ilist(i)=ilist(j)
          if (korn (i).eq.jold) korn (i)=ilist(j)
        enddo
        do i=1, 6   ! reduce temp arrays
          if (ilist(i).gt.jold) ilist(i)=ilist(i)-1
          if (korn (i).gt.jold) korn (i)=korn (i)-1
        enddo
      enddo

!--- calculate final volumes

      do i=1, nelem
        k1=gg(1,i)
        k2=gg(2,i)
        k3=gg(3,i)
        elarea(i)=vtk_areatri(x(k1), y(k1), x(k2), y(k2), x(k3), y(k3))
      enddo
      call check_area(rpin, nelem, elarea)

      do i=1, nelem
        matl(i)=1          ! assign element materials
      enddo

!--- add another ring

      msave=nelem
      ksave=nnode
      write (*,*) ' old nnode ', nnode
      write (*,*) ' old nelem ', nelem
      write (*,*) ' old ndiv  ', ndiv
      write (*,*)

      n1=ndiv       ! previous ring 
      n2=ndiv*2     ! new      ring  (double mesh)
      call addring(n2, n1, rpin2, nnode, nelem, x, y, gg, elarea, maxnode, maxelem)

      do i=msave+1, nelem
        matl(i)=2            ! define materials to new elements in ring
      enddo
      do i=ksave+1, nnode
        msurf(i)=3            ! add boundary condition on new nodes
        ringnum(i)=21
      enddo

!--- calculate final volumes

      do i=1, nelem
        k1=gg(1,i)
        k2=gg(2,i)
        k3=gg(3,i)
        elarea(i)=vtk_areatri(x(k1), y(k1), x(k2), y(k2), x(k3), y(k3))
      enddo
      call check_area(rpin2, nelem, elarea)

      return
      end subroutine pin_method2

!=======================================================================


