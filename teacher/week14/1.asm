1. 中断程序设计
(1) 时钟中断int 8
(2) 键盘中断int 9
data segment
old_9h dw 0, 0
stop   db 0
key    db 0
phead  dw 0
key_extend  db 'KeyExtend=', 0
key_up      db 'KeyUp=', 0
key_down    db 'KeyDown=', 0
key_code    db '00h ', 0
hex_tbl     db '0123456789ABCDEF'
cr          db 0Dh, 0Ah, 0
data ends

code segment
assume cs:code, ds:data
int_9h:
   push ax
   push bx
   push cx
   push ds
   mov ax, data
   mov ds, ax       ; 这里设置DS是因为被中断的不一定是当前进程
   in al, 60h       ; AL=键码, 60h是键盘相关的端口
   mov [key], al
   cmp al, 0E0h     ; 0E0h是前缀键码
   je  extend
   cmp al, 0E1h     ; 0E1h是前缀键码
   jne up_or_down
extend:
   mov [phead], offset key_extend
   call output
   jmp check_esc
up_or_down:
   test al, 80h     ; 最高位=1时是键盘被释放时的键码
   jz down
up:
   mov [phead], offset key_up
   call output
   mov bx, offset cr
   call display_str ; 输出回车换行
   jmp check_esc
down:               ; 最高位=0时是键盘被压下时的键码
   mov [phead], offset key_down
   call output
check_esc:   
   cmp [key], 81h   ; Esc键被释放时的键码
   jne int_9h_iret
   mov [stop], 1    ; Esc键松开时stop置1
int_9h_iret:
   mov al, 20h      ; 发EOI(End Of Interrupt)信号
   out 20h, al      ; 给中断控制器，表示本次中断已处理完毕
   pop ds
   pop cx
   pop bx
   pop ax
   iret             ; 中断返回

output:
   push ax
   push bx
   push cx
   mov bx, offset hex_tbl
   mov cl, 4
   push ax          ; 设AL=31h=0011 0001B
   shr al, cl; AL=03h
   xlat             ; AL = DS:[BX+AL] = '3'
   mov key_code[0], al
   pop ax
   and al, 0Fh      ; AL=01h
   xlat             ; AL='1'
   mov key_code[1], al
   mov bx, [phead]
   call display_str ; 输出提示信息
   mov bx, offset key_code
   call display_str ; 输出键码
   pop cx
   pop bx
   pop ax
   ret   
display_str:
   push ax
   push bx
   push si
   mov si, bx
   mov bx, 0007h    ; BH=page number, 
                    ; BL=foreground color in graphics mode
display_next_char:
   mov ah, 0Eh      ; AH=0Eh
   lodsb
   or al, al
   jz display_str_done
   int 10h          ; 调用int 10h的0Eh号功能输出AL中的字符
   jmp display_next_char
display_str_done:
   pop si
   pop bx
   pop ax
   ret
main:
   mov ax, data
   mov ds, ax
   cld
   xor ax, ax
   mov es, ax
   mov bx, 9*4
   push word ptr es:[bx]     ;\
   pop old_9h[0]             ; \
   push word ptr es:[bx+2]   ; /保存int 9h的中断向量
   pop old_9h[2]             ;/ 
   cli
   mov word ptr es:[bx], offset int_9h
   mov es:[bx+2], cs; cs也可以改成code或seg int_9h
   sti
wait_again:
   ;int 9
   cmp [stop], 1
   ;int 9
   jne wait_again   ; 主程序在此循环等待
   push old_9h[0]   ;\
   pop es:[bx]      ; \
   push old_9h[2]   ; /恢复int 9h的中断向量
   pop es:[bx+2]    ;/
   mov ah, 4Ch
   int 21h
code ends
end main

(3) 单步中断int 1
标志寄存器FL包含的标志位有:CF、ZF、SF、OF、AF、PF、IF、DF、TF
其中TF就是陷阱标志(trap flag), 它是FL的第8位
当TF=1时, CPU会进入单步模式(single-step mode)

如何把TF置1?
pushf
pop ax ; ax = fl
or ax, 100000000B ; 或写成or ax, 100h
push ax
popf   ; TF=1

如何把TF清0?
pushf
pop ax ; ax = fl
and ax, 0FEFFh; 或写成and ax, not 100h
push ax
popf   ; TF=0  

