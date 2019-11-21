   program makemesh
   implicit none
!=======================================================================
!
!  Program to create GMESH input for arbitrary pin lattice
!
!  To generate different lattice sizes, change the value of "npin" below
!
!  There is one guide tube pin always created at position (3,3)
!   (see hack at about line 140)
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
!        Version 4 has a lot of new information that we don't use
!   * GMSH will export a VTK file, but it is only the mesh.  It doesn't contain material info.
!
!=======================================================================

      integer :: i, j
      integer :: ia

      integer :: ifl=20   ! output file unit

      integer :: np       ! point number
      integer :: ir       ! region number

      integer :: nc       ! pointer for center for rod
      integer :: l1, l2   ! pointers
      integer :: l4, l5   ! pointers
      integer :: np1, np2, np3, np4   ! pointers

      integer :: nt
      integer, allocatable :: nsave(:)

      real(8) :: xc, yc
      real(8) :: rad1, rad2

      character(len=20) :: clopt

! hardwire Watts Bar geometry (this should come from an input file in the future)

      integer :: npin=17   ! number of pins across assembly

      real(8) :: ppitch=1.26d0     ! pin pitch
      real(8) :: rfuel=0.418d0     ! fuel radius
      real(8) :: rclad=0.475d0     ! clad outer radius

      real(8) :: rgtod=0.602d0     ! guide tube outer radius
      real(8) :: rgtid=0.561d0     ! guide tube inner radius

!--- read number of pins across from command line (optional)

     ia=iargc()
     if (ia.gt.0) then
       call getarg(1,clopt)
       read (clopt,*) npin
     endif 

     write (*,*) 'number of pins across assembly = ', npin

!--- initialize

      nt=0    ! save clad outer surface pointer
      allocate (nsave(npin*npin))
      nsave=0

      open (ifl,file='pin.geo')

!--- create mesh

      write (ifl,*)
      write (ifl,'(a)') '//  PWR Lattice Mesh Generator '
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

      write (ifl,'(/,a)') '//  define outer box of lattice'
      write (ifl,130) 1, npin*ppitch, 0.0d0
      write (ifl,130) 2, npin*ppitch, npin*ppitch
      write (ifl,130) 3, 0.0d0,       npin*ppitch
      write (ifl,130) 4, 0.0d0,       0.0d0

      write (ifl,*)
      write (ifl,'(a)') 'Line(1) = {3, 2};'
      write (ifl,'(a)') 'Line(2) = {2, 1};'
      write (ifl,'(a)') 'Line(3) = {1, 4};'
      write (ifl,'(a)') 'Line(4) = {4, 3};'
      write (ifl,*)
      write (ifl,'(a)') 'Line Loop(5) = {1, 2, 3, 4};     // outer boundary'
      write (ifl,*)
      write (ifl,'(a)') 'Physical Line("OutBC") = {1, 2, 3, 4};  // outer surface label'
      write (ifl,*)

      np=4   ! number of points so far
      ir=5   ! region number

