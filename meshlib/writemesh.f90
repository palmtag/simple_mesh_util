!=======================================================================
!
!  Subroutine to create a "MESH" file
!  This is just a standard binary file that can be read by the solver code
!
!  This is my own format....
!
!  2013/02/05 - change (x,y) coordinates to (xi)
!
!  2015/04/27 - update xi() array to have z coordinate, but it is not used
!
! @version CVS $Id: writemesh.f90,v 1.3 2015/04/27 12:50:57 scott Exp $
!
!=======================================================================
      subroutine writemesh(fname, nnode, nelem, xi, ivar, matl, mask)
      implicit none
      character(len=*), intent(in) :: fname
      integer,          intent(in) :: nnode          ! number of nodes
      integer,          intent(in) :: nelem          ! number of elements
      integer,          intent(in) :: ivar(3,nelem)  ! node connections
      integer,          intent(in) :: matl(nelem)    ! element materials
      integer,          intent(in) :: mask(nnode)    ! element materials
      real*8,           intent(in) :: xi(3,nnode)    ! node coordinates

      integer     :: i
      character*8 :: label='MESH'
      integer     :: iver=1        ! file version number
      integer     :: norder=3      ! triangle mesh
      integer     :: ndim=2        ! 2-D

      open (24,file=fname,form='unformatted')
      write (24) label, iver
      write (24) nnode, nelem, norder, ndim
      write (24) (xi(1,i),xi(2,i),i=1,nnode)
      write (24) (mask(i),i=1,nnode)
      write (24) (ivar(1:3,i),i=1,nelem)
      write (24) (matl(i),i=1,nelem)            ! material numbers
      i=0
      write (24) i                              ! zero means EOF
      close (24)

      return
      end subroutine writemesh

!=======================================================================
!=======================================================================
