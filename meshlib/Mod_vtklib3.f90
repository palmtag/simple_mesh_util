   module mod_vtklib3
!=======================================================================
!
! Create Triangle VTK file
! VTK files can be read by paraview or visit
!
! @version CVS $Id: Mod_vtklib3.f90,v 1.17 2020/05/04 02:24:10 palmtag Exp $
!
!  VTK file formats:
!    www.vtk.org/VTK/img/file-formats.pdf
!
!  Sample triangular mesh:
!     http://people.sc.fsu.edu/~jburkardt/data/vtk/triangle_mesh_linear.vtk
!
!  2012/08/12 - sample triangular meshes working with VISIT
!  2012/09/18 - generalize to handle 3-point or 6-point triangles
!
!  2015/04/25 - extend xi array to be dimension 3
!             - add xyz subroutines
!             - convert to generic interfaces
!
!  2015/05/11 - add STL writer
!
!  2017/09/10 - found problem in header
!               itri=6 needs type 22 (QUADRATIC_TRIANGLE) for CFD code
!               itri=6 needs type 13 (VTK_WEDGE) for visualization
!      *** need to add new argument ***
!
!  2018/04/16 - added option for VTK_QUAD
!
!  2018/07/20 - added subroutine to calculate area of triangle
!
!  2020/05/03 - print integer distributions as type "int" instead of "float"
!
!=======================================================================
!
!     write (*,*)
!     write (*,*) 'Helpful hints on running Paraview:'
!     write (*,*) '  1. Open VTK file'
!     write (*,*) '  2. Press the green "Apply" button in middle of left pane'
!     write (*,*) '  3. At the top pulldown, change "Outline" to "WireFrame"'
!     write (*,*) '  4. After that, you can change "Solid Color" to distribution you want to plot'
!     write (*,*)
!
!=======================================================================

      public :: vtk_tri2        ! generic interface
      public :: vtk_xyz2        ! generic interface
      public :: stlwrite        ! generic interface
      public :: vtk_areatri

      private:: vtk_tri2_real8, vtk_tri2_int
      private:: vtk_xyz2_real8, vtk_xyz2_int

      interface vtk_tri2
        module procedure vtk_tri2_real8, vtk_tri2_int
      end interface vtk_tri2

      interface vtk_xyz2
        module procedure vtk_xyz2_real8, vtk_xyz2_int
      end interface vtk_xyz2

      contains
!
!=======================================================================
!
!  Print VTK header information for trianglar mesh file
!
!  Must be triangles
!  gg() does not have 0 element
!  xi() is dimension 3
!
!  See routine below for hexahedron mesh
!
!=======================================================================
      subroutine vtk_tri1(iovtk, nnode, nelem, itri, xi, gg)
      implicit none
      integer, intent(in) :: iovtk             ! vtk file unit (already opened)
      integer, intent(in) :: nnode             ! number of nodes
      integer, intent(in) :: nelem             ! number of elements
      integer, intent(in) :: itri              ! triangle order (3 or 6 or 4 or 8)
      real(8), intent(in) :: xi(3,nnode)
      integer, intent(in) :: gg(itri,nelem)    ! elemement connections

!--- local

      integer :: i, j
      integer :: jtype

!--- open VTK file

! 2nd line is title

      write (*,'(/,2a)') ' creating VTK header'
      if     (itri.eq.4) then
        write (iovtk,80) 'Quads'
      elseif (itri.eq.6) then
        write (iovtk,80) 'Wedges'
      elseif (itri.eq.8) then
        write (iovtk,80) 'Hexahedrons'
      else
        write (iovtk,80) 'Triangles'
      endif
   80 format ('# vtk DataFile Version 2.0', &
            /,'3D Unstructured Grid of Linear ',a, &
            /,'ASCII')

!--- write node coordinates

      write (iovtk,120) nnode
  120 format (/,'DATASET UNSTRUCTURED_GRID', &
              /,'POINTS ',i0,' float')
  125 format (3f12.6)
! 125 format (2f12.6,' 0.0')        ! use this for 2D arrays
      do i=1, nnode
         write (iovtk,125) xi(1,i), xi(2,i), xi(3,i)    ! node coordinates
      enddo

