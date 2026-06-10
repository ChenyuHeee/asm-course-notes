code segment
assume cs:code
main:
   mov ax, 2
   mov bx, -3
   cmp ax, 0
   jg set_cx_1
   cmp bx, 0
   jg set_cx_1
   mov cx, -1
   jmp done
set_cx_1:
   mov cx, 1   
done:   
code ends
end main