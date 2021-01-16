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
      integer :: matbox          ! outer box material number
      integer :: matcool         ! coolant material number

      real(8) :: ppitch=1.60d0   ! ppitch
!     real(8) :: rinner=0.0d0    ! radius of fuel pellet  (0=no inner region)
!     real(8) :: rfuel=0.706d0   ! radius of outer fuel rod
      real(8) :: totedge         ! total length of one side of triangle
      real(8) :: apitch          ! total assembly pitch (flat to flat) (optional)

      logical :: iffull          ! flag if pins on bottom row are full or half

      integer, private, parameter :: maxrod=600
      integer, private :: irodmap(maxrod)
      logical, private :: ifrodmap
      integer, private :: nrodmap

      character(len=4), private :: crodmap(maxrod)

      integer, allocatable :: hexmap(:)

      real(8), parameter :: sqrt3=sqrt(3.0d0)

      character(len=200) :: fbase    ! base input file name without suffix

!  "ppitch" is equivalent to Newt "hexprism" times 2

      integer, parameter :: maxpintype=10
      integer, parameter :: maxring=10

      integer :: npintype

      type :: pintype_type
         integer :: nring           ! number of rings
         integer :: pinmat(maxring) ! ring material
         real(8) :: pinrad(maxring) ! ring radii
         character(len=4) :: pname  ! pin type name
      end type pintype_type
      type(pintype_type) :: pintype(maxpintype)


   contains
!=======================================================================
!
!  Subroutine to read input for mesh generator
!
!=======================================================================
      subroutine readinput(fname)
      implicit none

      character(len=*), intent(in) :: fname

!--- locals

      integer :: linp=22    ! input unit number
      integer :: i, j, k, n

      integer :: itmp(maxring)
      real(8) :: xtmp(maxring)

      character(len=4)   :: ctmp
      character(len=12)  :: card
      character(len=100) :: line

!--- initialize

      apitch=-100.0d0
      totedge=-100.0d0

      matbox =0
      matcool=0

      irodmap=0
      crodmap=' '
      ifrodmap=.false.
      nrodmap=0   ! number of rods in map

      npintype=0
      do i=1, maxpintype
        pintype(i)%nring=0         ! number of rings
        pintype(i)%pinmat(:)=0     ! ring material
        pintype(i)%pinrad(:)=0.0d0 ! ring radii
        pintype(i)%pname=' '       ! pin type name
      enddo

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

!> name: nrow
!> description: number of rods along one side
        if     (card.eq.'nrow') then
          read (line,*) card, irodside

!> name: ppitch
!> description: pin pitch
        elseif (card.eq.'ppitch') then
          read (line,*) card, ppitch


!> name: apitch
!> description: total hex pitch (flat to flat)
        elseif (card.eq.'apitch') then
          read (line,*) card, apitch

!> name: pinrad
!> description: pin radii for a single pin type
        elseif (card.eq.'pinrad') then
          xtmp=-100.0d0
          read (line,*) card, ctmp, xtmp(:)
          call fill_pinrad(ctmp, xtmp)

!> name: pinmat
!> description: pin materials for a single pin type
        elseif (card.eq.'pinmat') then
          itmp=-100
          read (line,*) card, ctmp, itmp(:)
          call fill_pinmat(ctmp, itmp)

!> name: matbox
!> description: outer box material number
        elseif (card.eq.'matbox') then
          read (line,*) card, matbox

!> name: matcool
!> description: coolant material number
        elseif (card.eq.'matcool') then
          read (line,*) card, matcool

!> name: rodmap
!> description: array of rod types, start on next line
        elseif (card.eq.'rodmap') then
          ifrodmap=.true.
          read (line,*) card
          read (linp,*) (crodmap(i),i=1,maxrod)

        elseif (card.eq.'xedge') then
          read (line,*) card
          stop 'xedge card is no longer valid'

        elseif (card.eq.'rinner') then
          read (line,*) card
          stop 'rinner is no longer valid input'

        elseif (card.eq.'rfuel') then
          read (line,*) card
          stop 'rinner is no longer valid input'

        else
          write (0,   *) 'ERROR: invalid input card ', card
          stop 'invalid input card'
        endif

      enddo
  800 continue

      close (linp)

!--- write input

      write (*,20) 'ppitch ', ppitch
      write (*,24) 'nrow      ', irodside
      write (*,24) 'matbox    ', matbox, ' material outer box'
      write (*,24) 'matcool   ', matcool,' material coolant'
   20 format (2x,a,f12.5)
   24 format (2x,a,1x,i0,2x,a)

      if (apitch.le.0.0d0 .and. totedge.le.0.0d0) then
        stop 'either apitch or totedge must be entered'
      endif

      if (apitch.gt.0.0d0 .and. totedge.lt.0.0d0) then    ! input
        totedge=apitch/sqrt3
      elseif (apitch.lt.0.0d0 .and. totedge.gt.0.0d0) then    ! input
        apitch=totedge*sqrt3
      else
        stop 'totedge and apitch cannot both be used'
      endif

      write (*,20) 'apitch ', apitch
      write (*,20) 'totedge', totedge

      write (*,*)
      write (*,*) ' pin pitch                              ', ppitch
      write (*,*) ' assembly pitch (flat to flat)          ', apitch
      write (*,*) ' total length on one side of triangle   ', totedge
      write (*,*)

