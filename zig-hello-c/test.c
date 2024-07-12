#include "mathtest.h"
#include <stdint.h>
#include <stdio.h>

int main() {
  int32_t result = add(42, 1337);
  printf("%d\n", result);
  return 0;
}
