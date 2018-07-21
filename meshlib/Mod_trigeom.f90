   module mod_trigeom
   implicit none
!=======================================================================
!
!  Module to store triangle geometry information
!
!  @version CVS $Id: Mod_trigeom.f90,v 1.2 2018/07/20 22:22:41 scott Exp $
!
!=======================================================================

!  VTK triangular mesh parameters (defined for full-core)

      integer :: nnode=0                  ! number of nodes in triangular mesh
      integer :: nelem=0                  ! number of elements in trianglular mesh
      integer :: iorder=3                 ! order of mesh (3 for triangles, 6 for wedges)
      integer :: nmat=0                   ! number of materials

      integer, allocatable :: gg(:,:)     ! (iorder,nelem)  map elements to nodes
      real(8), allocatable :: xi(:,:)     ! (3, nnode)      node coordinates for every node
      integer, allocatable :: matelem(:)  ! (nelem)         element material numbers

   end module mod_trigeom
