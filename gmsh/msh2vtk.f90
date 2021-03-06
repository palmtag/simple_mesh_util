   program msh2vtk
!=======================================================================
!
!  Simple program to read MSH file created by gmsh and convert to VTK
!
!  Scott Palmtag
!  2/2/2013
!
!  Reference:
!    Mesh description given in Chapter 9 of gmsh documentation
!        /usr/share/doc/gmsh
!
!    Website:  http://geuz.org/gmsh/
!
! Update
!   1. allow mesh version 2.1 and 2.2
!       v2.2 seems to generate more nodes and elements, and only makes two "maps" instead of three
!   2. completely restructure name list
!
! Update 2019/11/15 - ??
!
! Update 2021/01/13 - tested on GMSH version 4.7.1
!
!=======================================================================
      use mod_vtklib3
      implicit none

      integer :: ia

      integer :: i1, i2, i3
      integer :: i, j, k, ii, kk
      integer :: iorder=3    ! triangles
      integer :: nname=0     ! number of physical names
      integer :: nnode=0     ! number of nodes
      integer :: nelem=0     ! number of elements
      integer :: nzero

      integer :: nelx=0
      integer :: itype, ntag, itag(10)

      real(8) :: vsum
      real(8) :: xver
      real(8) :: xmax, xmin, ymax, ymin

!  names can be either regions or surfaces - check type

      integer, allocatable :: inametype(:)         ! (nname)    ! name type (1=surface, 2=region)
      integer, allocatable :: inamenum(:)          ! (nname)    ! name number (not in order)
      integer, allocatable :: inamecnt(:)          ! (nname)    ! number of elements in region
      integer, allocatable :: inumtoj(:)           ! (nname)    ! convert name number to stored number
      real(8), allocatable :: vreg(:)              ! (nname)    ! region areas
      character(len=20), allocatable :: cname(:)   ! (nname)    ! region labels

      real(8), allocatable :: elarea(:)  ! (nelem)   element areas
      real(8), allocatable :: xi(:,:)    ! (3,nnode)
      integer, allocatable :: gg(:,:)    ! (iorder,nelem)

      integer, allocatable :: isurf1(:)  ! (nnode)   outer surface numbers
      integer, allocatable :: isurf2(:)  ! (nnode)   rod surface number
      integer, allocatable :: imesh1(:)  ! (nelem)   region numbers
      integer, allocatable :: imesh2(:)  ! (nelem)
      integer, allocatable :: imesh4(:)  ! (nelem)   region types (calculated from names) regtyp
      integer, allocatable :: imesh5(:)  ! (nelem)   material num (calculated from names) matnum

      character(len=7)   :: c7
      character(len=20)  :: csurf1   ! OutBC
      character(len=100) :: line
      character(len=100) :: fname, fvtk, fmesh

      real(8), external :: areatri

!--- read command line and open file

      ia=iargc()
      if (ia.lt.1) stop 'usage: msh2vtk [file.msh]'
      call getarg(1,fname)

      write (*,'(2a)') 'reading msh file: ', trim(fname)
      open (12,file=fname,status='old')

      i=len_trim(fname)        ! modify name to remove ".msh"
      if (i.gt.4) then
        if (fname(i-3:i).eq.'.msh') fname(i-3:i)=' '
      endif

!--- read first block
!       $MeshFormat
!       2.1 0 8
!       $EndMeshFormat

      read (12,'(a)') line
      if (line.ne.'$MeshFormat') stop 'invalid title line'

      read (12,*) xver, i1, i2
      write (*,'(a,f8.4)') ' file version ', xver
      write (*,'(a,i0)')   ' file type    ', i1
! 2019 version is 4.1 - but we don't support yet
      if (abs(xver-2.1d0).gt.0.001d0 .and. abs(xver-2.2d0).gt.0.001d0) stop 'invalid mesh file version'
      if (i1.ne.0) stop 'invalid file type'
      if (i2.ne.8) then
        write (*,*) 'data size    ', i2
        stop 'invalid data size'
      endif

      read (12,'(a)') line
      if (line.ne.'$EndMeshFormat') stop 'invalid title line ending'

!--- read entities  (new in version 4.1)

      read (12,'(a)',end=100) line

      if (line.eq.'$Entities') then
        write (0,*) 'reading $Entities'
        read (12,*) i1, i2, i3
        do i=1, i1
          read (12,*)
        enddo
        do i=1, i2
          read (12,*)
        enddo
        do i=1, i3
          read (12,*)
        enddo
        read (12,'(a)') line
        if (line.ne.'$EndEntities') stop 'invalid end of entities'

        read (12,'(a)',end=100) line   ! read next line
      endif

