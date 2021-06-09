#!/bin/bash

#  Run test suite and compare results to samples directory

clist="pin1 pin2 square cube tri1 tri2 tri3"

# clean up old cases
for case in $clist; do
  rm -f $case.vtk $case.svg
done

# run cases
./pinmesh.exe
./square.exe 10
./triangle.exe
./cube.exe 10

# compare to reference

# Note: svg file cannot be created for cube

for case in $clist; do

  echo "========================="
  echo "  Comparing $case vtk"

  diff $case.vtk ../samples

  ../meshlib/vtk2svg.exe $case.vtk

  echo "  Comparing $case svg"
  diff $case.svg ../samples

# cygstart pin1.svg
# cygstart pin2.svg
# cygstart square.svg
# cygstart tri1.svg
# cygstart tri2.svg
# cygstart tri3.svg

done