CPU在单步模式下工作时，其执行指令的流程:
;设TF=1
mov ax, 0
;int 1
mov bx, 1
;int 1
again:
add ax, bx
;int 1
cmp ax, 100
;int 1
jb again
;int 1

单步中断演示代码1:
code segment
assume cs:code
old_1h dw 0, 0         ; 用来保存int 1h的中断向量
int_1h:                ; 中断函数
   nop                 ; cpu进入中断函数时会自动把IF及TF清零
   iret                ; 中断返回
main:
   xor ax, ax          ; AX=0, 等同于mov ax, 0
   mov es, ax          ; ES = 0
   mov bx, 4           ; int n的中断向量位于0:n*4处
   mov ax, es:[bx]     ; ax=word ptr 0:[4]
   mov dx, es:[bx+2]   ; dx=word ptr 0:[6]
   mov cs:old_1h[0], ax;\
   mov cs:old_1h[2], dx;/保存int 1h的中断向量
   mov word ptr es:[bx], offset int_1h
   mov es:[bx+2], cs   ; 修改int 1h的中断向量为code:int_1h
   ;
   pushf  ; 此时FL中TF=0
   ;
   pushf
   pop ax ; ax = fl
   or ax, 100h
   push ax
   popf   ; TF=1, 注意此popf后并没有int 1 
   ;进入单步模式
   nop
   ;int 1
   mov ax, 0
   ;int 1, 若当前指令执行前TF=1则该指令执行后会跟随int 1
   mov bx, 1
   ;int 1
   again:
   add ax, bx
   ;int 1
   cmp ax, 100
   ;int 1
   jb again
   ;int 1   
   popf ; TF=0
   ;int 1, 此处有最后一个int 1
   nop  ; 加密
   ;结束单步模式
   mov ax, cs:old_1h[0]
   mov dx, cs:old_1h[2]
   mov es:[bx], ax     ;\
   mov es:[bx+2], dx   ;/恢复int 1h的中断向量
   mov ah, 4Ch
   int 21h
code ends
end main


单步中断演示代码2:
code segment
assume cs:code
old_1h dw 0, 0         ; 用来保存int 1h的中断向量
prev   dw offset first, seg first
int_1h:                ; 中断函数
   push bp
   mov bp, sp
   push es
   push di
   push ds
   push si
   les di, dword ptr [bp+2]
   ;mov di, word ptr [bp+2]
   ;mov es, word ptr [bp+4]
   dec byte ptr es:[di]
   lds si, dword ptr [prev]
   inc byte ptr ds:[si]
   mov prev[0], di
   mov prev[2], es
   pop si
   pop ds
   pop di
   pop es
   pop bp
   iret                ; 中断返回
main:
   xor ax, ax          ; AX=0, 等同于mov ax, 0
   mov es, ax          ; ES = 0
   mov bx, 4           ; int n的中断向量位于0:n*4处
   mov ax, es:[bx]     ; ax=word ptr 0:[4]
   mov dx, es:[bx+2]   ; dx=word ptr 0:[6]
   mov cs:old_1h[0], ax;\
   mov cs:old_1h[2], dx;/保存int 1h的中断向量
   mov word ptr es:[bx], offset int_1h
   mov es:[bx+2], cs   ; 修改int 1h的中断向量为code:int_1h
   ;
   pushf  ; 此时FL中TF=0
   ;
   pushf
   pop ax ; ax = fl
   or ax, 100h
   push ax
   popf   ; TF=1, 注意此popf后并没有int 1 
   ;进入单步模式
first:   
   nop
   ;int 1
   ;--- 以下指令的首字节需要在编译后用QV修改, 改成原值+1 ---
   mov ax, 0
   ;int 1, 若当前指令执行前TF=1则该指令执行后会跟随int 1
   mov bx, 1
   ;int 1
   again:
   add ax, bx
   ;int 1
   cmp ax, 100
   ;int 1
   jb again
   ;int 1   
   popf ; TF=0
   ;int 1, 此处有最后一个int 1
   nop  ; 加密
   ;--- 以上指令的首字节需要在编译后用QV修改, 改成原值+1 ---
   ;结束单步模式
   mov ax, cs:old_1h[0]
   mov dx, cs:old_1h[2]
   mov es:[bx], ax     ;\
   mov es:[bx+2], dx   ;/恢复int 1h的中断向量
   mov ah, 4Ch
   int 21h
code ends
end main

2. 缓冲溢出
代码见overflow