!--- read physical names
!       $PhysicalNames
!       6
!       1 1 "OutBC"
!       1 2 "CladOD"
!       1 3 "CladID"
!       2 4 "RegCool"
!       2 5 "RegClad"
!       2 6 "RegFuel"
!       $EndPhysicalNames
!
!       1 256 "OutBC"
!       2 1 "RegFuel001"
!       2 2 "RegClad001"
!       2 3 "RegFuel002"
!       2 4 "RegClad002"
!       2 5 "RegFuel003"
!
!  if type=1 - 1D - surface names
!  if type=2 - 2D - region  names

      if (line.ne.'$PhysicalNames') then
        write (0,*) 'reading block: ', trim(line)
        write (0,*) 'expecting:     $PhysicalNames'
        stop 'invalid block'
      endif

      write (*,'(2a)') 'reading section: ', trim(line)
      read (12,*) nname   ! number of names (regions or surfaces)
      write (*,*) 'Number of names     nname =', nname

      allocate (inametype(nname))  ! region type
      allocate (inamenum(nname))   ! region number
      allocate (inumtoj(nname))    ! convert region number to stored number
      allocate (cname(nname))      ! region labels
      inametype(:)=0
      inamenum(:)=0
      inumtoj(:)=0

      cname(:)=' '

      do i=1, nname
        read (12,*) inametype(i), inamenum(i), cname(i)
      enddo

      read (12,'(a)') line
      if (line.ne.'$EndPhysicalNames') then
        write (0,'(2a)') 'read: ', trim(line)
        write (0,'(2a)') 'expecting: $EndPhysicalNames'
        stop 'invalid section ending'
      endif

      do i=1, nname
         if (inametype(i).eq.1) then        ! surface
           write (*,122) i, inamenum(i), trim(cname(i))
         elseif (inametype(i).eq.2) then    ! region
           write (*,120) i, inamenum(i), trim(cname(i))
         else
           stop 'unknown type'
         endif
      enddo
  120 format (2i5,' region  ', a)
  122 format (2i5,' surface ', a)

      do i=1, nname
        k=inamenum(i)
        if (inumtoj(k).eq.0) then
           inumtoj(k)=i
        else
           stop 'error filling mapping function'
        endif
      enddo

!--- read nodes
!      $Nodes
!      1770
!      1 2 0 0
!      2 2 2 0
!      3 0 2 0
!      4 0 0 0
!      etc.
!      $EndNodes

      read (12,'(a)') line
      write (*,*) 'reading block: ', trim(line)
      if (line.ne.'$Nodes') then
        write (0,*) 'expecting:     $Nodes'
        stop 'invalid block'
      endif

      read (12,*) nnode
      write (*,*) 'nnode = ', nnode
      allocate (xi(3,nnode))
      xi(:,:)=0.0d0
      do i=1, nnode
         read (12,*) ii, xi(1,ii), xi(2,ii), xi(3,ii)
         if (abs(xi(3,ii)).gt.0.00001d0) stop 'z coord is not zero'
         if (ii.ne.i) stop 'invalid node number'
      enddo
      read (12,'(a)') line
      if (line.ne.'$EndNodes') stop 'invalid section ending'

!--- read Elements
!       $Elements
!       3646
!       1 1 3 1 1 0 3 13
!       2 1 3 1 1 0 13 14
!       3 1 3 1 1 0 14 15
!       4 1 3 1 1 0 15 16
!       5 1 3 1 1 0 16 17
!       6 1 3 1 1 0 17 18
!       7 1 3 1 1 0 18 19
!       etc.
!  elm-number elm-type number-of-tags < tag > ... node-number-list
!     elm-type=1   2-node line
!     elm-type=2   3-node triangle
!
!  Note: file can include line elements and triangles, need to skip lines
!
      read (12,'(a)') line
      write (*,*) 'reading block: ', trim(line)
      if (line.ne.'$Elements') then
        write (0,*) 'reading block: ', trim(line)
        write (0,*) 'expecting:     $Elements'
        stop 'invalid block'
      endif

      read (12,*) nelx   ! number of elements in file (with line elements)
      allocate (gg(iorder,nelx))
      allocate (imesh1(nelx))   ! tag1 - region numbers
      allocate (imesh2(nelx))   ! tag2 - surface
      allocate (isurf1(nnode))  ! OutBC
      allocate (isurf2(nnode))
      isurf1(:)=0
      isurf2(:)=0
      csurf1='surf'
      imesh1(:)=-10
      imesh2(:)=-10
      nelem=0            ! only save triangle elements, gg is allocated too big
      do i=1, nelx
         read (12,'(a)') line
         read (line,*) ii, itype, ntag
         if (ii.ne.i) stop 'invalid element number'
         if (itype.eq.2) then   ! triangle
           nelem=nelem+1
           itag(:)=-100
           read (line,*) ii, itype, ntag, itag(1:ntag), gg(1:3,nelem)
           if (ntag.ge.1) imesh1(nelem)=itag(1)    ! region numbers (e.g. 4,5,6)
           if (ntag.ge.2) imesh2(nelem)=itag(2)    ! geometry entity (15,17,18)
         elseif (itype.eq.1) then
           read (line,*) ii, itype, ntag, itag(1:ntag), i1, i2
           if (ntag.ge.1) isurf1(i1)=itag(1)   ! if this is a line surface, assign to 2 nodes
           if (ntag.ge.1) isurf1(i2)=itag(1)
           if (ntag.ge.2) isurf2(i1)=itag(2)
           if (ntag.ge.2) isurf2(i2)=itag(2)
