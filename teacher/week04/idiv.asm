.386
code segment use16
assume cs:code
main:
   mov dx, -1
   mov ax, -5 ; dx¡¢ax = 0FFFFFFFBh = -5
   mov bx, 2
   idiv bx ; dx¡¢ax / bx
           ; ax=0FFFEh=-2, dx=0FFFFh=-1
code ends
end main
