;两个数据段
data1 segment
abc dw 1234h, 5678h
data1 ends

data2 segment
xyz dw 89ABh, 0CDEFh
data2 ends

code segment
assume cs:code, ds:data1, es:data2
main:
   mov ax, data1
   mov ds, ax
   mov ax, data2
   mov es, ax
   mov ax, abc[0] ; 编译步骤如下:
                  ; ①mov ax, data1:[0]
                  ; ②mov ax, ds:[0]
   mov xyz[0], ax ; 编译步骤如下:
                  ; ①mov data2:[0], ax
                  ; ②mov es:[0], ax
   ;不能把上面2行合并成以下一句: mov xyz[0], abc[0]
   ;因为有2个操作数的汇编指令中，这2个操作数不能全为内存变量
   push abc[2]    ; 编译步骤如下:
                  ; ①push word ptr data1:[2]
                  ; ②push word ptr ds:[2]
   pop xyz[2]     ; 编译步骤如下:
                  ; ①pop word ptr data2:[2]
                  ; ②pop word ptr es:[2]
                  ; push和pop的配合实现了xyz[2] = abc[2]
   mov ah, 4Ch
   mov al, 0
   int 21h
code ends

stk segment stack
db 100h dup('S')
stk ends

end main
