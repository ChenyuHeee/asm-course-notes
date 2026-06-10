code segment
assume cs:code
main:
   mov ax, 2
   mov bx, -3
   cmp ax, 0
   jg ax_is_positive
   jmp set_cx_0
ax_is_positive:
   cmp bx, 0
   jg bx_is_positive
set_cx_0:   
   mov cx, 0
   jmp done
bx_is_positive:
   mov cx, 1
done:   
code ends
end main