# Makefile
# @version CVS $Id: Makefile,v 1.3 2015/04/27 12:49:43 scott Exp $
#--------------------------------------------

MLIB=../meshlib

FC = gfortran
FFLAGS = -O2 -fbacktrace -Wall -fbounds-check

.SUFFIXES :
.SUFFIXES : .f90 .o


default: msh2vtk.exe createlat.exe createtri.exe

msh2vtk.exe: Mod_vtklib3.o writemesh.o msh2vtk.o
	$(FC) $(FFLAGS) $^ -o $@

createlat.exe: createlat.o
	$(FC) $(FFLAGS) $^ -o $@

createtri.exe: createtri.o Mod_input.o
	$(FC) $(FFLAGS) $^ -o $@

Mod_vtklib3.o: ../meshlib/Mod_vtklib3.f90
	$(FC) $(FFLAGS) $(BOUNDS) ../meshlib/Mod_vtklib3.f90 -c -o $@

writemesh.o: ../meshlib/writemesh.f90
	$(FC) $(FFLAGS) $(BOUNDS) ../meshlib/writemesh.f90 -c -o $@

.f90.o :
	$(FC) $(FFLAGS) -c $*.f90

clean:
	rm -f core *.o *.mod msh2vtk.exe createlat.exe createtri.exe

createtri.o: Mod_input.o

