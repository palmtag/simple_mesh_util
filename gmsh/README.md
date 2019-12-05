# Triangle Lattice Meshes

To generate the sample problem meshes:

   > ./createtri XX                  (generate gmsh script tri.geo)
   > gmsh tri.geo -format msh22 -2   (generate gmsh mesh file tri.msh)
   > msh2vtk tri.msh                 (convert msh file to vtk file)


For trilat3.vtk, use XX=3

For trilat24.vtk, use XX=24.8


