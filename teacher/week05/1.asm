;把32位非符号整数转化成二进制输出
.386
code segment use16
assume cs:code
main:
   mov eax, 12345678h
   mov cx, 32
again:   
   shl eax, 1
   mov ebx, eax ; mov指令不影响FL中的标志位
   jc is_1 ; jc表示当CF==1时则跳，而jnc则表示CF==0时则跳
is_0:   
   mov dl, '0'
   jmp output
is_1:
   mov dl, '1'
output:
   mov ah, 2
   int 21h
   mov eax, ebx
   sub cx, 1
   jnz again
   mov ah, 4Ch
   mov al, 0
   int 21h
code ends
end main

