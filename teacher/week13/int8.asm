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
