comment #
用循环输出一个3层金字塔:
  *
 ***
*****
#

code segment
assume cs:code
main:
   mov bx, 1  ; 行号
next_row:   
   mov cx, bx
   add cx, cx
   sub cx, 1  ; cx=星号的个数
   mov bp, 3  ; 3是金字塔的层数
   sub bp, bx ; bp=空格的个数
output_1_space:
   cmp bp, 0
   je output_1_star
   mov ah, 2
   mov dl, ' '
   int 21h    ; 输出一个空格
   sub bp, 1
   jmp output_1_space
output_1_star:   
   mov ah, 2
   mov dl, '*'
   int 21h    ; 输出一个星号
   sub cx, 1
   jnz output_1_star; jnz:jump if not zero
   mov ah, 2
   mov dl, 0Dh
   int 21h; 输出一个回车符'\r'
   mov ah, 2
   mov dl, 0Ah
   int 21h; 输出一个换行符'\n'
   add bx, 1
   cmp bx, 3
   jle next_row
   mov ah, 4Ch
   mov al, 0
   int 21h; 相当于C语言函数调用exit(0), 终止程序的运行
code ends
end main

