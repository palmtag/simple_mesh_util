rm -f pin1.vtk pin1.svg pin2.vtk pin2.svg square.vtk square.svg
./pinmesh
./square
./triangle
../meshlib/vtk2svg pin1.vtk
../meshlib/vtk2svg pin2.vtk
../meshlib/vtk2svg square.vtk
../meshlib/vtk2svg tri1.vtk
../meshlib/vtk2svg tri2.vtk
../meshlib/vtk2svg tri3.vtk
cygstart pin1.svg
cygstart pin2.svg
cygstart square.svg
cygstart tri1.svg
cygstart tri2.svg
cygstart tri3.svg
