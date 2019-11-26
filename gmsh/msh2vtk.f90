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
! Update 11/15/2019 - ??
!
! @version CVS $Id: msh2vtk.f90,v 1.11 2018/07/11 23:14:52 scott Exp $
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

      logical :: ifmesh3

      real(8) :: vsum
      real(8) :: xver
      real(8) :: xmax, xmin, ymax, ymin

!  names can be either regions or surfaces - check type

      integer, allocatable :: inametype(:)         ! (nname)    ! name type (1=surface, 2=region)
      integer, allocatable :: inamenum(:)          ! (nname)    ! name number
      integer, allocatable :: inamecnt(:)          ! (nname)    ! number of elements in region
      real(8), allocatable :: vreg(:)              ! (nname)    ! region areas
      character(len=20), allocatable :: cname(:)   ! (nname)    ! region labels

      real(8), allocatable :: elarea(:)  ! (nelem)   element areas
      real(8), allocatable :: xi(:,:)    ! (3,nnode)
      integer, allocatable :: gg(:,:)    ! (iorder,nelem)

      integer, allocatable :: isurf1(:)  ! (nnode)   outer surface numbers
      integer, allocatable :: isurf2(:)  ! (nnode)   rod surface number
      integer, allocatable :: imesh1(:)  ! (nelem)   region numbers
      integer, allocatable :: imesh2(:)  ! (nelem)
      integer, allocatable :: imesh3(:)  ! (nelem)
      integer, allocatable :: imesh4(:)  ! (nelem)   region types (calculated from names)

      character(len=7)   :: c7
      character(len=20)  :: csurf1
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
!  if type=1 - 1D - surface names
!  if type=2 - 2D - region  names

      if (line.ne.'$PhysicalNames') then
        write (0,*) 'reading block: ', trim(line)
        write (0,*) 'expecting:     $PhysicalNames'
        stop 'invalid block'
      endif

      write (*,'(2a)') 'reading section: ', trim(line)
      read (12,*) nname   ! number of names (regions or surfaces)
      write (*,*) 'nname =', nname

      allocate (inametype(nname))  ! region type
      allocate (inamenum(nname))   ! region number
      allocate (cname(nname))      ! region labels
      inametype(:)=0
      inamenum(:)=0

      cname(:)=' '

      do i=1, nname
        read (12,*) inametype(i), inamenum(i), cname(i)
      enddo

      read (12,'(a)') line
      if (line.ne.'$EndPhysicalNames') then
        write (0,'(2a)') 'read: ', trim(line)
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
      allocate (imesh3(nelx))   ! tag3 - ??  not used in 2D problems?

      allocate (isurf1(nnode))
      allocate (isurf2(nnode))
      isurf1(:)=0
      isurf2(:)=0
      csurf1='surf'

      imesh1(:)=-10
      imesh2(:)=-10
      imesh3(:)=-10
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
           if (ntag.ge.3) imesh3(nelem)=itag(3)
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
!     imesh3- not used?  (in version 2.1 only?)

      write (*,*)
      write (*,*) 'check 2D regions: '

      allocate (vreg(nname))      ! region areas - allocate for all names, but only use for regions
      allocate (inamecnt(nname))  ! number of elements per region
      vreg(:)=0.0d0
      inamecnt(:)=0

      do i=1, nelem
        j=imesh1(i)   ! region number, need to find region in list
        kk=0
        do k=1, nname
          if (inamenum(k).eq.j) kk=k
        enddo
        if (kk.eq.0) then
          write (*,*) '*** ERROR: could not find region for element/region ', i, j
!         stop 'region number not found'
        else
          inamecnt(kk)=inamecnt(kk)+1
          vreg(kk)  =vreg(kk)+elarea(i)
        endif
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
          kk=0
          do k=1, nname
            if (inamenum(k).eq.j) kk=k
          enddo
          if (kk.gt.0) then
             inamecnt(kk)=inamecnt(kk)+1
             csurf1=cname(kk)
             if (inametype(kk).ne.1) stop 'surface type is not 1'
          endif
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

!--- check mesh3 - not used with new file version?

      ifmesh3=.false.    ! flag to write mesh3 to VTK file
      do i=1, nelem
        if (imesh3(i).ne.-10) then
           write (*,*) 'imesh3', i, imesh3(i)
           ifmesh3=.true.
        endif
      enddo

!--- define region types (hardwired to names)

      write (*,*) 'Hardwired region numbers'
      write (*,*) ' 1 = RegFuel'
      write (*,*) ' 2 = RegClad'
      write (*,*) ' 3 = RegCool'

      allocate (imesh4(nelem))
      imesh4(:)=0
      do i=1, nelem
        j=imesh1(i)   ! region number, need to find region in list
        kk=0
        do k=1, nname
          if (inamenum(k).eq.j) kk=k
        enddo
        if (kk.eq.0) then
          write (*,*) '*** ERROR: could not find region for element/region ', i, j
!         stop 'region number not found'
        else
          c7=cname(kk)(1:7)
          if     (c7.eq.'RegFuel') then
            imesh4(i)=1
          elseif (c7.eq.'RegClad') then
            imesh4(i)=2
          elseif (c7.eq.'RegCool') then
            imesh4(i)=3
          endif
        endif
!       write (*,*) 'element ', i, kk, imesh4(i)
      enddo

!--- write to VTK file

      fvtk=trim(fname)//'.vtk'
      write (*,'(/,2a)') ' creating vtk file: ', trim(fvtk)
      write (*,*)        '    nnode ', nnode
      write (*,*)        '    nelem ', nelem

      open (22,file=fvtk)
      call vtk_tri1(22, nnode, nelem, iorder, xi, gg)
      call vtk_tri2(22, nnode, isurf1, trim(csurf1),  'n')  ! nodal data
      call vtk_tri2(22, nnode, isurf2, 'surf2',  ' ')
      call vtk_tri2(22, nelem, imesh1, 'region', 'e')  ! elem data
      call vtk_tri2(22, nelem, imesh2, 'geom_entity', ' ')
      if (ifmesh3) call vtk_tri2(22, nelem, imesh3, 'imesh3', ' ')
      call vtk_tri2(22, nelem, imesh4, 'regtype', ' ')
      close (22)

!--- write to binary mesh file

      fmesh=trim(fname)//'.mesh'
      write (*,'(/,2a)') ' creating binary mesh file: ', trim(fmesh)

      call writemesh(fmesh, nnode, nelem, xi, gg, imesh1, isurf1)

!--- finish

      deallocate (xi,gg)
      deallocate (isurf1, isurf2)
      deallocate (imesh1, imesh2, imesh3)
      deallocate (elarea)
      deallocate (imesh4)
      end

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
