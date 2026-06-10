; 把eax中的非符号数转化成十进制格式输出
.386
code segment use16
assume cs:code
main:
   mov eax, 2147483647
   mov ebx, 10 ; 除数
   mov ecx, 0  ; 统计除法的次数即十进制位数
div_again:   
   mov edx, 0
   div ebx ; edx、eax / ebx = eax..edx
   add edx, '0'
   push edx ; 把edx压入堆栈
   add ecx, 1
   cmp eax, 0
   jnz div_again
pop_again:
   pop edx
   mov ah, 2
   int 21h
   sub ecx, 1
   jnz pop_again
   mov ah, 4Ch
   mov al, 0
   int 21h
code ends
end main
   