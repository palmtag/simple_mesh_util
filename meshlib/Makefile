FFLAGS = 
FC =
LDLIBS =

OBJ = Mod_vtklib3.o writemesh.o

FC = gfortran
FFLAGS = -O2 -fbacktrace -Wall
BOUNDS = -fbounds-check

.SUFFIXES :
.SUFFIXES : .f90 .o

default: Mod_vtklib3.o writemesh.o vtk2svg.exe

.f90.o :
	$(FC) $(FFLAGS) $(BOUNDS) -c $*.f90

vtk2svg.exe: Mod_trigeom.o vtk2svg.o readvtk.o
	$(FC) $(FFLAGS) $(BOUNDS) $^ -o $@

clean:
	rm -f *.o *.exe *.mod core

query:
	cvs -n update -P

update:
	cvs update -P


readvtk.o : Mod_trigeom.o
