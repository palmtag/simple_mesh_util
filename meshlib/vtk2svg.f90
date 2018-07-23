   program driver
   use mod_trigeom, only : drawsvg
   implicit none
!=======================================================================
!
!  Program to convert VTK to SVG
!
!  Usage:   vtk2svg [file.vtk]
!
!  Limitations:
!  * only works with triangle elements
!  * only works for 2D, 3D will give really strange pictures
!
!=======================================================================
!
!  @version CVS $Id: vtk2svg.f90,v 1.2 2018/07/20 22:22:41 scott Exp $
!
!=======================================================================

      integer :: ia, k
      character(len=100) :: fname

      ia=iargc()
      if (ia.eq.0) stop 'usage: vtk2svg [file.vtk]'

      call getarg(1,fname)

      call readvtk(fname)

      k=len_trim(fname)     ! strip off vtk suffix
      if (k.gt.3) then
        if (fname(k-3:k).eq.'.vtk') fname(k-3:k)=' '
      endif

      call drawsvg(fname)

      write (*,*) 'finished'

      end program driver

