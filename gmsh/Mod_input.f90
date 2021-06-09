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
      integer :: matouter        ! material of outer gap (default to matcool)

      logical :: ifsquare        ! hex or square problem?

      real(8) :: ppitch=1.60d0   ! ppitch
      real(8) :: triedge         ! length of one side of triangle
      real(8) :: apitch          ! total assembly pitch (flat to flat)
      real(8) :: boxth           ! channel box thickness
      real(8) :: bsize           ! outer box size (outside flat to flat)

      integer, allocatable :: hexmap(:)

      real(8), parameter :: sqrt3=sqrt(3.0d0)

      character(len=200) :: fbase    ! base input file name without suffix

!  internal

      integer, private :: nrodmap
      integer, allocatable, private :: irodmap(:)

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
      logical :: ifrodmap

      integer :: itmp(maxring)
      real(8) :: xtmp(maxring)

      real(8) :: xlen

      integer, parameter :: maxrod=600
      character(len=4)   :: crodmap(maxrod)

      character(len=4)   :: ctmp
      character(len=12)  :: card
      character(len=100) :: line

!--- initialize

!d    write (0,*) 'trace: start input'

      apitch=-100.0d0
      triedge=-100.0d0
      boxth=0.0d0
      bsize=-100.0d0

      matbox =0
      matcool=0
      matouter=-100   ! default to matcool

      ifsquare=.false.

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

!> name: square
!> description: number of rods along one side
        elseif (card.eq.'square') then
          read (line,*) card
          ifsquare=.true.

!> name: ppitch
!> description: pin pitch
        elseif (card.eq.'ppitch') then
          read (line,*) card, ppitch

!> name: apitch
!> description: total hex pitch (flat to flat)
!> note: use either "apitch" or "triedge", but not both
        elseif (card.eq.'apitch') then
          read (line,*) card, apitch

!> name: triedge
!> description: length of edge of inner triangle
!> note: use either "apitch" or "triedge", but not both
        elseif (card.eq.'triedge') then
          read (line,*) card, triedge

!> name: boxth
!> description: channel box thickness
        elseif (card.eq.'boxth') then
          read (line,*) card, boxth

!> name: bsize
!> description: channel box size (outside flat to flat)
        elseif (card.eq.'bsize') then
          read (line,*) card, bsize

!> name: pinrad
!> description: list of pin radii for a single pin type
        elseif (card.eq.'pinrad') then
          xtmp=-100.0d0
          read (line,*) card, ctmp, xtmp(:)
          call fill_pinrad(ctmp, xtmp)

!> name: pinmat
!> description: list of pin materials for a single pin type
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

!> name: matouter
!> description: material number of outer gap region (default to matcool)
        elseif (card.eq.'matouter') then
          read (line,*) card, matouter

!> name: rodmap
!> description: array of rod types, start on next line
        elseif (card.eq.'rodmap') then
          ifrodmap=.true.
          read (line,*) card
          read (linp,*) (crodmap(i),i=1,maxrod)

        else
          write (0,   *) 'ERROR: invalid input card ', card
          stop 'invalid input card'
        endif

      enddo
  800 continue

      close (linp)

!--- write input

      if (ifsquare) write (*,*) 'This is a SQUARE problem'

      write (*,24) 'nrow      ', irodside
      write (*,24) 'matbox    ', matbox, ' material outer box'
      write (*,24) 'matcool   ', matcool,' material coolant'
      if (matouter.ge.0) then
        write (*,24) 'matouter  ', matouter,' material outer gap region'
      else
        matouter=matcool   ! use default value
      endif
   20 format (2x,a,f12.5)
   24 format (2x,a,1x,i0,2x,a)

      if (apitch.gt.0.0d0 .and. triedge.lt.0.0d0) then
        triedge=apitch/sqrt3
      elseif (apitch.lt.0.0d0 .and. triedge.gt.0.0d0) then
        apitch=triedge*sqrt3
      else
        write (*,*) 'user must enter either "apitch" or "triedge", but not both'
        stop 'triedge and apitch cannot both be used'
      endif

      if (bsize.le.0.0d0) bsize=apitch   ! default no gap

      write (*,20) 'ppitch ', ppitch
      write (*,20) 'apitch ', apitch
      write (*,20) 'triedge', triedge
      write (*,20) 'boxth  ', boxth
      write (*,20) 'bsize  ', bsize

      write (*,*) ' assembly pitch (flat to flat)          ', apitch
      write (*,*) ' total length on one side of triangle   ', triedge
      write (*,*)

