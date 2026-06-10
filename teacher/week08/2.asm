;POST(Power On Self Test)代码位于ROM中，
;电脑启动时会执行POST代码，并对显卡内存
;和主存建立映射(mapping)：
;(1) 文本方式下，主存空间B800:0~B800:7FFF 和 显卡内存 建立映射
;(2) 图形方式下，主存空间A000:0~A000:FFFF 和 显卡内存 建立映射
data segment
x dw 40
y dw 12
data ends

code segment
assume cs:code, ds:data
main:
   mov ax, data
   mov ds, ax
   mov ax, [y]
   mov cx, 80
   mul cx ; dx、ax = y*80
   add ax, [x] ; ax = y*80+x
   shl ax, 1 ; ax = (y*80+x)*2
   mov bx, ax
   
   mov ax, 0B800h
   mov ds, ax
   mov byte ptr ds:[bx], 'A'
   mov byte ptr ds:[bx+1], 72h; 白底绿字
   mov byte ptr ds:[bx+2], 'B'
   mov byte ptr ds:[bx+3], 74h; 白底红字

   mov ah, 4Ch
   mov al, 0
   int 21h
code ends
end main
