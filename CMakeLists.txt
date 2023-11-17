# I'm not sure what version is actually required
cmake_minimum_required(VERSION 3.0)

project(my-project LANGUAGES C CXX Fortran)

include(FortranCInterface)
FortranCInterface_VERIFY(CXX)
find_package(MPI REQUIRED)

add_executable(testprog testing_f90.f90 testing_cpp.cpp)
