# Triangle Lattice Meshes

To generate the sample problem meshes:

    > ./createtri.exe XX              (generate gmsh script tri.geo)
    > gmsh tri.geo -format msh22 -2   (generate gmsh mesh file tri.msh)
    > msh2vtk tri.msh                 (convert msh file to vtk file)

## createtri options
* See comments at top of code for more details
* For trilat3.vtk, use XX=3  (3 hex edges)
* For trilat24.vtk, use XX=24.8  (24.8 hex edges - adds gap)

## GMSH options
* The "-2" specifies 2D mesh
* The "-format msh22" writes an older mesh file format



## Update January 2021 - gmsh 4.1.3

* error message: Unknown mesh format 'msh22'

