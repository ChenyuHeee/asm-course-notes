;把32位整数转化成二进制格式输出
.386
code segment use16
assume cs:code
main:
   mov eax, 12345678h
   mov cx, 32
again:   
   rol eax, 1 ; eax = 23456781h
   ;push eax   ; 把eax的值压入堆栈
   mov ebx, eax ; ebx = eax, 备份eax的值到ebx中
   and eax, 1
   add eax, '0'
output:
   mov ah, 2
   mov dl, al ; 不能写成mov dl, eax; 因为操作数必须等宽
   int 21h
   mov eax, ebx ; 恢复eax的值
   ;pop eax      ; 从堆栈中弹出eax即恢复eax
   sub cx, 1
   jnz again
   mov ah, 4Ch
   mov al, 0
   int 21h
code ends
end main