!--- pin types

      do i=1, npintype
        associate (pp => pintype(i))
          write (*,*) 'pinrad ', pp%pname, (pp%pinrad(j),j=1,pp%nring)
          write (*,*) 'pinmat ', pp%pname, (pp%pinmat(j),j=1,pp%nring)
        end associate
      enddo

!--- calculate number of rods in problem

      iffull=.true.
      if (irodside.eq.0) then    ! calculate size, was not input
!       if (abs(xedge - nint(xedge)).lt.0.001) then    ! whole number, so half pin on bottom
!         iffull=.false.
!         write (*,*) 'bottom row is split rods'
!         irodside=nint(xedge)+1
!       elseif (abs(xedge+0.0001d0 - int(xedge)).ge.0.5d0) then   ! fraction, so full pin on bottom + possible gap
!         write (*,*) 'bottom row is full rods'
!         irodside=int(xedge)+1
!       else
!         stop 'invalid xedge fraction - fraction must be zero or greater than 0.5'
!       endif
        stop '***** need new way to calculate iffull for triangles *****'
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
           write (*,40) (crodmap(n+j),j=1,i)
           do j=1, i
             if (crodmap(n+j).eq.' ') stop 'zero found in pin map'
           enddo
           n=n+i
        enddo
        nrodmap=n
        if (crodmap(n+1).ne.' ') stop 'too many entries on rodmap'
        write (*,*) 'number of rods in map = ', nrodmap
        write (*,*)

        do i=1, nrodmap
          irodmap(i)=find_pintype(crodmap(i),0)
        enddo

      else
        irodmap=1    ! default
      endif
  40  format (50a4)

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
      subroutine fill_pinmat(ctmp, itmp)
      implicit none
      character(len=4), intent(in) :: ctmp
      integer,          intent(in) :: itmp(maxring)

      integer :: itype
      integer :: ir
      integer :: i

!--- find pintype

      itype=find_pintype(ctmp, 1)

!---- find number of rings

      ir=0
      do i=maxring, 1, -1
        if (itmp(i).gt.0) then
          ir=i
          exit
        endif
      enddo
      if (ir.eq.0) stop 'no rings defined in input'
      if (pintype(itype)%nring.eq.0) then
        pintype(itype)%nring=ir
      else
        if (ir.ne.pintype(itype)%nring) stop 'unmatched rings in material'
      endif

!--- fill

      do i=1, ir
        pintype(itype)%pinmat(i)=itmp(i)
      enddo

      return
      end subroutine fill_pinmat

!=======================================================================
      subroutine fill_pinrad(ctmp, xtmp)
      implicit none
      character(len=4), intent(in) :: ctmp
      real(8),          intent(in) :: xtmp(maxring)

      integer :: itype
      integer :: ir
      integer :: i

!--- find pintype

      itype=find_pintype(ctmp, 1)

!---- find number of rings

      ir=0
      do i=maxring, 1, -1
        if (xtmp(i).gt.0.0d0) then
          ir=i
          exit
        endif
      enddo
      if (ir.eq.0) stop 'no rings defined in input'
      if (pintype(itype)%nring.eq.0) then
        pintype(itype)%nring=ir
      else
        if (ir.ne.pintype(itype)%nring) stop 'unmatched rings in material'
      endif

!--- fill

      do i=1, ir
        pintype(itype)%pinrad(i)=xtmp(i)
      enddo

      return
      end subroutine fill_pinrad

!=======================================================================
      integer function find_pintype(ctmp, iopt)
      implicit none
      character(len=4), intent(in) :: ctmp
      integer,          intent(in) :: iopt   ! 1=allow new, 0 no

      integer :: itype
      integer :: i

!--- find pintype

      itype=0
      do i=1, npintype
        if (ctmp.eq.pintype(i)%pname) itype=i
      enddo
      if (itype.eq.0 .and. iopt.eq.1) then   ! create new type
        npintype=npintype+1
        itype=npintype
        if (npintype.gt.maxpintype) stop 'maxpintype exceeded'
        pintype(itype)%pname=ctmp
      endif
      if (itype.eq.0) then
        write (*,*) 'could not find pin type ', ctmp
        stop 'could not find pin type'
      endif

      find_pintype=itype

      return
      end function find_pintype

!=======================================================================
   end module mod_input