!d         write (*,*) 'debug: setting surf1 ', i1, i2, itag(1), itag(2)
         elseif (itype.eq.15) then  ! point
           write (*,*) 'ignoring point type in element list'
           continue
         else
           write (*,*) 'element ', i, ' type=', itype
           stop 'unknown element type'
         endif
      enddo
      read (12,'(a)') line
      if (line.ne.'$EndElements') stop 'invalid section ending'
      write (*,*) '   nelx  = ', nelx,' (includes line elements)'
      write (*,*) '   nelem = ', nelem

!---- end of file

   100 continue
       close (12)
       write (*,*) 'msh file is closed'

       write (*,*) 'nname = ', nname
       write (*,*) 'nnode = ', nnode
       write (*,*) 'nelem = ', nelem

!=====================================================

!--- calculate element volumes

      allocate (elarea(nelem))
      do i=1, nelem
        elarea(i)=areatri(xi(1,gg(1,i)),xi(2,gg(1,i)), &
                          xi(1,gg(2,i)),xi(2,gg(2,i)), &
                          xi(1,gg(3,i)),xi(2,gg(3,i)))
      enddo

      i=1
        xmax=xi(1,i)
        xmin=xi(1,i)
        ymax=xi(2,i)
        ymin=xi(2,i)
      do i=1, nnode
        xmax=max(xmax,xi(1,i))
        xmin=min(xmin,xi(1,i))
        ymax=max(ymax,xi(2,i))
        ymin=min(ymin,xi(2,i))
      enddo

!--- check region data
!     imesh1- region numbers  (4,5,6)
!     imesh2- geometry entity (15,17,18)

      write (*,*)
      write (*,*) 'check 2D regions: '

      allocate (vreg(nname))      ! region areas - allocate for all names, but only use for regions
      allocate (inamecnt(nname))  ! number of elements per region
      vreg(:)=0.0d0
      inamecnt(:)=0

      do i=1, nelem
        kk=inumtoj(imesh1(i))   ! convert name number to stored number
        inamecnt(kk)=inamecnt(kk)+1
        vreg(kk)  =vreg(kk)+elarea(i)
      enddo

  220 format (' sum of region',2i5,1x,a,i6, f12.6)
      ii=0
      vsum=0.0d0
      do j=1, nname
        if (inametype(j).eq.2) then   ! regions only
          write (*,220) j, inamenum(j), cname(j), inamecnt(j), vreg(j)
          ii=ii+inamecnt(j)
          vsum=vsum+vreg(j)
        endif
      enddo
      write (*,*) 'sum of region counts ', ii
      write (*,*) 'nelem                ', nelem
      if (ii.eq.nelem) then
        write (*,*) 'all elements assigned to a region'
      else
        write (*,*) '*** Not all elements assigned to a region ***'
      endif

      write (*,*)
      write (*,*) 'xmin max ', xmin, xmax
      write (*,*) 'ymin max ', ymin, ymax
      write (*,*) 'volume (if square) = ', (xmax-xmin)*(ymax-ymin)
      write (*,*) 'sum of reg volumes = ', vsum
      write (*,*)

!--- check surfaces
!  count number of nodes that have a surface
!  count number that do not have a surface
!  check sum

      write (*,*)
      write (*,*) 'check 1D surfaces:'

      nzero=0            ! nodes without surface
      do i=1, nnode
        j=isurf1(i)          ! surface type, not the surface number
        if (j.eq.0) then
          nzero=nzero+1
        else
          kk=inumtoj(isurf1(i))   ! convert name number to stored number
          inamecnt(kk)=inamecnt(kk)+1
          csurf1=cname(kk)
          if (inametype(kk).ne.1) stop 'surface type is not 1'
        endif
      enddo

  230 format (' sum of surface',i4,1x,a,i6)
      ii=nzero
      do j=1, nname
        if (inametype(j).eq.1) then   ! surfaces only
          write (*,230) j, cname(j), inamecnt(j)
          ii=ii+inamecnt(j)
        endif
      enddo
      write (*,230) 0, '(no surface)        ', nzero
      write (*,*) 'sum of surfaces', ii
      write (*,*) 'nnode          ', nnode

      deallocate (inamecnt)
      deallocate (vreg)

