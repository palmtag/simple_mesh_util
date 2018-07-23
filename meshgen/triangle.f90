   program helmholtz1
!=======================================================================
!
!  Program to write analytic solution to Helmholtz equation for
!  Equilateral Triangle
!
! @version CVS $Id: helmholtz1.f90,v 1.8 2017/12/14 16:49:27 scott Exp $
!
!=======================================================================
      use mod_vtklib3
      implicit none

      integer :: ia
      integer :: iorder=3    ! triangles
      integer :: jjmax
      integer :: nnode=0     ! number of nodes
      integer :: nelem=0     ! number of elements

      real(8), parameter :: pi=3.1415926535897932384d0
      real(8), parameter :: root3=sqrt(3.0d0)

      real(8), allocatable :: xi(:,:)    ! (3,nnode)
      integer, allocatable :: gg(:,:)    ! (iorder,nelem)

      integer, allocatable :: bc(:)      ! (nnode) boundary condition
      integer, allocatable :: matl(:)    ! (nelem) material number

      character(len=100) :: fname='tri1.vtk'
      character(len=10)  :: line

!--- read command line for size

      jjmax=10      ! number of points on edge, default

      ia=iargc()
      if (ia.gt.0) then
        call getarg(1,line)
        read (line,*) jjmax
      endif

!--- allocate arrays

      allocate (xi(3,jjmax*jjmax))   ! allocation bigger than it has to be
      allocate (gg(3,jjmax*jjmax))   ! allocation bigger than it has to be

      allocate (matl(jjmax*jjmax))
      allocate (bc(jjmax*jjmax))

      matl(:)=1

!--- build equilateral triangular mesh

      nelem=0
      nnode=0
      gg=0
      bc=0

      call build_equilateral(jjmax, xi, gg, nelem, nnode)

      fname='tri1.vtk'
      write (*,'(/,2a)') ' creating vtk file: ', trim(fname)

      open (22,file=fname)
      call vtk_tri1(22, nnode, nelem, iorder, xi, gg)
      call vtk_tri2(22, nnode, bc,    'bc',       'n')  ! nodal data
      call vtk_tri2(22, nelem, matl,  'material', 'e')   ! element data
      close (22)

!--- build isosceles triangular mesh

      nelem=0
      nnode=0
      gg=0
      bc=0

      call build_isosceles(jjmax, xi, gg, nelem, nnode)

      fname='tri2.vtk'
      write (*,'(/,2a)') ' creating vtk file: ', trim(fname)

      open (22,file=fname)
      call vtk_tri1(22, nnode, nelem, iorder, xi, gg)
      call vtk_tri2(22, nnode, bc,    'bc',       'n')  ! nodal data
      call vtk_tri2(22, nelem, matl,  'material', 'e')   ! element data
      close (22)

!--- build 30/60/90 triangular mesh

      nelem=0
      nnode=0
      gg=0
      bc=0

      call build_306090(jjmax, xi, gg, nelem, nnode)

      fname='tri3.vtk'
      write (*,'(/,2a)') ' creating vtk file: ', trim(fname)

      open (22,file=fname)
      call vtk_tri1(22, nnode, nelem, iorder, xi, gg)
      call vtk_tri2(22, nnode, bc,    'bc',       'n')  ! nodal data
      call vtk_tri2(22, nelem, matl,  'material', 'e')   ! element data
      close (22)

!--- finish

      deallocate (xi,gg)
      deallocate (bc)
      deallocate (matl)
      end

!=======================================================================
      subroutine build_equilateral(jjmax, xi, gg, nelem, nnode)
      implicit none
      integer, intent(in)  :: jjmax    ! number of points per side
      integer, intent(out) :: nelem    ! number of elements
      integer, intent(out) :: nnode    ! number of nodes
      real(8), intent(out) :: xi(3,jjmax*jjmax)  ! xyz points
      integer, intent(out) :: gg(3,jjmax*jjmax)  ! element map

      integer :: i, j, ii
      real(8) :: delx
      real(8) :: dely
      real(8) :: x, y, x1

      write (*,*)
      write (*,*) 'building equilateral triangle mesh'
      write (*,*) 'number of points along edge ', jjmax

      delx=1.0d0/dble(jjmax-1)
      dely=delx*sqrt(3.0d0)/2.0d0

      y=0.0d0

      x1=0.0d0
      x=0.0d0
      y=0.0d0
      do j=1, jjmax
        x=x1
        ii=jjmax+1-j
        do i=1,ii

           nnode=nnode+1
           xi(1,nnode)=x
           xi(2,nnode)=y
           xi(3,nnode)=0.0d0
           x=x+delx

           if (i.lt.ii) then
             nelem=nelem+1
             gg(1,nelem)=nnode
             gg(2,nelem)=nnode+1
             gg(3,nelem)=nnode+ii
           endif
           if (i.lt.ii-1) then
             nelem=nelem+1
             gg(1,nelem)=nnode+1
             gg(2,nelem)=nnode+ii+1
             gg(3,nelem)=nnode+ii
           endif

        enddo
        y=y+dely
        x1=x1+delx*0.5d0    ! increment half width for start of next time
      enddo

      write (*,*) 'final nnode ', nnode
      write (*,*) 'final nelem ', nelem

