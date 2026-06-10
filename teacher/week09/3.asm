;函数的定义和调用, 用寄存器传递参数
code segment
assume cs:code
f:           ; 用标号来定义函数名
   shl ax, 1 ; 函数值用ax表示
   ret       ; cpu在执行ret指令时会做以下动作:
             ; pop ip
main:
   mov ax, 3 ; 用寄存器ax作参数
   call f    ; 调用函数f
             ; cpu在执行call f指令时会做以两个操作
             ; ① push offset back; 压入下条指令的偏移地址
             ; ② jmp f ; 跳转到目标地址
back:   
   mov ah, 4Ch
   mov al, 0
   int 21h
code ends

stk segment stack
db 100h dup('S')
stk ends

end main
