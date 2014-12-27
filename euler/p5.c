//What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

#include <stdio.h>

typedef enum { false, true } bool;

bool divis(int num, int by) {
  if (num % by == 0) {
    return true;
   } else {
    return false;
   }
}

int main() {
  int try = 20;
  int flag = 1;

  while(flag == 1) {
    try += 1;
    flag = 0;

    int i;
    for (i = 11; i <= 20; i++) {
      if (!divis(try, i)) {
        flag = 1;
        break;
      }
    }
  }

  printf("%d\n", try);

  return 0;
}