!--- write cells/elements

      write (iovtk,140) nelem, (1+itri)*nelem
  140 format (/,'CELLS ',i0,1x,i0)
  145 format (i1,8i6)
  146 format (i1,8(1x,i0))

      if (nnode.lt.100000) then
         do i=1, nelem
            write (iovtk,145) itri, (gg(j,i)-1,j=1,itri)  ! node numbers are zero based
         enddo
      else      ! needed for large mesh
         do i=1, nelem
            write (iovtk,146) itri, (gg(j,i)-1,j=1,itri)  ! node numbers are zero based
         enddo
      endif

      if (itri.eq.3) then
        jtype=5                  ! triangle
      elseif (itri.eq.4) then
        jtype=9                  ! vtk_quad
      elseif (itri.eq.6) then
!old    jtype=22                 ! vtk_quadratic_triangle (for CFD code)
        jtype=13                 ! vtk_wedge
      elseif (itri.eq.8) then
        jtype=12                 ! vtk_hexahedron
      else
        stop 'invalid triangle type in vtk_tri1'
      endif

      write (iovtk,160) nelem
  160 format (/,'CELL_TYPES ',i0)
      do i=1, nelem
         write (iovtk,'(i0)') jtype
      enddo

!   POINT_DATA  or CELL_DATA written in other subroutines

      return
      end subroutine vtk_tri1

!=======================================================================
!
!  Print VTK header information 3D triangles/hexagons
!
!   xi dimensioned (1:3) for 3D elements
!   gg dimensioned (0:8) to allow for triangles or hexes
!   gg(0,:) contains the element type - 6 or 8
!
!=======================================================================
      subroutine vtk_tri3d1(iovtk, nnode, nelem, xi, gg)
      implicit none
      integer, intent(in) :: iovtk           ! vtk file unit (already opened)
      integer, intent(in) :: nnode           ! number of nodes
      integer, intent(in) :: nelem           ! number of elements
      real(8), intent(in) :: xi(3,nnode)
      integer, intent(in) :: gg(0:8,nelem)   ! elemement connections

!--- local

      integer :: i, j
      integer :: isum, itype

!--- open VTK file

! 2nd line is title

      write (*,'(/,2a)') ' creating VTK header'
      write (iovtk,80)
   80 format ('# vtk DataFile Version 1.0', &
            /,'3D Unstructured Grid of VERA Geometry', &
            /,'ASCII')

!--- write node coordinates

      write (iovtk,120) nnode
  120 format (/,'DATASET UNSTRUCTURED_GRID', &
              /,'POINTS',i10,' float')
  125 format (3f12.6)
      do i=1, nnode
         write (iovtk,125) xi(1:3,i)    ! node coordinates, 2D version hardwired 0.0 for 3rd point
      enddo

!--- write cells/elements
      isum=0
      do i=1, nelem
        isum=isum+1+gg(0,i)
      enddo

      write (iovtk,140) nelem, isum
  140 format (/,'CELLS ',i0,1x,i0)
  145 format (i1,8(1x,i0))
      do i=1, nelem
        itype=gg(0,i)
        write (iovtk,145) itype, (gg(j,i)-1,j=1,itype)  ! node numbers are zero based
      enddo

      write (iovtk,160) nelem
  160 format (/,'CELL_TYPES ',i0)
      do i=1, nelem
         itype=gg(0,i)
         if     (itype.eq.6) then
           write (iovtk,'(i0)') 13   ! 3D triangle wedge - VTK_WEDGE
         elseif (itype.eq.8) then
           write (iovtk,'(i0)') 12   ! 3D hexahedron     - VTK_HEXAHEDRON
         else
           stop 'invalid element type'
         endif
      enddo

!   POINT_DATA  or CELL_DATA written in other subroutines

      return
      end subroutine vtk_tri3d1

!=======================================================================
!
!  Print VTK header information for XYZ mesh file
!
!=======================================================================
      subroutine vtk_xyz1(iovtk, nnode, xi)
      implicit none
      integer, intent(in) :: iovtk             ! vtk file unit (already opened)
      integer, intent(in) :: nnode             ! number of nodes
      real(8), intent(in) :: xi(3,nnode)

