# Triangle and Hexagonal Lattice Meshes

## Running hex generator

    > ./createhex.exe [input]           (generate gmsh script tri.geo)
    > gmsh input.geo -format msh22 -2   (generate gmsh mesh file tri.msh)
    > msh2vtk input.msh                 (convert msh file to vtk file)

## createhex sample cases
* vver.vtk  use "./createhex.exe inputv.inp"
* pwr.vtk   use "./createhex.exe inputpwr.inp"

## createtri sample cases
* trilat3.vtk  use "./createtri.exe 3"      (3 hex edges)
* trilat24.vtk use "./createtri.exe 24.8"   (24.5 pincells + gap region)

## GMSH options
* The "-2" specifies 2D mesh
* The "-format msh22" writes an older mesh file format
* If you get an error about unknown mesh format, you need to upgrade your version

# GMSH Info

* The version installed on Linux is 4.1.3 (old)
* Latest stable release Jan 2021 is 4.7.1 - see https://gmsh.info/

