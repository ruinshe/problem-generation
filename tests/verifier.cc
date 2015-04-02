#include "verifier.h"
#include <cstdio>

namespace verifier {

bool verify_input(FILE* input) {
  int a, b;
  ASSERT(fscanf(input, "%d%d", &a, &b) == 2);
  ASSERT(fscanf(input, "%*d") == EOF);
  ASSERT(a >= 1 && a <= 10);
  ASSERT(b >= 1 && b <= 10);
  return true;
}

bool verify_output(FILE* output) {
  return true;
}

}

