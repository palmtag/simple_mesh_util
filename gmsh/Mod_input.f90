   module mod_input
      implicit none
!-----------------------------------------------------------------------
!
!  module to process input for triangle and hex mesh generators
!
!  Scott Palmtag
!  2021-01-13
!
!-----------------------------------------------------------------------

      integer :: irodside=0      ! calculated if not input
      integer :: matclad         ! clad material number
      integer :: matbox          ! outer box material number
      integer :: matcool         ! coolant material number

      real(8) :: ppitch=1.60d0   ! ppitch
      real(8) :: rinner=0.0d0    ! radius of fuel pellet  (0=no inner region)
      real(8) :: rfuel=0.706d0   ! radius of outer fuel rod
      real(8) :: totedge         ! total length of one side of triangle
      real(8) :: apitch          ! total assembly pitch (flat to flat) (optional)

      logical :: iffull          ! flag if pins on bottom row are full or half

      integer, parameter :: maxrod=600
      integer :: irodmap(maxrod)
      logical :: ifrodmap
      integer :: nrodmap

      integer, allocatable :: hexmap(:)

      real(8), parameter :: sqrt3=sqrt(3.0d0)

      character(len=200) :: fbase    ! base input file name without suffix

!  "ppitch" is equivalent to Newt "hexprism" times 2

   contains
!=======================================================================
!
!  Subroutine to read input for triangle mesh generator
!
!  xedge is the old input style.
!  now recommend using "apitch" and "irodside"
!
!
!=======================================================================
      subroutine readinput(fname)
      implicit none

      character(len=*), intent(in) :: fname

!--- locals

      integer :: linp=22    ! input unit number
      integer :: i, j, k, n

      real(8) :: xedge     ! number of hexes across edge of triangle (old input style)

      character(len=12)  :: card
      character(len=100) :: line

!--- initialize

      apitch=-100.0d0
      totedge=-100.0d0
      xedge=0.0d0

      matclad=0
      matbox =0
      matcool=0

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

!> name: ppitch
!> description: pin pitch
        elseif (card.eq.'ppitch') then
          read (line,*) card, ppitch

!> name: rinner
!> description: radius of inner fuel pellet
        elseif (card.eq.'rinner') then
          read (line,*) card, rinner

!> name: rfuel
!> description: radius of fuel rod
        elseif (card.eq.'rfuel') then
          read (line,*) card, rfuel

!> name: apitch
!> description: total hex pitch (flat to flat)
        elseif (card.eq.'apitch') then
          read (line,*) card, apitch

!> name: matclad
!> description: clad material number
        elseif (card.eq.'matclad') then
          read (line,*) card, matclad

!> name: matbox
!> description: clad material number
        elseif (card.eq.'matbox') then
          read (line,*) card, matbox

!> name: matcool
!> description: clad material number
        elseif (card.eq.'matcool') then
          read (line,*) card, matcool

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
      write (*,20) 'ppitch', ppitch
      write (*,20) 'rinner', rinner
      write (*,20) 'rfuel ', rfuel
      write (*,24) 'irodside  ', irodside
      write (*,24) 'matclad   ', matclad,' material clad'
      write (*,24) 'matbox    ', matbox, ' material outer box'
      write (*,24) 'matcool   ', matcool,' material coolant'
   20 format (2x,a,f12.5)
   24 format (2x,a,1x,i0,2x,a)

      if (apitch.gt.0.0d0) then    ! input
        totedge=apitch/sqrt3
        if (xedge*ppitch.gt.totedge) stop 'apitch is too small'
      else
        totedge=xedge*ppitch
        apitch=totedge*sqrt3
      endif
      write (*,20) 'apitch', apitch

      write (*,*)
      write (*,*) ' pin pitch                              ', ppitch
      write (*,*) ' assembly pitch (flat to flat)          ', apitch
      write (*,*) ' total length on one side of triangle   ', totedge
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
!
!  Subroutine to expand input rod map (triangle) into hex numbering format
!  (should only be called by hex solver)
!
!=======================================================================

      subroutine expand_hex_map(nrod)
      implicit none

      integer, intent(out) :: nrod

      integer :: i, j, n, mm
      integer :: kr

!--- count rods

      nrod=1   ! center
      do i=2, irodside
        nrod=nrod+(i-1)*6
      enddo

      allocate (hexmap(nrod))
      hexmap(:)=0

!--- fill map

      n=1
      hexmap(n)=irodmap(1)

      kr=1   ! start of irodmap

      do j=2, irodside    ! loop over rows
        kr=kr+j-1  ! start of row in irodmap
        if (irodmap(kr).ne.irodmap(kr+j-1)) stop 'input rod map is not symmetric'
        do mm=1, 6
          do i=1, j
            if (.not.(i.eq.j .and. mm.eq.6)) then
              n=n+1
              hexmap(n)=irodmap(kr+i-1)
!d            write (*,*) 'debug: row, n, hexmap(n) ', j, n, hexmap(n), mm
            endif
          enddo
          n=n-1
        enddo
        n=n+1
!d      write (*,*) 'debug:'
      enddo

      write (*,*) 'final n ', n
      write (*,*) 'nrod    ', nrod
      if (n.ne.nrod) stop 'nrod error in expand_hex_map'

      return
      end subroutine expand_hex_map

!=======================================================================
   end module mod_input
