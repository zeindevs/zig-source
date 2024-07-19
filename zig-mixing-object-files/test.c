#include "base64.h"

#include <string.h>
#include <stdio.h>

int main() {
  const char *encoded = "YWxsIHlvdXIgYmFzZSBhcmUgYmVsb25nIHRvIHVz";
  char buf[200];

  size_t len = decode_base_64(buf, 200, encoded, strlen(encoded));
  buf[len] = 0;
  puts(buf);

  return 0;
}