! the assembly pitch could be a little smaller,
! it depends on size of rods on outside border
! this check is conservative
      if (ifsquare) then
        if (apitch.lt.irodside*ppitch) then
          write (0,*) 'assembly pitch is too small'
          write (0,*) 'apitch must be at least ', irodside*ppitch
          stop 'assembly pitch too small'
        endif
      else
        xlen=(dble(irodside)-0.5d0)*ppitch
        if (triedge.lt.xlen) then
          write (0,*) 'assembly pitch is too small'
          write (0,*) 'triedge must be at least ', xlen
          stop 'assembly pitch too small'
        endif
      endif

      if (matcool.le.0) then
        stop 'invalid matcool'
      endif
      if (boxth.gt.0.0d0 .and. matbox.le.0) then
        stop 'invalid matbox when boxth specified'
      endif

!--- pin types

      if (npintype.le.0) then
        stop 'no pin descriptions have been entered in input'
      endif

      do i=1, npintype
        associate (pp => pintype(i))
          write (*,120) pp%pname, (pp%pinrad(j),j=1,pp%nring)
          write (*,125) pp%pname, (pp%pinmat(j),j=1,pp%nring)
        end associate
      enddo
  120 format ('  pinrad ', a, 50f9.5)
  125 format ('  pinmat ', a, 50(i6,3x))

!--- calculate number of rods in problem triangle

      if (ifsquare) then
        nrodmap=irodside*irodside   ! number of rods in square

        if (ifrodmap) then
          write (*,*)
          write (*,*) 'input rod map:'
          n=0
          do i=1, irodside
             write (*,44) (crodmap(n+j),j=1,irodside)
             do j=1, irodside
               if (crodmap(n+j).eq.' ') stop 'zero found in pin map'
             enddo
             n=n+irodside
          enddo
          if (n.ne.nrodmap) stop 'invalid pin map size'
          if (crodmap(n+1).ne.' ') stop 'too many entries on rodmap'
          write (*,*) 'number of rods in map = ', nrodmap
          write (*,*)
        endif
  44  format (4x,50a4)

      else

!--- calculate number of rods in problem triangle

        nrodmap=1   ! number of rods in triangle map, not in hex
        do i=2, irodside
          nrodmap=nrodmap+i
        enddo

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
          if (n.ne.nrodmap) stop 'invalid pin map size'
          if (crodmap(n+1).ne.' ') stop 'too many entries on rodmap'
          write (*,*) 'number of rods in map = ', nrodmap
          write (*,*)
        endif

      endif   ! square check

  40  format (50a4)

!--- fill irodmap

      allocate (irodmap(nrodmap))
      if (ifrodmap) then
        do i=1, nrodmap
          irodmap(i)=find_pintype(crodmap(i),0)
        enddo
      else
        irodmap(:)=1    ! default to first pin type entered
      endif

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

!--- count rods in hexagon

      nrod=1   ! center
      do i=2, irodside
        nrod=nrod+(i-1)*6
      enddo

      allocate (hexmap(nrod))
      hexmap(:)=0

!--- fill map - expand triangle input map into hexagon map

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

      deallocate (irodmap)

      return
      end subroutine expand_hex_map
!=======================================================================
      subroutine expand_square_map(nrod)
      implicit none

      integer, intent(out) :: nrod

      integer :: n

!--- count rods in square

      nrod=irodside*irodside

      allocate (hexmap(nrod))
      hexmap(:)=0

      do n=1, nrod
        hexmap(n)=irodmap(n)
      enddo

      deallocate (irodmap)

      return
      end subroutine expand_square_map

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
