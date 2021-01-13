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

   contains

!=======================================================================
!
!  Subroutine to create SVG drawing of triangle mesh
!   *** assumes 2D triangles, z-direction is ignored
!
!=======================================================================
      subroutine drawsvg(fname)
      implicit none

      character(len=*), intent(in) :: fname

!--- local

      integer :: isvg=32   ! unit number

      integer :: m, i
      integer :: n1, n2, n3
      integer :: nc        ! color number
      integer :: ibox, jbox, ioff

      real(8) :: pixel
      real(8) :: x1, x2, x3
      real(8) :: y1, y2, y3
      real(8) :: xmn, xmx, ymn, ymx

      character(len=120) :: svgname

      character(len=12) :: color(nmat)   ! automatic

      logical :: ifnum=.false.    ! debug option to print node numbers in SVG

!x    character(len=20) :: label

      write (*,*)

      color(:)='white'    ! default

!  assign default colors
!  if over 12 regions, they will be white

      if (nmat.ge. 1) color(1)='red'
      if (nmat.ge. 2) color(2)='blue'
      if (nmat.ge. 3) color(3)='green'
      if (nmat.ge. 4) color(4)='magenta'
      if (nmat.ge. 5) color(5)='yellow'
      if (nmat.ge. 6) color(6)='chocolate'
      if (nmat.ge. 7) color(7)='darkviolet'
      if (nmat.ge. 8) color(8)='coral'
      if (nmat.ge. 9) color(9)='darkcyan'
      if (nmat.ge.10) color(10)='orangered'
      if (nmat.ge.11) color(11)='olivedrab'
      if (nmat.ge.12) color(12)='yellowgreen'

!  overwrite default colors with input values
!  user can use either region names or composition names to assign colors

!     do i=1, nmat
!        do m=1, numcolor
!           if (reglist(i).eq.svgreg(m)) color(i)=svgcolor(m)
!           if (complist(i).eq.svgreg(m)) color(i)=svgcolor(m)
!        enddo
!     enddo

      if (ifnum) color(:)='white'

      ioff=5   ! offset (margin) on sides of picture

!--- svg formats

  100 format ('<svg xmlns="http://www.w3.org/2000/svg" version="1.1"', &
            /,'  width="',i0,'" height="',i0,'" >')

  800 format ('</svg>')

!  M=start point (move to)
!  L=line to next point
!  Z=close path

  210 format ('  <path d="M',i0,1x,i0,2(' L', i0,1x,i0),' Z" fill="',a,'" stroke="black" stroke-width="1" />')
!x160 format ('  <text x="',i0,'" y="',i0,'" style="font-family:Verdana;font-size:12px"', &
!x                 ' fill="black" text-anchor="middle">',a,'</text>')

!--- find min and max coordinates for problem

      i=1
      xmn=xi(1,i)
      xmx=xi(1,i)
      ymn=xi(2,i)
      ymx=xi(2,i)
      do i=2, nnode
        xmn=min(xmn,xi(1,i))
        xmx=max(xmx,xi(1,i))
        ymn=min(ymn,xi(2,i))
        ymx=max(ymx,xi(2,i))
      enddo

      write (*,230) 'x', xmn, xmx
      write (*,230) 'y', ymn, ymx
  230 format (1x,a1,'min/max ', 2f12.5)

!--- define geometry constants to draw hex boxes

      x1=600.0d0/(xmx-xmn)   ! determine multiplier to make picture 600x600 pixels
      y1=600.0d0/(ymx-ymn)
      pixel=min(x1,y1)
!d    write (*,*) 'pixel=', pixel

      ibox = nint((xmx-xmn)*pixel)+2*ioff
      jbox = nint((ymx-ymn)*pixel)+2*ioff

!--- loop over planes and draw a different SVG for each plane

      svgname=trim(fname)//'.svg'

!--- open svg file and draw bounding box

      write (*,'(/,2a)') ' writing to SVG file: ', trim(svgname)

      open (isvg,file=svgname)
      write (*,*) 'bounding box from ', ibox, jbox
      write (isvg,100) ibox, jbox

!--- draw SVG boxes
!--- use the bottom plane to draw the boxes, but the data might come from different plane

      do m=1, nelem

        n1=gg(1,m)
        n2=gg(2,m)
        n3=gg(3,m)

   ! *** only read x and y values, ignore z

        x1=(xi(1,n1)-xmn)*pixel
        x2=(xi(1,n2)-xmn)*pixel
        x3=(xi(1,n3)-xmn)*pixel

        y1=(xi(2,n1)-ymn)*pixel   ! flip y-coord for SVG
        y2=(xi(2,n2)-ymn)*pixel
        y3=(xi(2,n3)-ymn)*pixel

        if (nint(x1).lt.0 .or. nint(x1).gt.ibox) write (*,*) '*** check x1 ***', x1
        if (nint(x2).lt.0 .or. nint(x2).gt.ibox) write (*,*) '*** check x2 ***', x2
        if (nint(x3).lt.0 .or. nint(x3).gt.ibox) write (*,*) '*** check x3 ***', x3
        if (nint(y1).lt.0 .or. nint(y1).gt.jbox) write (*,*) '*** check y1 ***', y1
        if (nint(y2).lt.0 .or. nint(y2).gt.jbox) write (*,*) '*** check y2 ***', y2
        if (nint(y3).lt.0 .or. nint(y3).gt.jbox) write (*,*) '*** check y3 ***', y3

  ! color by material number

        nc=matelem(m)

        write (isvg,210) nint(x1)+ioff, nint(y1)+ioff,  &
                         nint(x2)+ioff, nint(y2)+ioff,  &
                         nint(x3)+ioff, nint(y3)+ioff,  &
                         trim(color(nc))

!       n1=gg(0,m)           ! hex center
!       x1=( xi(1,n1)-xmn)*pixel
!       y1=(-xi(2,n1)-ymn)*pixel  ! flip y-coord for SVG
!       if (ifnum) then
!         write (label,'(i0)') hex(m,kk)%pos   ! position number
!         write (isvg,160) nint(x1)+ioff, nint(y1)+5+ioff, trim(label)            ! offset for font
!       else
!         write (isvg,160) nint(x1)+ioff, nint(y1)+5+ioff, trim(hex(m,kk)%mat)    ! offset for font
!       endif

      enddo

      write (isvg,800)
      close (isvg)

!--- finished

      return
      end subroutine drawsvg

!========================================================================

   end module mod_trigeom
