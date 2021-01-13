   program square
!=======================================================================
!
!  Program to write 2D square mesh using triangles
!
!  2018/06/19 - original program
!
!  Usage:  square {num}
!    num - number of nodes along one edge
!
!=======================================================================
      use mod_vtklib3
      implicit none

      integer :: i
      integer :: ia
      integer :: iorder=3    ! triangles
      integer :: jjmax
      integer :: nnode=0     ! number of nodes
      integer :: nelem=0     ! number of elements

      real(8) :: width
      real(8) :: vsum
      real(8) :: xmax, xmin, ymax, ymin

      real(8), allocatable :: elarea(:)  ! (nelem)   element areas
      real(8), allocatable :: xi(:,:)    ! (3,nnode)
      integer, allocatable :: gg(:,:)    ! (iorder,nelem)
      integer, allocatable :: ibc(:)     ! (nnode)    boundary condition flag
      integer, allocatable :: imat(:)    ! (nelem)    material number
      integer, allocatable :: ihex(:)    ! (nelem)    hex (square) number

      character(len=100) :: fname='square.vtk'
      character(len=10)  :: line

!--- read command line for size

      jjmax=50      ! number of points on edge, default

      ia=iargc()
      if (ia.gt.0) then
        call getarg(1,line)
        read (line,*) jjmax
      endif

!--- build square mesh

      nnode=(jjmax+1)**2
      nelem=2*jjmax*jjmax

      width=100.0d0     ! length of side of square

      write (*,*) 'nnode = ', nnode
      write (*,*) 'nelem = ', nelem

      allocate (xi(3,nnode))   ! x,y,z locations of each node
      allocate (gg(3,nelem))   ! map nodes to element
      allocate (ibc(nnode))    ! boundary conditions
      allocate (imat(nelem))   ! materials for each element
      allocate (ihex(nelem))   ! "hex number" for each element

      imat(:)=1
      ibc(:)=0

      call build_square(jjmax, nelem, nnode, width, xi, gg, ibc, ihex)

!--- calculate element volumes (sanity checks)

      write (*,*)
      write (*,*) 'calculating element volumes'

      allocate (elarea(nelem))

      vsum=0.0d0
      do i=1, nelem
!d      write (*,'(4i4)') i, gg(:,i)
        elarea(i)=vtk_areatri(xi(1,gg(1,i)),xi(2,gg(1,i)), &
                          xi(1,gg(2,i)),xi(2,gg(2,i)), &
                          xi(1,gg(3,i)),xi(2,gg(3,i)))
        vsum=vsum+elarea(i)
      enddo

      i=1
        xmax=xi(1,i)
        xmin=xi(1,i)
        ymax=xi(2,i)
        ymin=xi(2,i)
      do i=2, nnode
        xmax=max(xmax,xi(1,i))
        xmin=min(xmin,xi(1,i))
        ymax=max(ymax,xi(2,i))
        ymin=min(ymin,xi(2,i))
      enddo

      write (*,*)
      write (*,*) 'x min max ', xmin, xmax
      write (*,*) 'y min max ', ymin, ymax
      write (*,*) 'total volume = ', vsum
      write (*,*)

!--- write mesh to VTK file

      write (*,'(/,2a)') ' creating vtk file: ', trim(fname)

      open (22,file=fname)
      call vtk_tri1(22, nnode, nelem, iorder, xi, gg)

      call vtk_tri2(22, nnode, ibc,  'bc',       'n')  ! nodal data
      call vtk_tri2(22, nelem, imat, 'material', 'e')  ! element data
      call vtk_tri2(22, nelem, ihex, 'hexnum',   ' ')  ! hex number
      close (22)

!--- finish

      write (*,*) 'deallocate'
      deallocate (xi,gg)
      deallocate (ibc)
      deallocate (imat)

      end

!=======================================================================
      subroutine build_square(jjmax, nelem, nnode, width, xi, gg, ibc, ihex)
      implicit none
      integer, intent(in)  :: jjmax    ! number of points per side
      integer, intent(in)  :: nelem    ! number of elements
      integer, intent(in)  :: nnode    ! number of nodes
      real(8), intent(in)  :: width    ! width of one side of square
      real(8), intent(out) :: xi(3,nnode)   ! xyz points
      integer, intent(out) :: gg(3,nelem)   ! element map
      integer, intent(out) :: ibc(nnode)    ! boundary conditions
      integer, intent(out) :: ihex(nelem)   ! hex number

      integer :: i, j
      integer :: ne      ! element counter
      integer :: nn      ! node counter
      real(8) :: delx
      real(8) :: x, y

      write (*,*)
      write (*,*) 'building square mesh of triangles'
      write (*,*) 'number of points along edge ', jjmax

      ibc(:)=0

      delx=width/dble(jjmax)  ! mesh width

      nn=0
      ne=0

      y=0.0d0
      do j=0, jjmax
        x=0.0d0
        do i=0,jjmax

           nn=nn+1
           xi(1,nn)=x
           xi(2,nn)=y
           xi(3,nn)=0.0d0
           x=x+delx

           if (i.eq.0) ibc(nn)=3
           if (j.eq.0) ibc(nn)=3
           if (i.eq.jjmax) ibc(nn)=3
           if (j.eq.jjmax) ibc(nn)=3

           if (i.ne.0 .and. y.ne.0) then    ! first nn is 11
             ne=ne+1
             gg(1,ne)=nn-jjmax-2
             gg(2,ne)=nn-jjmax-1
             gg(3,ne)=nn-1

             ihex(ne)=(i-1)*jjmax+j

             ne=ne+1
             gg(1,ne)=nn-1
             gg(2,ne)=nn-jjmax-1
             gg(3,ne)=nn

             ihex(ne)=ihex(ne-1)
           endif
        enddo

        y=y+delx
      enddo

      if (nn.ne.nnode) stop 'nnode error in square_build'
      if (ne.ne.nelem) stop 'nelem error in square_build'

      return
      end subroutine build_square
!=======================================================================
