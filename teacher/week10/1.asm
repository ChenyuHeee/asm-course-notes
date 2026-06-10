1. C语言方式的参数传递的特点
(1) 参数按从右到左的顺序压入堆栈
(2) 参数的清理由调用者负责

2. Pascal语言方式的参数传递的特点
(1) 参数按从左到右的顺序压入堆栈
(2) 参数的清理由被调用者负责
code segment
assume cs:code
f:
   push bp ;(4)
   mov bp, sp ;(*) 这两条语句用来构造堆栈框架(stack frame)
   mov ax, [bp+6]; 参数1
   sub ax, [bp+4]; ax = ax - 参数2
   pop bp ;(5)
   ret 4 ; (6)CPU在执行本指令时会做以下操作:
         ; ① pop ip
         ; ② sp = sp + 4
main:
  mov ax, 5
  push ax ;(1) 参数1
  mov ax, 3
  push ax ;(2) 参数2
  call f  ;(3)
back:
  mov ah, 4Ch
  mov al, 0
  int 21h
code ends
end main
以上程序在运行过程中，堆栈变化如下:
设ss=2000h, sp=1000h
ss:0FF8 old bp   (4) (*)bp
ss:0FFA back (3) (5) 
ss:0FFC 3  (2) 
ss:0FFE 5  (1) 
ss:1000    (6) <-sp

3. stdcall方式的参数传递的特点
(1) 参数按从右到左的顺序压入堆栈
(2) 参数的清理由被调用者负责

4. C语言的参数传递为什么要按从右到左顺序来?
  目的是使得参数个数不确定的函数如printf()能方便获得参数1
  int printf(char *format, ...);
  在32位编译器中, 返回地址是4字节的指针,
  参数1是宽度为4字节的指针, 参数2是double
  类型其宽度为8字节，参数3是int类型其宽度是4字节
          bp+8   bp+12  bp+12+8
  printf("%f %d", 3.14, 1234);
         参数1    参数2 参数3
         4字节    8字节 4字节
                        参数3的地址=
                        参数1的地址+参数1的长度+参数2的长度
  
  设p是一个指针，则p+i的值的计算公式为:
     (unsigned int)p + i*sizeof(*p)
  例如p的定义为short int *p = (short int *)1000;
  那么p+3的值=1000+3*2=1006
  
  #include <stdio.h>
  double f(char *s, ...)
  {
     double y=0;
     char *p;
     p = (char *)&s + sizeof(s); /* p=参数2的地址 */
     while(*s)
     {
        if(*s == 'f')
        {
           y += *(double *)p;
           p += sizeof(double);
        }
        else if(*s == 'd')
        {
           y += *(int *)p;
           p += sizeof(int);
        }
        s++;
     }
     return y;
  }
  
  int main()
  {
     double y;
     y = f("fd", 3.14, 1234);
     printf("%f\n", y);
  }
  
  .386
  data segment use16
  s db "dl",0 ; d:short int, l:long int
  result dd 0
  data ends
  
  code segment use16
  assume cs:code, ds:data
  f:
     push bp
     mov bp, sp
     mov edx, 0     ; y=0
     lea si, [bp+6] ; si = bp + 6 -> 参数2
     ;mov si, bp
     ;add si, 6
     mov bx, [bp+4] ; bx=参数1=offset s
again: 
     cmp byte ptr ds:[bx], 0
     je done
     cmp byte ptr ds:[bx], 'l'
     je is_long
     cmp byte ptr ds:[bx], 'd'
     je is_int
     jmp next
is_long:     
     add edx, dword ptr ss:[si]
     add si, 4
     jmp next
is_int:
     movzx eax, word ptr ss:[si]
     add edx, eax
     add si, 2
next:
     add bx, 1
     jmp again
done:
     mov eax, edx ; eax是返回值
     pop bp
     ret
     
  main:
     mov ax, data
     mov ds, ax
     ;
     mov eax, 12345678h
     push eax ; 参数3
     mov ax, 8765h
     push ax  ; 参数2
     mov ax, offset s
     push ax  ; 参数1
     call f
back:
     add sp, 8
     mov [result], eax
     mov ah, 4Ch
     mov al, 0
     int 21h
  code ends
  end main
  
5. 递归
int f(int n)
{
   if(n == 1)
      return 1;
   else
      return n+f(n-1);
}
main()
{
   int y;
   y = f(3);
}

code segment
assume cs:code
f:
   push bp;(3)(6)(9)
   mov bp, sp
   mov ax, [bp+4]
   cmp ax, 1
   je done
   sub ax, 1
   push ax;(4)(7)
   call f;(5)(8)
here:
   add sp, 2;(12)(15)
   add ax, [bp+4]
done:
   pop bp;(10)(13)(16)
   ret;(11)(14)(17)
main:
   mov ax, 3
   push ax;(1)
   call f;(2)
back:   
   add sp, 2;(18)
   mov ah, 4Ch
   mov al, 0
   int 21h
code ends
end main
以上程序在运行过程中，堆栈变化如下:
设ss=2000h, sp=1000h
ss:0FEE 0FF4 <-bp=0FEE (9) 
ss:0FF0 here <-(8)(10)
ss:0FF2 1      (7)(11)
ss:0FF4 0FFA <-bp=0FF4 (6)(12)
ss:0FF6 here (5)(13)
ss:0FF8 2    (4)(14)
ss:0FFA old bp <- bp=0FFA (3)(15)
ss:0FFC back (2)(16)
ss:0FFE 3    (1)(17)
ss:1000         (18)
