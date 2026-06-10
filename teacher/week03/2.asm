; 计算12345是几位数
code segment
assume cs:code
main:
   mov ax, 12345
   mov bx, 10
   mov cx, 0
again:   
   mov dx, 0
   div bx ; (dx、ax) / bx = 12345 / 10, ax=1234, dx=5
   add cx, 1
   cmp ax, 0
   jne again
   ;je done
   ;jmp again
done:   
code ends
end main