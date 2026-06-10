;把8000h:0000h起，长度为10000h的内存块全部填成0FFh
code segment
assume cs:code
main:
   mov ax, 8000h
   mov ds, ax
   mov bx, 0 ; ds:bx-->目标内存块
   mov cx, 0 ; cx控制循环次数
   mov al, 0FFh
again:
   mov ds:[bx], al ; 或写成 mov byte ptr ds:[bx], al
                   ; 或写成 mov byte ptr ds:[bx], 0FFh
                   ; 上面这行指令中的byte ptr不可省略,
                   ; 因为汇编语言中的常数并没有明确的宽度
                   
   add bx, 1
   sub cx, 1
   jnz again
   mov ah, 4Ch
   mov al, 0
   int 21h
code ends
end main
