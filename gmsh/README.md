# Triangle and Hexagonal Lattice Meshes

Programs that create ".geo" files that can be read by GMSH

## Running hex generator

1. First run createhex to generate ".geo" file

    > ./createhex.exe [input]           (generate gmsh script tri.geo)

2. Next run GMSH to create a gmsh ".msh" file

    > gmsh input.geo -format msh22 -2   (generate gmsh mesh file tri.msh)

3. Convert ".msh" file to VTK file

    > msh2vtk input.msh                 (convert msh file to vtk file)

## createhex sample cases
* VVER

    > ./createhex.exe inputv.inp

* PWR

    > ./createhex.exe inputpwr.inp

## createtri sample cases
* trilat3

    > ./createtri.exe 3       (3 hex edges)

* trilat24

    > ./createtri.exe 24.8    (24.5 pincells + gap region)

## GMSH options
* The "-2" specifies 2D mesh
* The "-format msh22" writes an older mesh file format
* If you get an error about unknown mesh format, you need to upgrade your version

# GMSH Info

* The version installed on Linux by default is 4.1.3 (old)
* Latest stable release Jun 2021 is 4.8.4 - see https://gmsh.info/

