   program createtri
   implicit none
!=======================================================================
!
!  Program to create GMESH input for triangle mesh
!
!  To generate different lattice sizes, change the value of "nedge" below
!
!  Scott Palmtag
!  November 15, 2019
!
!  1. Run this program to generate ".geo" files
!  2. Load ".geo" file into GMSH
!  3. Mesh -> 2D  to generate 2D triangle mesh
!  4. Export -> GMSH -> Version 2.0 Ascii to save the mesh to a ".msh" file
!  5. Run the "msh2vtk" utility to convert to VTK
!
!  Notes:
!   * You have to export to version 2 msh file, the new version is 4 and doesn't work
!        They added a lot of new information to version 4
!   * GMSH will export a VTK file, but it is only the mesh.  It doesn't contain material info.
!
!=======================================================================

      integer :: i
      integer :: ia

      integer :: nrod  ! rod counter
      integer :: jrow

      integer :: ioff

      real(8) :: xc, yc
      real(8) :: x1, x2
      real(8) :: pedge     ! edge of triangle width = hside/sqrt(3)

      character(len=20) :: clopt

! hardwire geometry (should come from input)

      integer :: nedge=24  ! number of triangle edges across (must be divisible by 3)

      real(8) :: hside=1.26d0    ! flat to flat distance across hexagon
      real(8) :: rfuel=0.4d0     ! radius of fuel rod

! rod data arrays

      real(8), allocatable :: rodxy(:,:)    ! (2,numrod)
      integer, allocatable :: rodtype(:)    ! (numrod)

!--- read number of pins across from command line (optional)

     ia=iargc()
     if (ia.gt.0) then
       call getarg(1,clopt)
       read (clopt,*) nedge
     endif

     write (*,*) 'number of triangles edges across assembly = ', nedge

!--- initialize

      pedge=hside/sqrt(3.0d0)    ! length on edge of triangle

      write (*,*) 'nedge ', nedge
      write (*,*) 'hex size ', hside,' (flat to flat)'
      write (*,*) 'triangle size ', pedge

      if (mod(nedge,3).ne.0) stop 'nedge must be divisible by 3'

      nrod=nedge*nedge  ! over allocate storage arrays
      allocate (rodxy(2,nrod))
      allocate (rodtype(nrod))
      rodxy(:,:)=10000.0d0
      rodtype(:)=0

!--- loop over each fuel rod and determine center coordinates

      nrod=0

! lower left corner rod (partial rod)

      nrod=nrod+1
      rodxy(1,nrod)=0.0d0
      rodxy(2,nrod)=0.0d0
      rodtype(nrod)=1

!  lower right corner rod (partial rod)

      nrod=nrod+1
      rodxy(1,nrod)=nedge*pedge
      rodxy(2,nrod)=0.0d0
      rodtype(nrod)=2

!  upper rod (partial rod)

      nrod=nrod+1
      rodxy(1,nrod)=nedge*pedge*0.5d0              ! rod center coordinate
      rodxy(2,nrod)=nedge*pedge*0.5d0*sqrt(3.0d0)  ! rod center coordinate
      rodtype(nrod)=3

!--- rods across bottom half of triangle (half rods)

      do i=1, nedge/3-1    ! half rods
         nrod=nrod+1
         rodxy(1,nrod)=i*3*pedge
         rodxy(2,nrod)=0.0d0
         rodtype(nrod)=4
      enddo

!--- edge rods right side of triangle (type 5) *********************** FINISH

      do i=1, nedge/3-1    ! half rods
         nrod=nrod+1
         rodxy(1,nrod)=nedge*pedge-i*3*pedge*0.5d0
         rodxy(2,nrod)=i*3*pedge*0.5d0*sqrt(3.0d0)
         rodtype(nrod)=5
      enddo

!--- edge rods left side of triange  (type 6)

      do i=1, nedge/3-1    ! half rods
         nrod=nrod+1
         rodxy(1,nrod)=i*3*pedge*0.5d0
         rodxy(2,nrod)=i*3*pedge*0.5d0*sqrt(3.0d0)
         rodtype(nrod)=6
      enddo

