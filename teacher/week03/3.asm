; 计算12345是几位数
.386
code segment use16
assume cs:code
main:
   mov eax, 12345
   mov ebx, 10
   mov cx, 0
again:   
   mov edx, 0
   div ebx ; (edx、eax) / ebx = 12345 / 10, eax=1234, edx=5
   add cx, 1
   cmp eax, 0
   jne again
   ;je done
   ;jmp again
done:   
code ends
end main