;如何访问自定义变量和数组
data segment
xyz db 1,2,3
abc db "Hello", 0 ; db:define byte, 相当于C语言的char类型
;char abc[] = "Hello";
data ends

code segment
assume cs:code, ds:data
var db "asm"
main:
   mov ax, seg abc ; 在源代码中，用seg abc可以获得abc的段地址
                   ; 也可以用abc所在段的段名data来表示abc的
                   ; 段地址, 即本语句也可以写成:
                   ; mov ax, data
   mov ds, ax
   mov bx, offset abc ; offset abc表示abc的偏移地址
again:
   mov dl, ds:[bx] ; 或写成mov dl, byte ptr ds:[bx]
   cmp dl, 0
   je done
   mov ah, 2
   int 21h
   add bx, 1
   jmp again
done:               ; 
  ;mov dl, ds:[abc] ; [abc]中的abc就是offset abc 
                    ; mov dl, ds:[abc] 等价于 mov dl, ds:abc[0], 其中abc[0]等价于[abc+0]
                    ; mov dl, ds:[abc] 也等价于 mov dl, ds:abc
                    ; 这3种形式均会编译成: mov dl, ds:[3]
   mov dl, [abc]    ; 这第4种形式跟上述3种形式也是等价的
                    ; 编译后仍旧会变成: mov dl, ds:[3]
                    ; 编译过程如下:
                    ; ① mov dl, data:[3]
                    ; 汇编语言指令在引用变量时，该变量的段地址不能
                    ; 用常数表示，只能用某个段寄存器表示，故
                    ; 编译器需要根据assume语句提供的线索把
                    ; data:替换成ds:
                    ; ② mov dl, ds:[3]
                    ; assume ds:data的作用是告诉编译器把
                    ; data:替换成ds:
                    ; mov dl, [abc] 也可以写成 mov dl, abc
                    ; 后者在编译时会先转化成前者再编译         
   mov ah, 2
   int 21h
   mov dl, [var] ; 编译过程如下:
                 ; ① mov dl, code:[0]
                 ; ② mov dl, cs:[0]
   mov ah, 2
   int 21h
   mov ah, 4Ch
   mov al, 0
   int 21h
code ends

end main
