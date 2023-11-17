#include <iostream>
#include <exception>
#include <stdexcept>

extern "C" void normal_vec(int seed, int n, double x[]);

void test_exception() {
  try {
    throw std::out_of_range("WJS: testing");
  } catch (std::out_of_range &e) {
    std::cout << "WJS: caught error!\n";
  }
}

void normal_vec(int seed, int n, double x[]) {
  // start random number engine with fixed seed
  for (int i = 0; i<n; ++i) {
    x[i] = seed + i;
  }
  test_exception();
}

