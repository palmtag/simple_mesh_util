   subroutine readvtk(fname)
   use mod_trigeom
   implicit none

      character(len=*), intent(in) :: fname

      integer :: i, j, n, i3
      integer :: jsize
      real(8) :: xtmp

      logical :: ifmat

      character(len=20)  :: c1, ctitle, c3
      character(len=100) :: line

      write (*,'(/,2a)') 'reading VTK file: ', trim(fname)

      open (22,file=fname,status='old')

!--- read header
! # vtk DataFile Version 2.0
! 3D Unstructured Grid of Linear Wedges
! ASCII

      read (22,'(a)') line
      if (line(1:22).ne.'# vtk DataFile Version') stop 'invalid header in VTK file'

      read (22,'(a)') line
      write (*,'(2a)') 'title: ', trim(line)

      read (22,'(a)') line
      if (line.ne.'ASCII') stop 'VTK file is not ASCII'

!--- read node coordinates

!  DATASET UNSTRUCTURED_GRID
!  POINTS 1862 float
!      0.000000    0.000000    0.000000
!      3.233248    5.600150    0.000000
!     -3.233248    5.600150    0.000000
!    etc.

      write (*,*) 'reading node coordinates'
      do     ! skip blanks
        read (22,'(a)') line
        if (line.ne.' ') exit
      enddo
      if (line.ne.'DATASET UNSTRUCTURED_GRID') stop 'VTK file is not UNSTRUCTURED_GRID'

      read (22,'(a)') line
      read (line,*) c1, nnode, c3
      if (c1.ne.'POINTS') stop 'vtk file missing keyword POINTS'
      if (c3.ne.'float') stop 'vtk file missing keyword float'
      write (*,*) 'nnode = ', nnode

      allocate (xi(3,nnode))
      read (22,*) ((xi(i,n),i=1,3),n=1,nnode)

!--- read cells

!   CELLS 289 1156
!   3     0     2     1
!   3     3     4     5
!   3     3     5     1
!   3     8     7    11
!  etc.

      do          ! skip blanks
        read (22,'(a)') line
        if (line.ne.' ') exit
      enddo
      if (line(1:5).ne.'CELLS') stop 'VTK file missing CELLS'
      read (line,*) c1, nelem, i3
      if (c1.ne.'CELLS') stop 'vtk file missing keyword CELLS'
      write (*,*) 'nelem = ', nelem

      allocate (gg(iorder,nelem))
      allocate (matelem(nelem))   ! materials
      matelem(:)=1
      nmat=1

      do n=1, nelem
        read (22,*) j,(gg(i,n),i=1,iorder)
        if (j.ne.iorder) stop 'non-triangle element found, only iorder=3 supported'
      enddo

!--- convert indexes from zero-based to one-based

      do n=1, nelem
        do i=1, iorder
           gg(i,n)=gg(i,n)+1
           if (gg(i,n).le.0) stop 'bad element index'
           if (gg(i,n).gt.nnode) stop 'bad element index'
        enddo
      enddo

!--- read cell types (not used)

!   CELL_TYPES 624
!    5
!    5
!    etc.

      do          ! skip blanks
        read (22,'(a)') line
        if (line.ne.' ') exit
      enddo
      if (line(1:10).ne.'CELL_TYPES') stop 'VTK file missing CELL_TYPES'
      read (line,*) c1, i3
      if (c1.ne.'CELL_TYPES') stop 'vtk file missing keyword CELL_TYPES'
      if (i3.ne.nelem) stop 'error in CELL_TYPES size'

      read (22,*) (j,i=1,nelem)   ! should check for type 5

!--- read point data or cell data

      jsize=0   ! must read point data or cell data first to set
      ifmat=.false.   ! flag for material array

      do

        do          ! skip blanks
          read (22,'(a)',end=100) line
          if (line.ne.' ') exit
        enddo

        if (line(1:10).eq.'POINT_DATA') then
           write (*,*) 'reading POINT_DATA'
           read (line,*) c1, i3
           if (c1.ne.'POINT_DATA') stop 'vtk file missing keyword POINT_DATA'
           if (i3.ne.nnode) stop 'error in POINT_DATA size'
           jsize=nnode
           read (22,'(a)') line
        endif
        if (line(1:10).eq.'CELL_DATA ') then
           write (*,*) 'reading CELL_DATA'
           read (line,*) c1, i3
           if (c1.ne.'CELL_DATA') stop 'vtk file missing keyword CELL_DATA'
           if (i3.ne.nelem) stop 'error in CELL_DATA size'
           jsize=nelem
           read (22,'(a)') line
        endif

        if (line(1:7).ne.'SCALARS') stop 'VTK file missing SCALARS'
        read (line,*) c1, ctitle, c3
        if (c1.ne.'SCALARS') stop 'vtk file missing keyword SCALARS'
        write (*,'(1x,2a)') 'reading point data: ', trim(ctitle)
        if (c3.ne.'float') stop 'vtk file missing keyword float'

        read (22,'(a)') line
        if (line(1:12).ne.'LOOKUP_TABLE') stop 'VTK file missing LOOKUP_TABLE'

        if (jsize.eq.0) stop 'did not find cell or point data on vtk file'

        if (ctitle.eq.'material') then
          read (22,*) (matelem(i),i=1,jsize)
        else
          read (22,*) (xtmp,i=1,jsize)
        endif

      enddo

  100 continue
      close (22)
      write (*,*) 'finished reading VTK file'

!--- find number of materials in mesh

      do i=1, nelem
        nmat=max(nmat,matelem(i))
      enddo
      write (*,*) 'number of materials found ', nmat

      return
      end subroutine readvtk