!--- local

      integer :: i

!--- open VTK file

! 2nd line is title

      write (*,'(/,2a)') ' creating VTK header'
      write (iovtk,80)
   80 format ('# vtk DataFile Version 2.0', &
            /,'3D Unstructured Grid of Linear Triangles', &
            /,'ASCII')

!--- write node coordinates

      write (iovtk,120) nnode
  120 format ('DATASET POLYDATA', &
            /,'POINTS ',i0,' float')
  125 format (3f12.6)
      do i=1, nnode
         write (iovtk,125) xi(1,i), xi(2,i), xi(3,i)    ! node coordinates
      enddo

!   POINT_DATA  written in other subroutines

      return
      end subroutine vtk_xyz1
!=======================================================================
!
!  Print data output to VTK file so that it can be read by ParaView
!
!  This subroutine prints POINT_DATA.  VTK also supports CELL_DATA.
!
!  This subroutine can be called multiple times to print multiple
!    distributions.
!
!  copt='n' - print node header
!     you can call routine multiple times after this with copt=' '
!     to print additional node distributions
!  copt='e' - print element header
!     you can call routine multiple times after this with copt=' '
!     to print additional element distributions
!  copt=' ' - no header
!     used to print multiple distributions after first calling with 'e' or 'n'
!
!  example:
!    1. call vtk_tri2 with copt='n' and nval=nnode
!    2. call vtk_tri2 with copt=' ' and nval=nnode to print additional node distributions
!    3. call vtk_tri2 with copt='e' and nval=nelem
!    4. call vtk_tri2 with copt=' ' and nval=nelem to print additional element distributions
!
!=======================================================================
!
! This is the REAL8 version of the generic interface
!
      subroutine vtk_tri2_real8(iovtk, nval, data, label, copt)
      implicit none
      integer, intent(in) :: iovtk         ! file unit
      integer, intent(in) :: nval          ! number of nodes or elements
      real(8), intent(in) :: data(nval)    ! point data
      character(len=1) :: copt             ! ='n', 'e', or ' '
      character(len=*) :: label

!--- local

      integer :: i
      integer :: n

!--- print POINT label if this is the first dataset

      if (label.eq.' ') then
        write (*,*) '**** ERROR: Label is blank in call to vtk_tri2 ***'
        return
      endif

      if (copt.eq.'n') then
        write (iovtk,200) nval             ! only print this once, but can have multiple datasets
      elseif (copt.eq.'e') then
        write (iovtk,202) nval             ! only print this once, but can have multiple datasets
      elseif (copt.ne.' ') then
        stop 'invalid option to vtklib'
      endif
  200 format (/,'POINT_DATA ', i0)
  202 format (/,'CELL_DATA ', i0)

!--- print point data to VTK file for one dataset

  210 format ('SCALARS ',a,' float', &
            /,'LOOKUP_TABLE default')

      write (*,'(2a)') ' writing VTK distribution: ', trim(label)
      do i=1, len_trim(label)
        if (label(i:i).eq.' ') stop 'no spaces allowed in label'
      enddo
      write (iovtk,210) trim(label)

      do n=1, nval
        write (iovtk,'(1p,e14.5)') data(n)
      enddo

      return
      end subroutine vtk_tri2_real8
!=======================================================================
!
! This is the INTEGER version of the generic interface
!
      subroutine vtk_tri2_int(iovtk, nval, idata, label, copt)
      implicit none
      integer, intent(in) :: iovtk         ! file unit
      integer, intent(in) :: nval          ! number of nodes or elements
      integer, intent(in) :: idata(nval)   ! point data
      character(len=1) :: copt             ! ='n', 'e', or ' '
      character(len=*) :: label

!--- local

      integer :: i
      integer :: n

!--- print POINT label if this is the first dataset

      if (label.eq.' ') then
        write (*,*) '**** ERROR: Label is blank in call to vtk_tri2 ***'
        return
      endif

      if (copt.eq.'n') then
        write (iovtk,200) nval             ! only print this once, but can have multiple datasets
      elseif (copt.eq.'e') then
        write (iovtk,202) nval             ! only print this once, but can have multiple datasets
      elseif (copt.ne.' ') then
        stop 'invalid option to vtklib'
      endif
  200 format (/,'POINT_DATA ', i0)
  202 format (/,'CELL_DATA ', i0)

