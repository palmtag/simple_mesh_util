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
      real(8) :: apitch          ! total assembly pitch (flat to flat) (optional)

      logical :: iffull          ! flag if pins on bottom row are full or half

      integer, parameter :: maxrod=600
      integer :: irodmap(maxrod)
      logical :: ifrodmap
      integer :: nrodmap

      real(8), parameter :: sqrt3=sqrt(3.0d0)

      character(len=200) :: fbase    ! base input file name without suffix

!  "hflat" is equivalent to Newt "hexprism" times 2

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
      integer :: i, j, k, n

      character(len=12)  :: card
      character(len=100) :: line

!--- initialize

      apitch=-100.0d0
      totedge=-100.0d0

      irodmap=0
      ifrodmap=.false.
      nrodmap=0   ! number of rods in map

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
!> description: number of rods along one side
        elseif (card.eq.'irodside') then
          read (line,*) card, irodside

!> name: hflat
!> description: rod hexagon flat to flat distance
        elseif (card.eq.'hflat') then
          read (line,*) card, hflat

!> name: rfuel
!> description: radius of fuel rod
        elseif (card.eq.'rfuel') then
          read (line,*) card, rfuel

!> name: apitch
!> description: total hex pitch (flat to flat)
        elseif (card.eq.'apitch') then
          read (line,*) card, apitch

!> name: rodmap
!> description: array of rod types, start on next line
        elseif (card.eq.'rodmap') then
          ifrodmap=.true.
          read (line,*) card
          read (linp,*) (irodmap(i),i=1,maxrod)

        else
          write (0,   *) 'ERROR: invalid input card ', card
          stop 'invalid input card'
        endif

      enddo
  800 continue

      close (linp)

!--- write input

      write (*,20) 'xedge ', xedge
      write (*,20) 'hflat ', hflat
      write (*,20) 'rfuel ', rfuel
      write (*,24) 'irodside  ', irodside
   20 format (2x,a,f12.5)
   24 format (2x,a,1x,i0)

      if (apitch.gt.0.0d0) then    ! input
        totedge=apitch/sqrt3
        if (xedge*hflat.gt.totedge) stop 'apitch is too small'
      else
        totedge=xedge*hflat
        apitch=totedge*sqrt3
      endif
      write (*,20) 'apitch', apitch

      write (*,*)
      write (*,*) ' single rod hex pitch     (flat to flat)', hflat
      write (*,*) ' total length on one side of triangle   ', totedge
      write (*,*) ' total hex assembly pitch (flat to flat)', apitch

      write (*,*)

!--- calculate number of rods in problem

      iffull=.true.
      if (irodside.eq.0) then    ! calculate size, was not input
        if (abs(xedge - nint(xedge)).lt.0.001) then    ! whole number, so half pin on bottom
          iffull=.false.
          write (*,*) 'bottom row is split rods'
          irodside=nint(xedge)+1
        elseif (abs(xedge+0.0001d0 - int(xedge)).ge.0.5d0) then   ! fraction, so full pin on bottom + possible gap
          write (*,*) 'bottom row is full rods'
          irodside=int(xedge)+1
        else
          stop 'invalid xedge fraction - fraction must be zero or greater than 0.5'
        endif
      endif

      if (ifrodmap) then
        write (*,*)
        write (*,*) 'input rod map:'
        n=0
        do i=1, irodside
           k=irodside-i+1   ! skip
           do j=1, k
             write (*,'(2x)',advance='no')
           enddo
           write (*,40) (irodmap(n+j),j=1,i)
           do j=1, i
             if (irodmap(n+j).eq.0) stop 'zero found in pin map'
           enddo
           n=n+i
        enddo
        nrodmap=n
        if (irodmap(n+1).ne.0) stop 'too many entries on rodmap'
        write (*,*) 'number of rods in map = ', nrodmap
        write (*,*)
      else
        irodmap=1    ! default
      endif
  40  format (50i3)

!--- finished

      return
      end subroutine readinput

!=======================================================================
   end module mod_input
