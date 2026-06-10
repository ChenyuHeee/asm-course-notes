//把32位非符号整数转化成二进制输出
#include <stdio.h>
main()
{
   int a = 0x87654321, mask = 0x80000000;
   int i;
   for(i=0; i<32; i++)
   {
      /*
      if((a & mask) != 0) // if(a & mask)
         putchar('1');
      else
         putchar('0');
       */
      // putchar(((a & mask) != 0) + '0');
      // putchar(!!(a & mask) + '0');
      putchar((a<0) + '0');
      a = a << 1; // a <<= 1;
   }
}