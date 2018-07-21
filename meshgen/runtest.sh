rm -f pin1.vtk pin1.svg pin2.vtk pin2.svg square.vtk square.svg
./pinmesh
./square
../meshlib/vtk2svg pin1.vtk
../meshlib/vtk2svg pin2.vtk
../meshlib/vtk2svg square.vtk
cygstart pin1.svg
cygstart pin2.svg
cygstart square.svg
