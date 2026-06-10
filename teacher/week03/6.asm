;用循环输出5*3个星号
code segment
assume cs:code
main:
   mov bx, 3; bx=行数
next_row:   
   mov cx, 5; cx=每个星号的个数
next_star:   
   mov ah, 2; ah=2用来指定子函数的编号
   mov dl, '*'
   int 21h ; 调用0x21号函数集
   sub cx, 1
   jnz next_star; jump if not zero
   ;cpu内部有一个FL寄存器，该寄存器的其中一位叫ZF
   ;当add、sub、cmp等指令使运算结果=0时，ZF会被置1，
   ;表示zero is true，反之ZF会被清零，表示zero is not true
   ;jnz是当ZF=0时才跳转
   ;je是当ZF=1时才跳转
   mov ah, 2
   mov dl, 0Dh; 或mov dl, 13; 其中0Dh是回车符，即'\r'
   int 21h
   mov ah, 2
   mov dl, 0Ah; 或mov dl, 10; 其中0Ah是换行符，即'\n'
   int 21h
   sub bx, 1
   jnz next_row
   mov ah, 4Ch
   mov al, 0
   int 21h ; 相当于C语言中的函数调用exit(0)
code ends
end main