!---- full pins in middle rows

      ioff=1
      do jrow=nedge, 2, -1   ! skip very top

          x1=(nedge-jrow+1)*pedge*0.5d0    ! left edge of big triangle
          x2=nedge*pedge-x1    ! right edge

          xc=x1+ioff*pedge
          yc=x1*sqrt(3.0d0)
          ioff=ioff+1
          if (ioff.gt.3) ioff=1

          if (xc+pedge*0.5d0.ge.x2) cycle  ! some rows have no rods

          do
            nrod=nrod+1

            rodxy(1,nrod)=xc
            rodxy(2,nrod)=yc
            rodtype(nrod)=0

            xc=xc+3.0d0*pedge
            if (xc+pedge*0.5d0 .gt. x2) exit
          enddo
      enddo   ! jrow

!--- create geo file

      call trigeo(rfuel, nrod, rodxy, rodtype)

      end

!=======================================================================

      subroutine trigeo(rfuel, numrod, rodxy, rodtype)
      implicit none
!-----------------------------------------------------------------------
!
!  Subroutine to write list of rods to ".geo" file
!
!-----------------------------------------------------------------------

      real(8), intent(in) :: rfuel    ! fuel rod radii

      integer, intent(in) :: numrod   ! total number of rods
      real(8), intent(in) :: rodxy(2,numrod)  ! center coordinates
      integer, intent(in) :: rodtype(numrod)  ! rod types

!--- local

      integer :: j

      integer :: ifl=20   ! output file unit

      integer :: np    ! point number
      integer :: ir    ! region number
      integer :: nrod  ! rod counter

      integer :: nc       ! pointer for center for rod
      integer :: l1       ! pointers
      integer :: np1, np2, np3, np4   ! pointers

      integer :: nos
      integer, allocatable :: nsave(:)

      real(8) :: xc, yc
      real(8) :: rad1

!--- initialize

      nos=0    ! save rod outer surface pointer
      allocate (nsave(numrod))
      nsave=0

      open (ifl,file='tri.geo')

!--- create mesh

      write (ifl,*)
      write (ifl,'(a)') '//  Triangle Mesh Generator '
      write (ifl,*)
      write (ifl,'(a)') '// set characteristic length'
!x    write (ifl,'(a)') 'lc=0.05;'
      write (ifl,'(a)') 'lc=0.1;'
      write (ifl,*)
      write (ifl,'(a)') 'lcb=0.05;  // characteristic length on border'
      write (ifl,*)
      write (ifl,'(a)') 'General.BackgroundGradient=0; '
      write (ifl,'(a)') 'General.Color.Background={63,255,50};'

!--- write outer box

      write (ifl,'(/,a)') '//  define outer box of triangle'
      write (ifl,130) 1, rodxy(:,1)   ! bottom left corner
      write (ifl,130) 2, rodxy(:,2)   ! bottom right corner
      write (ifl,130) 3, rodxy(:,3)   ! top corner

      write (ifl,*)
      write (ifl,'(a)') 'Line(1) = {1, 2};'
      write (ifl,'(a)') 'Line(2) = {2, 3};'
      write (ifl,'(a)') 'Line(3) = {3, 1};'
      write (ifl,*)
      write (ifl,'(a)') 'Line Loop(5) = {1, 2, 3};     // outer boundary'
      write (ifl,*)
      write (ifl,'(a)') 'Physical Line("OutBC") = {1, 2, 3};  // outer surface label'
      write (ifl,*)

      np=3   ! number of points so far
      ir=4   ! region number so far  (lines and loop)

!--- loop over each fuel rod

  120 format (/,'// ==============================', &
              /,'//    define rod ',i0,1x,a/)

  130 format ('  Point(',i0,') = {',f12.8,',',f12.8,', 0, lc};')

  ! circles are circle arcs - define start point, center, end point
  140 format ('  Circle(',i0,') = {',i0,',',i0,',',i0,'};')
  142 format ('  Line(',i0,') = {',i0,',',i0,'};')

  150 format ('  Line Loop(',i0,') = {',i0,',',i0,',',i0,',',i0,'};   // ',a)  ! 4 pts
  152 format ('  Line Loop(',i0,') = {',i0,',',i0,',',i0,       '};   // ',a)  ! 3 pts

