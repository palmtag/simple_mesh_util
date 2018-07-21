rm -f pin1.vtk pin1.svg pin2.vtk pin2.svg
./pinmesh
../meshlib/vtk2svg pin1.vtk
../meshlib/vtk2svg pin2.vtk
cygstart pin1.svg
cygstart pin2.svg
