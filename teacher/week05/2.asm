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
   mov dl, 0
   adc dl, '0' ; dl = dl + '0' + CF
               ; adc表示add with carry flag
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