!--- write rod data

      do nrod=1, numrod

        xc=rodxy(1,nrod)
        yc=rodxy(2,nrod)

        rad1=rfuel  ! fuel pin   ! look up rod sizes here

!d      if (rodtype(nrod).gt.0) cycle ! ***************************************** DEBUG

        if (rodtype(nrod).eq.1) then     ! lower left corner sixth rod

          write (ifl,120) nrod, 'lower left partial rod'

          nc=1   ! use already defined point at lower left corner
          np=np+1
          np1=np  ! save
          write (ifl,130) np, xc+rad1*0.5d0, yc+rad1*0.5d0*sqrt(3.0d0)   ! top point on curve
          np=np+1
          np2=np  ! save
          write (ifl,130) np, xc+rad1, yc      ! bottom point on curve

          ir=ir+1
          write (ifl,142) ir, nc, np1          ! line
          ir=ir+1
          write (ifl,140) ir, np1, nc, np2     ! circle arc
          ir=ir+1
          write (ifl,142) ir, np2, nc          ! line

          ir=ir+1
          l1=ir
          write (ifl,152) l1, ir-3, ir-2, ir-1, 'surface for partial rod'

        elseif (rodtype(nrod).eq.2) then   ! lower right corner rod sixth

          write (ifl,120) nrod, 'lower right partial rod'

          nc=2   ! use already defined point at corner of problem
          np=np+1
          np1=np  ! save
          write (ifl,130) np, xc-rad1, yc      ! bottom point on curve
          np=np+1
          np2=np  ! save
          write (ifl,130) np, xc-rad1*0.5d0, yc+rad1*0.5d0*sqrt(3.0d0)   ! top point on curve

          ir=ir+1
          write (ifl,140) ir, np1, nc, np2     ! fuel circles
          ir=ir+1
          write (ifl,142) ir, np2, nc          ! line
          ir=ir+1
          write (ifl,142) ir, nc, np1         ! line

          ir=ir+1
          l1=ir
          write (ifl,152) l1, ir-3, ir-2, ir-1, 'rod surface'

        elseif (rodtype(nrod).eq.3) then   ! top corner rod sixth

          write (ifl,120) nrod, 'upper partial rod'

          nc=3   ! use already defined point at corner of problem
          np=np+1
          np1=np  ! save
          write (ifl,130) np, xc-rad1*0.5d0, yc-rad1*0.5d0*sqrt(3.0d0)  ! left point on curve
          np=np+1
          np2=np  ! save
          write (ifl,130) np, xc+rad1*0.5d0, yc-rad1*0.5d0*sqrt(3.0d0)  ! right point on curve

          ir=ir+1
          write (ifl,140) ir, np1, nc, np2    ! fuel circles
          ir=ir+1
          write (ifl,142) ir, np2, nc         ! line
          ir=ir+1
          write (ifl,142) ir, nc, np1         ! line

          ir=ir+1
          l1=ir
          write (ifl,152) l1, ir-3, ir-2, ir-1, 'rod surface'

        elseif (rodtype(nrod).eq.4) then   ! part rod on edge

          write (ifl,120) nrod, 'bottom row half rod'

          np=np+1
          nc=np  ! save rod center point for fuel
          write (ifl,130) nc, xc, yc

          np=np+1
          np1=np
          write (ifl,130) np, xc-rad1, yc   ! left
          np=np+1
          np2=np
          write (ifl,130) np, xc, yc+rad1   ! top
          np=np+1
          np3=np
          write (ifl,130) np, xc+rad1, yc   ! right
          np=np+1

        elseif (rodtype(nrod).eq.5) then   ! part rod on edge