!!    write (*,*) 'sqrt3/2 = ', sqrt(3.0d0)/2.0d0
!!    write (*,*) 'final x = ', xi(1,nnode)
!!    write (*,*) 'final y = ', xi(2,nnode)

      x=xi(1,nnode)
      y=xi(2,nnode)
      if (abs(x-0.5d0)            .gt.1.0d-8) stop 'error in final mesh x value'
      if (abs(y-sqrt(3.0d0)/2.0d0).gt.1.0d-8) stop 'error in final mesh y value'

      return
      end subroutine build_equilateral

!=======================================================================
      subroutine build_isosceles(jjmax, xi, gg, nelem, nnode)
      implicit none
      integer, intent(in)  :: jjmax    ! number of points per side
      integer, intent(out) :: nelem    ! number of elements
      integer, intent(out) :: nnode    ! number of nodes
      real(8), intent(out) :: xi(3,jjmax*jjmax)  ! xyz points
      integer, intent(out) :: gg(3,jjmax*jjmax)  ! element map

      integer :: i, j, ii
      real(8) :: delx
      real(8) :: dely
      real(8) :: x, y

      write (*,*)
      write (*,*) 'building isosceles triangle mesh'
      write (*,*) 'number of points along edge ', jjmax

      delx=1.0d0/dble(jjmax-1)
      dely=delx

      y=0.0d0

      x=0.0d0
      y=0.0d0
      do j=1, jjmax
        x=0.0d0
        ii=jjmax+1-j
        do i=1,ii

           nnode=nnode+1
           xi(1,nnode)=x
           xi(2,nnode)=y
           xi(3,nnode)=0.0d0
           x=x+delx

           if (i.lt.ii) then
             nelem=nelem+1
             gg(1,nelem)=nnode
             gg(2,nelem)=nnode+1
             gg(3,nelem)=nnode+ii
           endif
           if (i.lt.ii-1) then
             nelem=nelem+1
             gg(1,nelem)=nnode+1
             gg(2,nelem)=nnode+ii+1
             gg(3,nelem)=nnode+ii
           endif

        enddo
        y=y+dely
      enddo

      write (*,*) 'final nnode ', nnode
      write (*,*) 'final nelem ', nelem

!!    write (*,*) 'final x = ', xi(1,nnode)
!!    write (*,*) 'final y = ', xi(2,nnode)

      x=xi(1,nnode)
      y=xi(2,nnode)
      if (abs(x)      .gt.1.0d-8) stop 'error in final mesh x value'
      if (abs(y-1.0d0).gt.1.0d-8) stop 'error in final mesh y value'

      return
      end subroutine build_isosceles

!=======================================================================
      subroutine build_306090(jjmax, xi, gg, nelem, nnode)
      implicit none
      integer, intent(in)  :: jjmax    ! number of points per side
      integer, intent(out) :: nelem    ! number of elements
      integer, intent(out) :: nnode    ! number of nodes
      real(8), intent(out) :: xi(3,jjmax*jjmax)  ! xyz points
      integer, intent(out) :: gg(3,jjmax*jjmax)  ! element map

      integer :: i, j, ii
      real(8) :: delx
      real(8) :: dely
      real(8) :: x, y

      real(8), parameter :: root3=sqrt(3.0d0)

      write (*,*)
      write (*,*) 'building 30-60-90 triangle mesh'
      write (*,*) 'number of points along edge ', jjmax

      delx=1.0d0/dble(jjmax-1)
      dely=delx*root3

      y=0.0d0
      do j=1, jjmax
        x=0.0d0
        ii=jjmax+1-j
        do i=1,ii

           nnode=nnode+1
           xi(1,nnode)=x
           xi(2,nnode)=y
           xi(3,nnode)=0.0d0
           x=x+delx

           if (i.lt.ii) then
             nelem=nelem+1
             gg(1,nelem)=nnode
             gg(2,nelem)=nnode+1
             gg(3,nelem)=nnode+ii
           endif
           if (i.lt.ii-1) then
             nelem=nelem+1
             gg(1,nelem)=nnode+1
             gg(2,nelem)=nnode+ii+1
             gg(3,nelem)=nnode+ii
           endif

        enddo
        y=y+dely
      enddo

      write (*,*) 'final nnode ', nnode
      write (*,*) 'final nelem ', nelem

!!    write (*,*) 'sqrt3   = ', root3
!!    write (*,*) 'final x = ', xi(1,nnode)
!!    write (*,*) 'final y = ', xi(2,nnode)

      x=xi(1,nnode)
      y=xi(2,nnode)
      if (abs(x)            .gt.1.0d-8) stop 'error in final mesh x value'
      if (abs(y-sqrt(3.0d0)).gt.1.0d-8) stop 'error in final mesh y value'

      return
      end subroutine build_306090
!=======================================================================
