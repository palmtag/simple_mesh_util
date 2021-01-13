   module mod_input
      implicit none
!-----------------------------------------------------------------------
!
!  module to process input for triangle mesh generator
!
!  Scott Palmtag
!  2021-01-13  
!
!-----------------------------------------------------------------------

      integer :: irodside=0      ! calculated if not input

      real(8) :: xedge=4.5d0     ! number of hexes across edge of triangle
      real(8) :: hflat=1.60d0    ! hexagon flat to flat distance (each pin)
      real(8) :: rfuel=0.706d0   ! radius of fuel rod
      real(8) :: totedge         ! total length of one side of triangle

   contains
!=======================================================================
!
!  Subroutine to read input for triangle mesh generator
!
!=======================================================================
      subroutine readinput(fname)
      implicit none

      character(len=*), intent(in) :: fname

!--- locals

      integer :: linp=22    ! input unit number
      integer :: k

      character(len=12)  :: card
      character(len=100) :: line

!--- initialize

!--- read input

      write (*,'(2a)') ' Reading input file: ', trim(fname)

      open (linp, file=fname, status='old', action='read')

      do
        read (linp,'(a)',end=800) line
        k=index(line,'!')
        if (k.gt.0) line(k:)=' '    ! remove comment
        k=index(line,'#')
        if (k.gt.0) line(k:)=' '    ! remove comment
        if (line.eq.' ') cycle

        read (line,*) card

!> name: xedge
!> description: number of hexes across edge of triangle
        if     (card.eq.'xedge') then
          read (line,*) card, xedge

!> name: irodside
!> description: hexagon flat to flat distance
        elseif (card.eq.'irodside') then
          read (line,*) card, irodside

!> name: hflat
!> description: hexagon flat to flat distance
        elseif (card.eq.'hflat') then
          read (line,*) card, hflat

!> name: rfuel
!> description: radius of fuel rod
        elseif (card.eq.'rfuel') then
          read (line,*) card, rfuel

        else
          write (0,   *) 'ERROR: invalid input card ', card
          stop 'invalid input card'
        endif

      enddo
  800 continue

      close (linp)

!--- write input

      write (*,20) 'xedge', xedge
      write (*,20) 'hflat', hflat
      write (*,20) 'rfuel', rfuel
      write (*,24) 'irodside ', irodside
   20 format (2x,a,f12.5)
   24 format (2x,a,1x,i0)

      totedge=xedge*hflat

      write (*,*)
      write (*,*) ' hex size ', hflat,' (flat to flat)'
      write (*,*) ' total length on one side of triangle ', totedge

      write (*,*)

!--- finished

      return
      end subroutine readinput

!=======================================================================
   end module mod_input
