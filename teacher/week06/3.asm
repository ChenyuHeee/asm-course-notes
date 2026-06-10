;把8000h:0000h起，长度为20000h的内存块全部填成0FFh
.386
code segment use16
assume cs:code
main:
   mov ax, 8000h
   mov ds, ax
   mov dx, 2 ; 控制外循环的次数
   mov bx, 0 ; ds:bx-->目标内存块
   mov ecx, 20000h ; ecx控制循环次数 
   mov al, 0FFh   
again:  
   mov ds:[bx], al ; 或写成 mov byte ptr ds:[bx], al
                   ; 或写成 mov byte ptr ds:[bx], 0FFh
                   ; 上面这行指令中的byte ptr不可省略,
                   ; 因为汇编语言中的常数并没有明确的宽度               
   cmp bx, 0FFFFh
   jne next
   mov dx, ds
   add dx, 1000h
   mov ds, dx
next:   
   add bx, 1
   sub ecx, 1
   jnz again
 
   mov ah, 4Ch
   mov al, 0
   int 21h
code ends
end main
