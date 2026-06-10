1. 算术运算
   add  sub  imul/mul  idiv/div
   
   mov ax, 2
   mov bx, 3
   imul ax, bx ; ax = ax * bx = 2*3 = 0006h
               ; OF=0, CF=0
   
   mov ax, 1234h
   mov bx, 100h
   imul ax, bx ; ax=123400h 无法保存
               ; ax=3400h, OF=1, CF=1
   
   mov ax, 2
   mov bx, 3
   mul bx ; ax * bx = dx、ax
          ; dx=0000h, ax=0006h
          
   
   mov dx, -1
   mov ax, -5 ; dx、ax = 0FFFFFFFBh = -5
   mov bx, 2
   idiv bx ; dx、ax / bx
   
2. 关系运算
   先用cmp比较，再跟随j开头的条件跳转指令实现分支
(1) 跟符号数比较相关的跳转指令
   jg   jl  jge   jle   je   jne
   
(2) 跟非符号数比较相关的跳转指令   
   ja   jb  jae   jbe   je   jne

   mov ax, 0FFFFh ; -1
   mov bx, 1
   cmp ax, bx
   jl ax_is_less_than_bx ; 会发生跳转

   mov ax, 0FFFFh ; 65535
   mov bx, 1
   cmp ax, bx
   jb ax_is_below_bx ; 不会发生跳转


   mov cx, 0
   sub cx, 1; cx=0FFFFh=65535
   cmp cx, 0
   jb done  ; 不会跳转, 因为65535 > 0

3. 二进制运算
   C语言的二进制运算符: &   |   ^    ~   <<    >>
                        与  或 异或  非  左移  右移
   循环左移库函数 _rotl()
   循环右移库函数 _rotr()

   汇编语言的二进制运算指令:
                        and or  xor  not  shl/sal shr/sar
   循环左移指令rol, 循环左移指令ror
   带进位的循环左移指令rcl, 带进位的循环右移指令rcr

   mov ah, 10110110B; 或写成 mov ah, 0B6h
                    ; B是二进制常数的后缀
   mov bh, 01011010B
   and ah, bh       ; ah = ah & bh = 00010010B = 12h
   
   10110110
   01011010 and)
   -------------
   00010010

   mov ah, 10110110B; 或写成 mov ah, 0B6h
                    ; B是二进制常数的后缀
   mov bh, 01011010B
   or ah, bh        ; ah = ah | bh = 11111110B = 0FEh
   
   10110110
   01011010 or)
   -------------
   11111110
    
    
   mov ah, 10110110B; 或写成 mov ah, 0B6h
                    ; B是二进制常数的后缀
   mov bh, 01011010B
   xor ah, bh       ; ah = ah ^ bh = 11101100B = 0ECh
   
   10110110
   01011010 xor)
   -------------
   11101100    
   

   mov ah, 10110110B; 或写成 mov ah, 0B6h
                    ; B是二进制常数的后缀
   not ah           ; ah = 01001001B = 49h

   10110110 not)
   -------------
   01001001
   
   mov ah, 3
   shl ah, 1 ; 左移1位, shl: shift left 逻辑左移
   
   0000 0011 ; 移位前
   0000 0110 ; 移位后, 移出去的原最高位自动进入CF
             ; 本例中, CF=0
             ; 左移1位相当于乘以2

   mov ah, 3
   shr ah, 1 ; 右移1位, shl: shift right 逻辑右移
             ; 右移1位相当于除以2
   
   
   0000 0011 ; 移位前
   0000 0001 ; 移位后, 移出去的原最低位自动进入CF
             ; 本例中, CF=1

   
   ?011 011? ==> 0011 0110 ; 最高位及最低位清零，其余位不变
 设此数在ah中
 and ah, 01111110B ; 01111110B 是mask(掩码), 起过滤作用
 
 ?011 011?
 0111 1110  and)
 ---------------
 0011 0110
 
 
    ?011 011? ==> 1011 0111 ; 最高位及最低位置1，其余位不变
 设此数在ah中
 or ah, 10000001B ; 10000001B 是mask(掩码), 起过滤作用
 
 ?011 011?
 1000 0001  or)
 ---------------
 1011 0111
 
    1011 0110 ==> 0011 0111 ; 最高位及最低位反转，其余位不变
 设此数在ah中
 xor ah, 10000001B ; 10000001B 是mask(掩码), 起过滤作用
 
 1011 0110
 1000 0001  xor)
 ---------------
 0011 0111 
 
 
 异或的可逆性
 设z = x ^ y，则一定有:
 x = z ^ y 且
 y = z ^ x
 举例: 
 x=1011 0110B
 y=1100 0011B xor)
 z=0111 0101B
 
 
 循环左移
 mov al, 10110110B
 rol al, 1; 把AL循环左移1位, rol:rotate left
          ; al=01101101B, CF=1

 mov eax, 12345678h
 rol eax, 4
 0001 0010 0011 0100  0101 0110 0111 1000; 移位前
 0010 0011 0100  0101 0110 0111 1000 0001; 移位后
 