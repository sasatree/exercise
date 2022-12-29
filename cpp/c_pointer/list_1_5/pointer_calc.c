#include <stdio.h>

int main(void)
{
  int hoge;
  int *hoge_p;

  hoge_p = &hoge;

  printf("hoge_p..%p\n", hoge_p ); // show pointer

  hoge_p++;

  printf("hoge_p..%p\n", hoge_p ); // show pointer

  printf("hoge_p..%p\n", hoge_p+3 ); // show pointer

  return 0;  
}
