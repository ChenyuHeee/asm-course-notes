1. 远指针(far pointer)和近指针(near pointer)
远指针: 由段地址和偏移地址组合而成的完整地址就是远指针，例如:
 0B800h:0000h 
近指针: 仅包含偏移地址的地址称为近指针

2. 如何在汇编语言中定义一个远指针并引用远指针
A:B形式的远指针被保存到内存中时，一定是被当作一个
32位的整数AB来保存的
data segment
video_addr1 dd 0B8000000h    ; 00, 00, 00, 0B8h
video_addr2 dw 0000h, 0B800h ; 00, 00, 00, 0B8h
data ends

code segment
assume cs:code, ds:data
main:
   mov ax, data
   mov ds, ax
   mov di, video_addr2[0] ; di=0000h
   mov es, video_addr2[2] ; es=0B800h
   mov byte ptr es:[di], 'A'
   mov byte ptr es:[di+1], 71h ; 颜色=71h, 表示白底蓝字
   les di, [video_addr1]  ; di=0000h, es=0B800h
   mov byte ptr es:[di], 'A'
   mov byte ptr es:[di+1], 71h ; 颜色=71h, 表示白底蓝字
   mov ah, 4Ch
   mov al, 0
   int 21h
code ends
end main

 
3. 如何在C语言中定义一个远指针并引用远指针
在16位编译器如TC中, char *p;中的p是近指针，其宽度是2字节, 
它可以容纳一个16位的偏移地址; 
在32位编译器如VC中, char *p;中的p是近指针，其宽度是4字节, 
它可以容纳一个32位的偏移地址; 
在32位CPU中，段寄存器cs,ds,es,ss仍旧是16位, 故32位编译器中,
远指针的宽度是6字节=16位段地址+32位偏移地址, 对应的宽度修饰
符为fword ptr

/* 以下程序只能在16位编译器TC中编译 */
#include <stdio.h>
main()
{
   char far *p = (char far *)0xB8000000;
   *p = 'A';
   *(p+1) = 0x71;   
}

4. 如何在函数内部定义并引用局部动态变量
全局变量或局部静态变量都是定义在数据段中，
而局部动态变量则定义在堆栈中。

int f(int a, int b)
{
   int c;
   c = a - b;
   return c;
}
main()
{
   int y;
   y = f(5, 3);
}
code segment
assume cs:code
f:
   push bp;(4)
   mov bp, sp ;(*)
   sub sp, 2      ;(5) 给动态变量c留空间
   mov ax, [bp+4] ; ax = a
   sub ax, [bp+6] ; ax = a - b
   mov [bp-2], ax ; c=a-b
   mov ax, [bp-2] ; ax = c
   mov sp, bp ;(6)
   pop bp ;(7)
   ret;(8)
   
main:
   mov ax, 3
   push ax;(1)
   mov ax, 5
   push ax;(2)
   call f; (3) y = f(5, 3)
back:   
   add sp, 4;(9)
   mov ah, 4Ch
   mov al, 0
   int 21h
code ends
end main
上述程序运行时的堆栈布局如下:
设ss=2000h, sp=1000h
ss:0FE4      (5)sp
ss:0FF8 old bp (4)(6)bp (*)
ss:0FFA back (3)(7)
ss:0FFC 5    (2)(8)
ss:0FFE 3    (1)
ss:1000      (9)<-

5. 远调用和近调用
近调用: 调用者和被调用者在同一个代码段内
远调用: 调用者和被调用者不在同一个代码段内
code1 segment
assume cs:code1
f:
   push bp
   mov bp, sp
   mov ax, [bp+6]
   sub ax, [bp+8]
   pop bp
   retf ; 远返回指令, 当cpu执行此指令时，会做以下操作:
        ; ip = word ptr ss:[sp]
        ; cs = word ptr ss:[sp+2]
        ; sp = sp + 4
        ; 也可以概括为: ①pop ip ②pop cs
code1 ends

code2 segment
assume cs:code2
main:
   mov ax, 3
   push ax
   mov ax, 5
   push ax
   call far ptr f ; ax = f(5, 3)
                  ; cpu在执行远调用指令时会做以下操作:
                  ; ①push cs
                  ; ②push offset back
                  ; ③jmp far ptr f
back:
   add sp, 4
   mov ah, 4Ch
   mov al, 0
   int 21h
code2 ends
end main

6. 如何以源代码的方式来调试汇编程序
设要调试hello.asm，则编译步骤如下:
tasm /zi hello;
tlink /v hello;
td hello 或 ldr hello

7. 如何用soft-ice设置硬件断点
软件断点: 把指令首字节替换成0CCh即指令int 3的机器码
硬件断点: 把指令首字节的地址或者变量地址保存到CPU内的
          调试寄存器中，将来这些地址处的指令或变量被访
          问时，CPU会产生单步中断int 1以通知调试器暂停
          程序运行

演示代码int3.asm:
code segment
assume cs:code
main:
   mov cx, 10
next:
   mov ah, 2; 此处设一个软件断点
   mov dl, 'A'
   int 21h
   mov al, byte ptr cs:[next]
   ;byte ptr相当于char *
   cmp al, 0CCh
   ;cmp byte ptr cs:[next], 0CCh
   je done
   sub cx, 1
   jnz next
done:
   mov ah, 4Ch
   int 21h
code ends
end main