!--- define region types (hardwired to names)

      write (*,*)
      write (*,*) 'Hardwired region numbers'
      write (*,*) ' 1 = RegFuel'
      write (*,*) ' 2 = RegClad'
      write (*,*) ' 3 = RegCool'

      allocate (imesh4(nelem))   ! region type
      allocate (imesh5(nelem))   ! material numbers
      imesh4(:)=0
      imesh5(:)=0
      do i=1, nelem
        j=imesh1(i)   ! internal region number, need to find region in list
        kk=inumtoj(imesh1(i))   ! convert name number to stored number
        c7=cname(kk)(1:7)
        if     (c7.eq.'RegFuel') then
          imesh4(i)=1
        elseif (c7.eq.'RegClad') then
          imesh4(i)=2
        elseif (c7.eq.'RegCool') then
          imesh4(i)=3
        endif
        if (c7(1:3).eq.'Mat') then
          read (c7(4:6),*) imesh5(i)
        endif
!       write (*,*) 'element ', i, kk, imesh4(i)
      enddo

      deallocate (inametype)
      deallocate (inamenum)
      deallocate (inumtoj)
      deallocate (cname)

!--- edits

      write (*,*)
      write (*,*) trim(csurf1)
      call kminmax(nnode, isurf1)
      write (*,*)
      write (*,*) 'RodSurface'
      call kminmax(nnode, isurf2)
      write (*,*)
      write (*,*) 'Region/hexnum'
      call kminmax(nelem, imesh1)
      write (*,*)
      write (*,*) 'geom_entity'
      call kminmax(nelem, imesh2)
      write (*,*)
      write (*,*) 'regtype'
      call kminmax(nelem, imesh4)
      write (*,*)
      write (*,*) 'material'
      call kminmax(nelem, imesh5)

!--- convert arrays to Lupine format

      if (csurf1.eq.'OutBC') then
        csurf1='bc'
        do i=1, nnode
          if (isurf1(i).gt.0) isurf1(i)=3
        enddo
      else
        write (*,*) 'WARNING: OutBC not found'
      endif

!--- write to VTK file

      fvtk=trim(fname)//'.vtk'
      write (*,'(/,2a)') ' creating vtk file: ', trim(fvtk)
      write (*,*)        '    nnode ', nnode
      write (*,*)        '    nelem ', nelem

      open (22,file=fvtk)
      call vtk_tri1(22, nnode, nelem, iorder, xi, gg)
      call vtk_tri2(22, nnode, isurf1, trim(csurf1),  'n')  ! nodal data
      call vtk_tri2(22, nnode, isurf2, 'RodSurface',  ' ')
      call vtk_tri2(22, nelem, imesh1, 'hexnum',      'e')  ! elem data  ! was "region"
!x    call vtk_tri2(22, nelem, imesh2, 'geom_entity', ' ')
!x    call vtk_tri2(22, nelem, imesh4, 'regtype', ' ')
      call vtk_tri2(22, nelem, imesh5, 'material',' ')
      close (22)

!--- write to binary mesh file

!     fmesh=trim(fname)//'.mesh'
!     write (*,'(/,2a)') ' creating binary mesh file: ', trim(fmesh)
!     call writemesh(fmesh, nnode, nelem, xi, gg, imesh1, isurf1)

!--- finish

      deallocate (xi,gg)
      deallocate (isurf1, isurf2)
      deallocate (imesh1, imesh2)
      deallocate (elarea)
      deallocate (imesh4)
      end

!=======================================================================
!
!  Subroutine to find min/max values
!
!=======================================================================
      subroutine kminmax(nsize, idata)
      implicit none
      integer, intent(in) :: nsize
      integer, intent(in) :: idata(nsize)

      integer :: i, kmin, kmax, izero
      real(8) :: xave

      xave=0.0d0
      izero=0   ! number of zeros

      kmin=idata(1)
      kmax=idata(1)
      do i=1, nsize
        kmin=min(kmin,idata(i))
        kmax=max(kmax,idata(i))
        xave=xave+dble(idata(i))
        if (idata(i).eq.0) izero=izero+1
      enddo
      xave=xave/dble(nsize)
      write (*,*) '  min = ', kmin
      write (*,*) '  ave = ', xave
      write (*,*) '  max = ', kmax
      write (*,*) '  number of zeros ', izero,' of ', nsize
      return
      end subroutine kminmax
!=======================================================================
!
!  Function to calculate area of triangle given three coordinates
!
!=======================================================================
      function areatri(ax,ay,bx,by,cx,cy)
      implicit none
      real(8) :: areatri
      real(8) :: ax,ay,bx,by,cx,cy
      real(8) :: tmp

      tmp=ax*(by-cy) + bx*(cy-ay) + cx*(ay-by)
      areatri=abs(tmp)*0.5d0

      return
      end function areatri
!=======================================================================