!d        cycle  ! ***************************************** DEBUG

          write (ifl,120) nrod, 'right edge half rod'

          np=np+1
          nc=np  ! save rod center point for fuel
          write (ifl,130) nc, xc, yc

          np=np+1
          np1=np
          write (ifl,130) np, xc-rad1*0.5d0, yc+rad1*0.5d0*sqrt(3.0d0)   ! top
          np=np+1
          np2=np
          write (ifl,130) np, xc-rad1, yc   ! middle
          np=np+1
          np3=np
          write (ifl,130) np, xc+rad1*0.5d0, yc-rad1*0.5d0*sqrt(3.0d0)   ! bottom
          np=np+1

        elseif (rodtype(nrod).eq.6) then   ! part rod on left edge

          write (ifl,120) nrod, 'left edge half rod'

          np=np+1
          nc=np  ! save rod center point for fuel
          write (ifl,130) nc, xc, yc

          np=np+1
          np1=np
          write (ifl,130) np, xc+rad1*0.5d0, yc+rad1*0.5d0*sqrt(3.0d0)   ! top
          np=np+1
          np2=np
          write (ifl,130) np, xc+rad1, yc   ! middle
          np=np+1
          np3=np
          write (ifl,130) np, xc-rad1*0.5d0, yc-rad1*0.5d0*sqrt(3.0d0)   ! bottom
          np=np+1

        else    ! standard rod

          write (ifl,120) nrod, 'full'

          np=np+1
          nc=np  ! save rod center point
          write (ifl,130) nc, xc, yc
          np=np+1
          np1=np  ! save
          write (ifl,130) np, xc-rad1, yc      ! left point on curve
          np=np+1
          np2=np  ! save
          write (ifl,130) np, xc, yc+rad1      ! top  point on curve
          np=np+1
          np3=np  ! save
          write (ifl,130) np, xc+rad1, yc      ! right point on curve
          np=np+1
          np4=np  ! save
          write (ifl,130) np, xc, yc-rad1      ! bott  point on curve

       endif

!--- print 4 point surfaces

       if (rodtype(nrod).lt.1 .or. rodtype(nrod).gt.3) then

          ir=ir+1
          write (ifl,140) ir, np1, nc, np2   ! fuel circles
          ir=ir+1
          write (ifl,140) ir, np2, nc, np3
          ir=ir+1
          write (ifl,140) ir, np3, nc, np4
          ir=ir+1
          write (ifl,140) ir, np4, nc, np1

          ir=ir+1
          l1=ir
          write (ifl,150) l1, ir-4, ir-3, ir-2, ir-1, 'fuel surface'

        endif

        nos=nos+1
        nsave(nos)=l1   ! save rod outer surface to define moderator

        ir=ir+1
        write (ifl,160) ir, l1
        write (ifl,230) nrod, l1    ! physical surface

      enddo

  160 format ('  Plane Surface(',i0,') = {',i0,'};      // fuel region')
  230 format ('  Physical Surface("RegFuel',i3.3,'")={',i0,'};')

!--- define final surface labels
!  this is tricky because we have to write a long line of numbers that can vary
!  with the problem size
!  How long a line can gmesh handle?

      write (ifl,'(/,a)') '//===================================================='
      write (ifl,'(a)')   '//  Define coolant region and label'
      ir=ir+1
      write (ifl,250, advance='NO') ir, nsave(1)

      do j=2, nos-1
        write (ifl,252, advance='NO') nsave(j)
        if (mod(j,10).eq.0) write (ifl,*)  ! break line
      enddo
      j=nos
        write (ifl,254) nsave(j)

      write (ifl,260) ir

!   5 is the outer boundary

  250 format ('  Plane Surface(',i0,') ={5, ',10(i0,','))
  252 format (2x,i0,',')
  254 format (2x,i0,'};')
  260 format ('  Physical Surface("RegCool")={',i0,'};')

      write (ifl,*)

      close (ifl)

      write (*,*) 'finished writing geo file: tri.geo'
      write (*,*) 'gmsh tri.geo -format msh22 -2 -save'

      return
      end subroutine trigeo
