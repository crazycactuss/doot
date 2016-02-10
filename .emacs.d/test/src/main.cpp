#include <myadd.h>
#include <iostream>
#include "helper.h"

int main() {
  MyAdd add_obj;
  Helper habbadababa;
  add_obj.add(2,3);

  std::cout << "result:" << add_obj.add(1, 1) << std::endl;
}
