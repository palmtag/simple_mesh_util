# Triangle Lattice Meshes

To generate the sample problem meshes:

    > ./createtri.exe [input]         (generate gmsh script tri.geo)
    > gmsh tri.geo -format msh22 -2   (generate gmsh mesh file tri.msh)
    > msh2vtk tri.msh                 (convert msh file to vtk file)

## createtri input files
* input3 used to create sample "trilat3.vtk"  (3 hex edges)
* input24 used to create sample "trilat24.vtk" (24.5 pincells + gap region)

## GMSH options
* The "-2" specifies 2D mesh
* The "-format msh22" writes an older mesh file format
* If you get an error about unknown mesh format, you need to upgrade your version

# GMSH Info

* The version installed on Linux is 4.1.3 (old)
* Latest stable release Jan 2021 is 4.7.1 - see https://gmsh.info/

