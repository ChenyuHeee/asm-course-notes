code segment
assume cs:code
old_80h dw 0, 0
int_80h:
   shl ax, 1
   iret ; iret是中断返回指令
main:
   xor ax, ax ; ax=0
   mov es, ax
   mov bx, 80h*4
   mov ax, es:[bx]  ; ax=int 80h中断向量的偏移地址
   mov dx, es:[bx+2]; dx=int 80h中断向量的段地址
   mov cs:old_80h[0], ax
   mov cs:old_80h[2], dx
   mov word ptr es:[bx], offset int_80h
   mov word ptr es:[bx+2], seg int_80h ; seg int_80h可换成cs
   mov ax, 1234h
   int 80h
   mov ah, 4Ch
   mov al, 0
   int 21h
code ends
end main
