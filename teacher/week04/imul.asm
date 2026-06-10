.386
code segment use16
assume cs:code
main:
   mov ax, 1234h
   mov bx, 100h
   imul ax, bx
   
   mov ax, 1234h
   mov bx, 100h
   imul bx

   mov ax, -2
   mov bx, 2
   imul bx
code ends
end main