!--- print point data to VTK file for one dataset

  210 format ('SCALARS ',a,' int', &     ! changed from float 5/3/2020
            /,'LOOKUP_TABLE default')

      write (*,'(2a)') ' writing VTK distribution: ', trim(label)
      do i=1, len_trim(label)
        if (label(i:i).eq.' ') stop 'no spaces allowed in label'
      enddo
      write (iovtk,210) trim(label)

      do n=1, nval
        write (iovtk,'(i0)') idata(n)
      enddo

      return
      end subroutine vtk_tri2_int
!=======================================================================
!  Print data for XYZ mesh file
!=======================================================================
!
!  This is the REAL8 part of the generic interface
!
      subroutine vtk_xyz2_real8(iovtk, nval, data, label, copt)
      implicit none
      integer, intent(in) :: iovtk         ! file unit
      integer, intent(in) :: nval          ! number of nodes or elements
      real(8), intent(in) :: data(nval)    ! point data
      character(len=1) :: copt             ! ='n' or ' '
      character(len=*) :: label

!--- local

      integer :: i
      integer :: n

!--- print POINT label if this is the first dataset

      if (label.eq.' ') then
        write (*,*) '**** ERROR: Label is blank in call to vtk_xyz2 ***'
        return
      endif

      if (copt.eq.'n') then
        write (iovtk,200) nval             ! only print this once, but can have multiple datasets
      elseif (copt.ne.' ') then
        stop 'invalid option to vtklib'
      endif
  200 format (/,'POINT_DATA ', i0)

!--- print point data to VTK file for one dataset

  210 format ('SCALARS ',a,' float', &
            /,'LOOKUP_TABLE default')

      if (label.eq.' ') then
        stop 'empty label in call to vtk_xyz2'
      endif

      write (*,'(2a)') ' writing VTK distribution: ', trim(label)
      do i=1, len_trim(label)
        if (label(i:i).eq.' ') stop 'no spaces allowed in label'
      enddo
      write (iovtk,210) trim(label)
      do n=1, nval
        write (iovtk,'(1p,e14.5)') data(n)
      enddo

      return
      end subroutine vtk_xyz2_real8
!=======================================================================
!
!  This is the INTEGER part of the generic interface
!
      subroutine vtk_xyz2_int(iovtk, nval, idata, label, copt)
      implicit none
      integer, intent(in) :: iovtk         ! file unit
      integer, intent(in) :: nval          ! number of nodes or elements
      integer, intent(in) :: idata(nval)   ! point data
      character(len=1) :: copt             ! ='n' or ' '
      character(len=*) :: label

!--- local

      integer :: i
      integer :: n

!--- print POINT label if this is the first dataset

      if (label.eq.' ') then
        write (*,*) '**** ERROR: Label is blank in call to vtk_xyz2 ***'
        return
      endif

      if (copt.eq.'n') then
        write (iovtk,200) nval             ! only print this once, but can have multiple datasets
      elseif (copt.ne.' ') then
        stop 'invalid option to vtklib'
      endif
  200 format (/,'POINT_DATA ', i0)

!--- print point data to VTK file for one dataset

  210 format ('SCALARS ',a,' int', &      ! changed from float 5/3/2020
            /,'LOOKUP_TABLE default')

      if (label.eq.' ') then
        stop 'empty label in call to vtk_xyz2'
      endif

      write (*,'(2a)') ' writing VTK distribution: ', trim(label)
      do i=1, len_trim(label)
        if (label(i:i).eq.' ') stop 'no spaces allowed in label'
      enddo
      write (iovtk,210) trim(label)
      do n=1, nval
        write (iovtk,'(i6)') idata(n)
      enddo

      return
      end subroutine vtk_xyz2_int
