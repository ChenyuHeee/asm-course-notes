.386
code segment use16
assume cs:code
old_8h dw 0, 0
int_8h:
   push ax
   push bx
   push ds
   mov ah, 62h
   int 21h ; BX=psp段址
   mov ds, bx
   cmp byte ptr ds:[985h], 48h
   jne skip
game_is_running:
   mov byte ptr ds:[1809h], 0Bh
skip:
   pop ds
   pop bx
   pop ax
   jmp dword ptr cs:[old_8h]   
main:
   xor ax, ax ; ax=0
   mov es, ax
   mov bx, 8*4
   mov ax, es:[bx]  ; ax=int 8h中断向量的偏移地址
   mov dx, es:[bx+2]; dx=int 8h中断向量的段地址
   mov cs:old_8h[0], ax
   mov cs:old_8h[2], dx
   cli ; 禁止硬件中断(clear interrupt), 使FL中的标志位IF=0
   mov word ptr es:[bx], offset int_8h
   mov word ptr es:[bx+2], seg int_8h ; seg int_8h可换成cs
   sti ; 允许硬件中断(set interrupt),  使FL中的标志位IF=1
   mov dx, offset main ; dx=code段起点到main的距离
   add dx, 100h ; dx += psp的长度
   add dx, 0Fh  ;\
   shr dx, 4    ;/ dx = (dx+0Fh)/10h
   mov ah, 31h
   int 21h      ; 保留dx节内存并结束程序运行
code ends
end main
