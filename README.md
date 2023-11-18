## Purpose
This repository demonstrates the use of CMake to auto-determine the correct linker and link flags in cross-language (Fortran and C++) programs, enabling exception handling to work properly when there is a Fortran main program.

This determination of the correct linker and link flags has sometimes been a challenge for porting ESMF; e.g., this was one of the tricky things to get working in the Darwin gfortranclang port.

## Usage
Build with, for example:
```
FC=mpif90 CC=mpicc CXX=mpicxx cmake .
make VERBOSE=1
```

Then run with, for example:
```
mpirun -np 4 ./testprog
```

## What works, what doesn't
This works on the two Mac systems I have tested on – green and catania – with gfortran and either clang (on green) or gcc (on catania). It also works on cheyenne and derecho with gnu.

However, it does **not** work out-of-the-box on cheyenne or derecho with the intel compiler, I think because we may need to use a Fortran linker with the intel compiler: these give:

```
[100%] Linking CXX executable testprog
/glade/u/apps/ch/opt/cmake/3.18.2/bin/cmake -E cmake_link_script CMakeFiles/testprog.dir/link.txt --verbose=1
/glade/u/apps/ch/opt/ncarcompilers/0.5.0/intel/19.0.5/mpi/mpicxx -rdynamic CMakeFiles/testprog.dir/testing_f90.f90.o CMakeFiles/testprog.dir/testing_cpp.cpp.o -o testprog  -lifport -lifcoremt
/usr/lib64/gcc/x86_64-suse-linux/4.8/../../../../x86_64-suse-linux/bin/ld: /usr/lib64/gcc/x86_64-suse-linux/4.8/../../../../lib64/crt1.o: in function `_start':
/home/abuild/rpmbuild/BUILD/glibc-2.22/csu/../sysdeps/x86_64/start.S:114: undefined reference to `main'
CMakeFiles/testprog.dir/build.make:117: recipe for target 'testprog' failed
make[2]: *** [testprog] Error 1
```

It **does** work on cheyenne and derecho with the intel compiler if we add the following line at the end of CMakeLists.txt:

```
set_target_properties(testprog PROPERTIES LINKER_LANGUAGE Fortran)
```
