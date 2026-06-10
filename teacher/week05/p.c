
#include <stdio.h>
main()
{
   char a[]="ABCD", *p;
   p = a;
   putchar(p[0]);
   putchar(0[p]);  // 0[p] ==> *(0+p) 
   putchar(*p);
}
