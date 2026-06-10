#include <stdio.h>
main()
{
   int i=0, sum=0;
again:
   i = i + 1;
   sum = sum + i;
   if(i<3)
      goto again;
   printf("sum=%d", sum);   
}