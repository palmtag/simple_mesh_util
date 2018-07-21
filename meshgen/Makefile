
MLIB=../meshlib

FC = gfortran
FFLAGS = -O2 -fbacktrace -Wall
BOUNDS = -fbounds-check

.SUFFIXES :
.SUFFIXES : .f .f90 .o

default: pinmesh.exe

pinmesh.exe: pinmesh.o Mod_vtklib3.o
	$(FC) $(FFLAGS) $^ -o $@

Mod_vtklib3.o: $(MLIB)/Mod_vtklib3.f90
	$(FC) $(FFLAGS) $^ -c

.f90.o :
	$(FC) $(FFLAGS) $(BOUNDS) -c $*.f90

.f.o :
	$(FC) $(FFLAGS) $(BOUNDS) -c $*.f

clean:
	rm -f *.o *.exe *.mod core

pinmesh.o: Mod_vtklib3.o
