   subroutine hexcenter(ppitch, nrod, nrow, rodxy)
   implicit none
!=======================================================================
!
!  Subroutine to calculate rod centers in hexagon assembly
!
!  Orientation is so the "flats" are at the top and bottom
!
!=======================================================================
      integer, intent(in)  :: nrod    ! total number of rods
      integer, intent(in)  :: nrow    ! number of rows of rods
      real(8), intent(in)  :: ppitch  ! rod hex size flat to flat
      real(8), intent(out) :: rodxy(2,nrod)

      integer :: mm, ir, jj

      real(8) :: deltay

!-----------------------------

      write (*,*)
      write (*,*) 'calculating rod centers'

      rodxy(:,:)=0.0d0

      deltay=ppitch*sqrt(3.0d0)*0.5d0

      write(*,*) 'pin pitch ', ppitch
      write(*,*) 'nrod   ', nrod
      write(*,*) 'nrow   ', nrow

!  define central rod

      mm=1
      rodxy(1,mm)=0.0d0
      rodxy(2,mm)=0.0d0

!  Loop over rings to create cells
!   (it helps to look at a picture)

      do ir=1, nrow-1          ! row number, also number of rods on a "flat"

   ! new code that had "flats" on the top and bottom
   ! starting position is at the zero degree position, then work CC

        mm=mm+1                     ! starting location of "loop"
        rodxy(1,mm)=ppitch*dble(ir)
        rodxy(2,mm)=0.0d0

        do jj=1, ir     ! build up and to the left
          mm=mm+1
          rodxy(1,mm)=rodxy(1,mm-1)-ppitch*0.5d0
          rodxy(2,mm)=rodxy(2,mm-1)+deltay
        enddo

        do jj=1, ir     ! build down and to left
          mm=mm+1
          rodxy(1,mm)=rodxy(1,mm-1)-ppitch
          rodxy(2,mm)=rodxy(2,mm-1)
        enddo

        do jj=1, ir     ! build straight down
          mm=mm+1
          rodxy(1,mm)=rodxy(1,mm-1)-ppitch*0.5d0
          rodxy(2,mm)=rodxy(2,mm-1)-deltay
        enddo

        do jj=1, ir     ! build down and to right
          mm=mm+1
          rodxy(1,mm)=rodxy(1,mm-1)+ppitch*0.5d0
          rodxy(2,mm)=rodxy(2,mm-1)-deltay
        enddo

        do jj=1, ir     ! build up and to right
          mm=mm+1
          rodxy(1,mm)=rodxy(1,mm-1)+ppitch
          rodxy(2,mm)=rodxy(2,mm-1)
        enddo

        do jj=1,ir-1   ! build straight up (don't clobber first hex)
          mm=mm+1
          rodxy(1,mm)=rodxy(1,mm-1)+ppitch*0.5d0
          rodxy(2,mm)=rodxy(2,mm-1)+deltay
        enddo

      enddo

      if (mm.ne.nrod) then
        write (*,*) 'nrod = ', nrod
        write (*,*) 'calculated nrod = ', mm
        stop 'nrod error in subroutine hexcenter'
      endif

      do mm=1, nrod
        if (abs(rodxy(1,mm)).lt.1.0d-10) rodxy(1,mm)=0.0d0  ! fix small roundoff
        if (abs(rodxy(2,mm)).lt.1.0d-10) rodxy(2,mm)=0.0d0  ! fix small roundoff
      enddo
 
      write (*,*)

      return
      end subroutine hexcenter

