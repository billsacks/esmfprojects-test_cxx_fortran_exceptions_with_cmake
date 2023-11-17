program testprog
  use iso_c_binding
  implicit none
  include 'mpif.h'
  interface
     subroutine normal_vec(seed, n, x) bind(c)
       import c_int, c_double
       integer(kind=c_int), intent(in), value :: seed, n
       real(kind=c_double)                    :: x(n)
     end subroutine normal_vec
  end interface
  !
  integer :: ier
  integer :: iam
  integer :: seed
  integer, parameter :: n = 5
  real(kind=c_double) :: x(n)
  !
  call mpi_init(ier)
  call mpi_comm_rank(MPI_COMM_WORLD, iam, ier)
  print *, 'Hello from processor ', iam
  do seed=1,3
     call normal_vec(seed,n,x)
     print "(*(1x,f7.4))",x
  end do
  call mpi_finalize(ier)
end program testprog
