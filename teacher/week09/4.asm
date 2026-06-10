;函数的定义和调用，用堆栈传递参数
code segment
assume cs:code
f:           ; 用标号定义函数名
   push bp   ; (4)
   mov bp, sp
   mov ax, ss:[bp+4]; 参数1
   sub ax, ss:[bp+6]; 参数2
   pop bp    ; (5)
   ret       ; (6)
main:
   mov ax, 3 ; 参数2
   push ax   ; (1)
   mov ax, 5 ; 参数1
   push ax   ; (2)
   call f    ; (3)
back:   
   add sp, 4 ; (7)清理堆栈中的2个参数                
   mov ah, 4Ch
   mov al, 0
   int 21h
code ends

stk segment stack
db 100h dup('S')
stk ends

end main
