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