!=======================================================================
!
!  Function to calculate area of triangle given three coordinates
!
!=======================================================================
      function vtk_areatri(ax,ay,bx,by,cx,cy)
      implicit none
      real(8) :: vtk_areatri
      real(8) :: ax,ay,bx,by,cx,cy
      real(8) :: tmp

      tmp=ax*(by-cy) + bx*(cy-ay) + cx*(ay-by)
      vtk_areatri=abs(tmp)*0.5d0

      return
      end function vtk_areatri

!=======================================================================
!
!  Subroutine to write STL file of surface triangles
!
!  Outward direction is "right hand rule" of triangle orientation
!
!  Scott Palmtag
!  2015/05/10
!
!=======================================================================
      subroutine stlwrite (filename, nnode, ntri, xi, gg)
      implicit none
      character(len=*), intent(in) :: filename
      integer, intent(in) :: nnode             ! number of nodes
      integer, intent(in) :: ntri              ! number of triangles
      real(8), intent(in) :: xi(3,nnode)       ! node coordinates
      integer, intent(in) :: gg(3,ntri)        ! map triangles to nodes

      real(4) :: x1(3)
      real(8) :: ux, uy, uz
      real(8) :: vx, vy, vz
      real(8) :: nx, ny, nz, anorm
      integer :: n1, n2, n3
      integer :: i
      integer :: iunit
      integer*2 :: padding
      character(len=80) :: title

      logical :: ifxst

      iunit=23
      title='STL file www.corephysics.com'
      padding=0

      write (*,*)
      write (*,'(2a)') ' writing filename: ', trim(filename)
      write (*,'(3a)') ' title   : ', trim(title)
      write (*,'(a,i0)') ' number of triangles: ', ntri

!--- write title and dimensions

      inquire(file=filename,exist=ifxst)   ! stream operator will append file
      if (ifxst) then
        open (iunit,file=filename,status='old')
        close (iunit,status='delete')
      endif

      open(unit=iunit,file=filename,access='stream', form='unformatted')

      write (iunit) title
      write (iunit) ntri

!--- write data

      do i=1, ntri

        n1=gg(1,i)    ! nodes
        n2=gg(2,i)
        n3=gg(3,i)

!  calculate surface normal

        Ux=xi(1,n2)-xi(1,n1)  ! p2-p1
        Uy=xi(2,n2)-xi(2,n1)
        Uz=xi(3,n2)-xi(3,n1)

        Vx=xi(1,n3)-xi(1,n1)  ! p3-p1
        Vy=xi(2,n3)-xi(2,n1)
        Vz=xi(3,n3)-xi(3,n1)

        Nx=Uy*Vz - Uz*Vy    ! U cross V
        Ny=Uz*Vx - Ux*Vz
        Nz=Ux*Vy - Uy*Vx

        anorm=abs(nx)+abs(ny)+abs(nz)
        if (anorm.gt.1.0d-6) then
          Nx=Nx/anorm
          Ny=Ny/anorm
          Nz=Nz/anorm
        endif

!dbg    write (30,*)
!dbg    write (30,'(i6,3f12.6)') i, Nx, Ny, Nz
!dbg    write (30,'(i6,3f12.6)') i, xi(:,n1)
!dbg    write (30,'(i6,3f12.6)') i, xi(:,n2)
!dbg    write (30,'(i6,3f12.6)') i, xi(:,n3)

        x1(1)=real(Nx)
        x1(2)=real(Ny)
        x1(3)=real(Nz)
        write (iunit) x1(1), x1(2), x1(3)

!  write coordinates

        x1(1)=real(xi(1,n1))
        x1(2)=real(xi(2,n1))
        x1(3)=real(xi(3,n1))
        write (iunit) x1(1), x1(2), x1(3)


        x1(1)=real(xi(1,n2))
        x1(2)=real(xi(2,n2))
        x1(3)=real(xi(3,n2))
        write (iunit) x1(1), x1(2), x1(3)

        x1(1)=real(xi(1,n3))
        x1(2)=real(xi(2,n3))
        x1(3)=real(xi(3,n3))
        write (iunit) x1(1), x1(2), x1(3)

!  write padding

        write (iunit) padding

      enddo

!--- finished

      close (iunit)    ! close STL file
      write (*,*) 'finished writing STL file'

      return
      end subroutine stlwrite
      end module mod_vtklib3
