.386
data segment use16
xyz db 1,2,3,4
abc db "ABCD"
w   dw 1234h, 5678h, 9ABCh ; dw: define word相当于short int
d   dd 12345678h, 89ABCDEFh; dd: define double word
                           ; 相当于long int
;上述4个数组在内存中的布局如下:
;+0 01h, 02h, 03h, 04h
;+4 41h, 42h, 43h, 44h
;+8 34h, 12h, 78h, 56h, 0BCh, 9Ah
;+E 78h, 56h, 34h, 12h, 0EFh, 0CDh, 0ABh, 89h
data ends

code segment use16
assume cs:code, ds:data
main:
   mov ax, data
   mov ds, ax
   mov eax, d[4]; eax = 89ABCDEFh
                ; 等价于mov eax, ds:[d+4]
                ; 编译后变成mov eax, ds:[12h]
   mov ax, w[1] ; ax = 7812h
   ;short int a[3]={0x1234, 0x5678, 0x9ABC}, ax;
   ;ax = *(short int *)((char *)a+1);   
   mov ax, w[2] ; ax = 5678h
                ; 等价于mov ax, ds:[w+2]
                ; 编译后变成mov ax, ds:[10]
                
   mov dx, word ptr abc[0]; dx=4241h
   mov cx, word ptr xyz[2]; cx=0403h
   
   mov al, abc[0]; 等价于mov al, ds:abc[0]
                 ; 也可写成 mov al, ds:[abc]
                 ; 编译过程如下:
                 ; ①mov al, data:[4]
                 ; ②mov al, ds:[4]
                 ; []内仅有常数的地址表达方式称为直接寻址
   mov bx, offset abc
   mov cx, 4
again:
   mov dl, ds:[bx]; []内有寄存器的地址表达方式称为间接寻址
                  ; 等价于mov dl, [bx]
                  ; 当[]内没有bp时, 该变量默认的段地址是ds
                  ; 当[]内有bp时, 该变量默认的段地址是ss
   mov ah, 2
   int 21h
   add bx, 1
   sub cx, 1
   jnz again      
;---间接寻址的四种形式---
;①[bx], [bp], [si], [di]; 仅有这4个寄存器有资格置于[]内
;②[bx+常数], [bp+常数], [si+常数], [di+常数]; 常数可以是负数
;③[bx+si], [bx+di], [bp+si], [bp+di]
;④[bx+si+常数], [bx+di+常数], [bp+si+常数], [bp+di+常数]
comment #
struct st
{
   char name[10];
   short int score;
};
struct st a[10]={...};
ax = a[1].score;
设ds=seg a, bx=offset a, si=12
mov ax, ds:[bx+si+10]
#
   mov bx, offset abc
   mov si, 0
   mov cx, 4
next:
   mov dl, ds:[bx+si] ; 等价于mov dl, [bx+si]                
   mov ah, 2
   int 21h
   add si, 1
   sub cx, 1
   jnz next               
   mov ah, 4Ch
   mov al, 0
   int 21h   
code ends
end main
