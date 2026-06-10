;从(0,0)起画一个40*40的红色方块
code segment
assume cs:code
main:
   mov ah, 0
   mov al, 13h
   int 10h; 把显卡切换到320*200分辨率的图形模式下
   mov ax, 0A000h
   mov ds, ax
   mov dx, 40; 行数
   mov bx, 0
   mov al, 4 ; 红色
next_row:   
   push bx
   mov cx, 40; 每行40个点
next_dot:   
   mov ds:[bx], al
   add bx, 1
   sub cx, 1
   jnz next_dot
   pop bx
   add bx, 320
   sub dx, 1
   jnz next_row
   mov ah, 0
   mov al, 3
   int 10h; 把显卡切换回80*25文本模式
   mov ah, 4Ch
   mov al, 0
   int 21h
code ends
end main

   
   