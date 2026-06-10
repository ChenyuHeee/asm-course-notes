;堆栈段的定义
data segment
abc dw 1234h, 5678h
xyz dw 89ABh, 0CDEFh
data ends

code segment
assume cs:code, ds:data
main: ; (1)程序刚开始运行时, dos会把ds、es赋值为首段的段地址-10h
      ; 首段的段地址-10h 其实是psp的段地址
      ; psp是指程序段前缀(program segment prefix),
      ; 它是由dos分配给当前程序的，长度为100h字节的，
      ; 位于首段前的一块内存，psp里面存放了跟当前
      ; 程序有关的一些信息，例如byte ptr psp:[80h]
      ; 中保存了命令行参数的长度, psp:81h起则保存了
      ; 命令行参数的内容
      ; (2)ss=堆栈段的段地址, sp=堆栈的长度
      ; (3)cs=代码段的段地址, ip=main的偏移地址
   mov ax, data
   mov ds, ax
   push abc[0] ; 编译步骤
               ; ①push word ptr data:[0]
               ; ②push word ptr ds:[0]          
   push abc[2] ; 编译步骤
               ; ①push word ptr data:[2]
               ; ②push word ptr ds:[2]   
   pop xyz[2]
   pop xyz[0]
   mov ah, 4Ch
   mov al, 0
   int 21h   
code ends

stk segment stack ; 堆栈段的定义中必须有stack这个关键词
db 100h dup('S')  ; 100h dup(0)相当于db 0,0,0...共100h个0
                  ; 该数组的长度决定了堆栈空间的长度
stk ends

end main

#comment 
若源程序中没有定义堆栈段，则dos会给该程序
分配一个堆栈段，其中ss=首段的段地址, sp=0
设data段的段地址=1000h, 段长度=10h, code段的长度=20h
则内存布局如下:
1000:0000 ~ 1000:000F 数据段
1000:0010 ~ 1000:002F 代码段
1000:0030 ~ 1000:FFFF 空闲 用作堆栈空间
2000:0000 ~ 9000:FFFF 也属于当前程序
#