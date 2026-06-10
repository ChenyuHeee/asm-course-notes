1. 中断程序设计
(1) 自定义中断函数int_80h
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

(2) 时钟中断程序int8.asm
code segment
assume cs:code
ticks dw 0
old_8h dw 0, 0
int_8h:
   cmp [ticks], 0
   je skip
   dec [ticks]   
skip:
   push ax ; 硬件中断函数不可以破坏任何寄存器的值
   mov al, 20h ; 把20h这个信号发送给20h端口, 表示要告诉
               ; 中断控制器当前的中断已处理完毕
   out 20h, al ; 把al中的值发送给20h号端口
               ; cpu <-> 端口 <--> 外设
   pop ax  ; 恢复ax的值
   iret
delay_1s:
   mov [ticks], 18
wait_a_while:  
   ;int 8
   cmp [ticks], 0
   ;int 8
   jne wait_a_while
   ret
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
   mov cx, 10
   mov dl, 'A'
again:
   mov ah, 2
   int 21h
   call delay_1s
   inc dl
   dec cx
   jnz again
   mov ax, old_8h[0]
   mov dx, old_8h[2]
   cli
   mov es:[bx], ax   ; 恢复int 8h的中断向量
   mov es:[bx+2], dx
   sti
   mov ah, 4Ch
   mov al, 0
   int 21h
code ends
end main

(3) 时钟中断程序int8.asm(改成中断衔接)
code segment
assume cs:code
ticks dw 0
old_8h dw 0, 0
int_8h:
   cmp [ticks], 0
   je skip
   dec [ticks]   
skip:
   jmp dword ptr cs:[old_8h] ; 中断衔接
delay_1s:
   mov [ticks], 18
wait_a_while:  
   ;int 8
   cmp [ticks], 0
   ;int 8
   jne wait_a_while
   ret
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
   mov cx, 10
   mov dl, 'A'
again:
   mov ah, 2
   int 21h
   call delay_1s
   inc dl
   dec cx
   jnz again
   mov ax, old_8h[0]
   mov dx, old_8h[2]
   cli
   mov es:[bx], ax   ; 恢复int 8h的中断向量
   mov es:[bx+2], dx
   sti
   mov ah, 4Ch
   mov al, 0
   int 21h
code ends
end main

(4) 修改pc-man让生命值始终保存0Bh
psp:1809h -> life
psp:985h -> 48h

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