!--- loop over each fuel pin

  120 format (/,'// ==============================', &
              /,'//    define rod ',i0,',',i0,/)

      do j=1, npin
        do i=1, npin

          write (ifl,120) i, j

          xc=i*ppitch - ppitch*0.5d0
          yc=j*ppitch - ppitch*0.5d0

          rad1=rfuel  ! fuel pin
          rad2=rclad  ! fuel pin
          if (i.eq.3 .and. j.eq.3) then   ! guide tube
            rad1=rgtid  ! guide tube
            rad2=rgtod  ! guide tube
          endif

          np=np+1
          nc=np  ! save rod center point
          write (ifl,130) nc, xc, yc
      130 format ('  Point(',i0,') = {',f12.8,',',f12.8,', 0, lc};')
      140 format ('  Circle(',i0,') = {',i0,',',i0,',',i0,'};')

  ! circles are circle arcs - define start point, center, end point

          write (ifl,*)

          np=np+1
          np1=np  ! save
          write (ifl,130) np, xc-rad2, yc   ! clad points
          np=np+1
          np2=np  ! save
          write (ifl,130) np, xc+rad2, yc
          np=np+1
          np3=np  ! save
          write (ifl,130) np, xc, yc-rad2
          np=np+1
          np4=np  ! save
          write (ifl,130) np, xc, yc+rad2

          ir=ir+1
          write (ifl,140) ir, np4, nc, np2   ! clad circles
          ir=ir+1
          write (ifl,140) ir, np2, nc, np3
          ir=ir+1
          write (ifl,140) ir, np3, nc, np1
          ir=ir+1
          write (ifl,140) ir, np1, nc, np4    

          ir=ir+1
          l1=ir
          write (ifl,150) l1, ir-4, ir-3, ir-2, ir-1, 'clad surface'
          write (ifl,*)
      150 format ('  Line Loop(',i0,') = {',i0,',',i0,',',i0,',',i0,'};   // ',a)

!d        write (*,300) i, j, l1
!d    300 format ('Pin (',i0,',',i0,')  clad outer surface: ',i0)   ! output debug
          nt=nt+1
          nsave(nt)=l1   ! save clad outer surface

          np=np+1
          np1=np  ! save
          write (ifl,130) np, xc-rad1, yc   ! points for fuel
          np=np+1
          np2=np  ! save
          write (ifl,130) np, xc+rad1, yc
          np=np+1
          np3=np  ! save
          write (ifl,130) np, xc, yc-rad1
          np=np+1
          np4=np  ! save
          write (ifl,130) np, xc, yc+rad1

          ir=ir+1
          write (ifl,140) ir, np4, nc, np2   ! fuel circles
          ir=ir+1
          write (ifl,140) ir, np2, nc, np3
          ir=ir+1
          write (ifl,140) ir, np3, nc, np1
          ir=ir+1
          write (ifl,140) ir, np1, nc, np4    

          ir=ir+1
          l2=ir
          write (ifl,150) l2, ir-4, ir-3, ir-2, ir-1, 'fuel surface'
          write (ifl,*)

!--- define physical surface labels for rod

          write (ifl,'(a)') '// define rod regions'
          ir=ir+1
          l4=ir
          write (ifl,160) l4, l1, l2
          ir=ir+1
          l5=ir
          write (ifl,162) l5, l2
          write (ifl,228) i, j, l4
          write (ifl,230) i, j, l5
      160 format ('  Plane Surface(',i0,') = {',i0,',',i0,'};   // clad region')
      162 format ('  Plane Surface(',i0,') = {',i0,'};      // fuel region')
      228 format ('  Physical Surface("RegClad',2i2.2,'")={',i0,'};   // pin clad')
      230 format ('  Physical Surface("RegFuel',2i2.2,'")={',i0,'};   // pin fuel')

        enddo
      enddo

!--- define final surface labels
!  this is tricky because we have to write a long line of numbers that can vary
!  with the problem size
!  How long a line can gmesh handle?

      write (ifl,'(/,a)') '//===================================================='
      write (ifl,'(a)') '// Define coolant region and label'
      ir=ir+1
      write (ifl,250, advance='NO') ir, nsave(1)

      do j=2, npin*npin-1
        write (ifl,252, advance='NO') nsave(j)
        if (mod(j,10).eq.0) write (ifl,*)  ! break line
      enddo 
      j=npin*npin
        write (ifl,254) nsave(j)

      write (ifl,260) ir

  250 format ('  Plane Surface(',i0,') ={5, ',10(i0,','))
  252 format (2x,i0,',')
  254 format (2x,i0,'};')
  260 format ('  Physical Surface("RegCool")={',i0,'};')

      write (ifl,*)

      close (ifl)

      write (*,*) 'finished writing geo file: pin.geo'

      end
