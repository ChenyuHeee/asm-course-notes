comment @
汇编语言中的除法一共有3种用法:
(1) 16位/8位: ax/任意的8位寄存器或变量=al..ah
mov ax, 123h
mov bl, 10h
div bl ; ax / bl = al..ah, al=12h, ah=03h
(2) 32位/16位: (dx、ax)/任意的16位寄存器或变量=ax..dx
mov dx, 12h
mov ax, 3456h
mov bx, 1000h
div bx ; (dx、ax)/bx = 123456h/1000h = ax..dx, 
       ; ax=0123h, dx=0456h
(3) 64位/32位: (edx、eax)/任意的32位寄存器或变量=eax..edx
mov edx, 0
mov eax, 123456h
mov ebx, 1000h
div ebx ;  (edx、eax)/ebx=0000000000123456h/1000h
        ; eax=123h, edx=456h
;ebx:extended bx, 是一个32位的寄存器
@
; 计算123是几位数
code segment
assume cs:code
main:
   mov ax, 123
   mov bl, 10
   mov cx, 0
again:   
   div bl ; ax / bl = 123 / 10, al=12, ah=3
   add cx, 1
   cmp al, 0
   je done
   mov ah, 0
   jmp again
done:   
code ends
end main
