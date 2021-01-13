   program cube
!=======================================================================
!
!  Program to write 3D cube of wedge meshes
!
!  2020/07/15 - original program
!
!  Usage:  cube {num}
!    num - number of nodes along one edge
!
!=======================================================================
      use mod_vtklib3
      implicit none

      integer :: i
      integer :: ia
      integer :: iorder=6    ! wedges
      integer :: jjmax
      integer :: nnode=0     ! number of nodes
      integer :: nelem=0     ! number of elements
      integer :: nbnd        ! number of boundary nodes

      real(8) :: width=10.0d0   ! length of one side
      real(8) :: dz
      real(8) :: vsum
      real(8) :: xmax, xmin, ymax, ymin, zmax, zmin

      real(8), allocatable :: elarea(:)  ! (nelem)   element areas
      real(8), allocatable :: xi(:,:)    ! (3,nnode)
      integer, allocatable :: gg(:,:)    ! (iorder,nelem)
      integer, allocatable :: ibc(:)     ! (nnode)    boundary condition flag
      integer, allocatable :: imat(:)    ! (nelem)    material number
      integer, allocatable :: ihex(:)    ! (nelem)    hex (square) number

      character(len=100) :: fname='cube.vtk'
      character(len=10)  :: line

!--- read command line for size

      jjmax=10      ! number of points on edge, default

      ia=iargc()
      if (ia.gt.0) then
        call getarg(1,line)
        read (line,*) jjmax
      endif

!--- build square mesh

      nnode=(jjmax+1)**3
      nelem=2*jjmax*jjmax*jjmax

      write (*,*) 'nnode = ', nnode
      write (*,*) 'nelem = ', nelem

      allocate (xi(3,nnode))       ! x,y,z locations of each node
      allocate (gg(iorder,nelem))  ! map nodes to element
      allocate (ibc(nnode))        ! boundary conditions
      allocate (imat(nelem))       ! materials for each element
      allocate (ihex(nelem))       ! "hex number" for each element

      imat(:)=1
      ibc(:)=0

      call build_cube(jjmax, nelem, nnode, iorder, width, xi, gg, ibc, ihex)

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
        dz=xi(3,gg(4,i))-xi(3,gg(1,i))   ! assumes right wedge
        vsum=vsum+elarea(i)*dz
      enddo

      i=1
        xmax=xi(1,i)
        xmin=xi(1,i)
        ymax=xi(2,i)
        ymin=xi(2,i)
        zmax=xi(3,i)
        zmin=xi(3,i)
      do i=2, nnode
        xmax=max(xmax,xi(1,i))
        xmin=min(xmin,xi(1,i))
        ymax=max(ymax,xi(2,i))
        ymin=min(ymin,xi(2,i))
        zmax=max(zmax,xi(3,i))
        zmin=min(zmin,xi(3,i))
      enddo

      nbnd=0  ! number of boundary nodes
      do i=1, nnode
        if (ibc(i).ne.0) nbnd=nbnd+1
      enddo

      write (*,*)
      write (*,*) 'x min max ', xmin, xmax
      write (*,*) 'y min max ', ymin, ymax
      write (*,*) 'z min max ', zmin, zmax
      write (*,*) 'total volume = ', vsum
      write (*,*) 'number of boundary nodes = ', nbnd
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
      subroutine build_cube(jjmax, nelem, nnode, iorder, width, xi, gg, ibc, ihex)
      implicit none
      integer, intent(in)  :: jjmax    ! number of points per side
      integer, intent(in)  :: nelem    ! number of elements
      integer, intent(in)  :: nnode    ! number of nodes
      integer, intent(in)  :: iorder   ! element order (6 for wedges)
      real(8), intent(in)  :: width    ! width of one side of cube
      real(8), intent(out) :: xi(3,nnode)   ! xyz points
      integer, intent(out) :: gg(iorder,nelem)   ! element map
      integer, intent(out) :: ibc(nnode)    ! boundary conditions
      integer, intent(out) :: ihex(nelem)   ! hex number

      integer :: i, j, k
      integer :: ne      ! element counter
      integer :: nn      ! node counter
      integer :: nesave  ! number of elements in one plane
      integer :: nnsave  ! number of nodes in one plane
      real(8) :: delx
      real(8) :: x, y, z

      write (*,*)
      write (*,*) 'building cube mesh of wedges'
      write (*,*) 'number of points along edge ', jjmax

      if (iorder.ne.6) stop 'error: iorder must be 6 for wedge elements'

      ibc(:)=0

      delx=width/dble(jjmax)  ! mesh width

!--- build first layer (square)

      nn=0
      ne=0

      z=0.0d0
      y=0.0d0
      do j=0, jjmax
        x=0.0d0
        do i=0,jjmax

           nn=nn+1
           xi(1,nn)=x
           xi(2,nn)=y
           xi(3,nn)=z
           x=x+delx

!bc        if (i.eq.0) ibc(nn)=3
!bc        if (j.eq.0) ibc(nn)=3
!bc        if (i.eq.jjmax) ibc(nn)=3
!bc        if (j.eq.jjmax) ibc(nn)=3

           if (i.ne.0 .and. y.ne.0) then    ! first nn is 11
             ne=ne+1
             gg(1,ne)=nn-jjmax-2       ! bottom layer
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

      nesave=ne
      nnsave=nn

      do i=1, nesave      ! fill top nodes of bottom plane elements
        gg(4,i)=gg(1,i)+nnsave
        gg(5,i)=gg(2,i)+nnsave
        gg(6,i)=gg(3,i)+nnsave
      enddo

!--- extrude to 3D

      do k=1, jjmax
        z=z+delx
        do i=1, nnsave
          nn=nn+1
          xi(1,nn)=xi(1,nn-nnsave)
          xi(2,nn)=xi(2,nn-nnsave)
          xi(3,nn)=z
          ibc(nn)=ibc(nn-nnsave)
        enddo
      enddo
      if (nn.ne.nnode) stop 'nnode error in build_cube'

      do k=2, jjmax
        do i=1, nesave
          ne=ne+1
          gg(1,ne)=gg(1,ne-nesave)+nnsave
          gg(2,ne)=gg(2,ne-nesave)+nnsave
          gg(3,ne)=gg(3,ne-nesave)+nnsave
          gg(4,ne)=gg(4,ne-nesave)+nnsave
          gg(5,ne)=gg(5,ne-nesave)+nnsave
          gg(6,ne)=gg(6,ne-nesave)+nnsave
          ihex(ne)=ihex(ne-nesave)
        enddo
      enddo
      if (ne.ne.nelem) stop 'nelem error in build_cube'

      do i=1, ne
        if (gg(1,ne).le.0) stop 'negative gg'
        if (gg(2,ne).le.0) stop 'negative gg'
        if (gg(3,ne).le.0) stop 'negative gg'
        if (gg(4,ne).le.0) stop 'negative gg'
        if (gg(5,ne).le.0) stop 'negative gg'
        if (gg(6,ne).le.0) stop 'negative gg'
      enddo

!--- fix top and bottom bc

!  **** todo: make bc at top and bottom 3

!bc   do i=1, nnsave
!bc     ibc(nn)=3     ! bottom plane
!bc   enddo 
!bc   do i=nnode-nnsave+1, nnode
!bc     ibc(nn)=3     ! top plane
!bc   enddo 


      return
      end subroutine build_cube
!=======================================================================
