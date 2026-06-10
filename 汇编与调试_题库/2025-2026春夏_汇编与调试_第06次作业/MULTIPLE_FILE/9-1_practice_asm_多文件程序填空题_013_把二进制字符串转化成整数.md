## 9-1 practice_asm_多文件程序填空题_013_把二进制字符串转化成整数

- **类型**: MULTIPLE_FILE
- **分值**: 10 分
- **作者**: blackwhite

---

$\huge{\color{#00C000}1.}$ $\large\texttt{本题题型: 函数题}$
$\huge{\color{#00C000}2.}$ $\large\texttt{代码描述}$
从键盘输入一个长度不超过16个字符的二进制字符串，保存到数组$\color{#C00000}buf$中，再把该字符串转化成16位整数并保存到变量$\color{008080}abc$中。注意字符串$buf$一定以$00h$字符结束。
例如：输入$\underline{\color{#C00000}\large\mathtt{10001000}}$ ，则$abc$的值=$\underline{\color{#800080}\large\mathtt{136}}$。

$\huge{\color{#00C000}5.}$ $\large\texttt{注意事项}$
请在$\color{#C000C0}\underline{;\#1\_begin}$与$\color{#C000C0}\underline{;\#1\_end}$之间补充代码，不可删除$\color{#C000C0}\underline{;\#1\_begin}$、$\color{#C000C0}\underline{;\#1\_end}$标记

$\huge{\color{#00C000}6.}$ ${\large\texttt{提交步骤}}$
$\large\char"2460$ 复制以下源程序内容
```x86asm
.386
data segment use16
buf db 17 dup(0) ; buf用来存放输入的二进制字符串
abc dw 0         ; abc用来存放由buf中的二进制字符串转化得来的整数值
data ends

code segment use16
assume cs:code, ds:data
main:
   mov ax, data
   mov ds, ax
   mov cx, 16     ; 最多输入16个二进制字符
   mov si, 0      ; si是buf的下标
input_next:   
   mov ah, 1
   int 21h        ; AL=getchar()
   cmp al, 0Dh    ; 若AL==回车符
   je input_done  ;    =>input_done
   mov buf[si], al; buf[si] = AL
   add si, 1      ; si++
   sub cx, 1
   jnz input_next
input_done: 
   mov buf[si], 0 ; buf[si] = '\0'
   mov ah, 2
   mov dl, 0Dh
   int 21h        ; 输出回车符
   mov ah, 2
   mov dl, 0Ah
   int 21h        ; 输出换行符
   ;   
;#1_begin-------------------------------------
                                             ;<--第1空, 请把解答写在分号左边, 可填多条指令

;#1_end=======================================
exit:
   mov ah, 4Ch
   int 21h
code ends
end main
```
$\large\char"2461$ 在桌面空白处，点右键$\rightarrow$新建$\rightarrow$文本文档，并把此文件重命名设为$\underline{\color{008080}s.asm}$
$\large\char"2462$ 用$\color{C00000}editplus$打开$s.asm$
$\large\char"2463$ 把步骤$\large\char"2460$复制的内容粘贴到$editplus$内
$\large\char"2464$ 在$editplus$中对代码进行完善，注意完善代码时切勿删除$\color{#C000C0}\underline{;\#1\_begin}$、$\color{#C000C0}\underline{;\#1\_end}$标记
$\large\char"2465$ 保存$s.asm$并在$XP$或$Bochs$虚拟机中编译、调试$s.asm$
$\large\char"2466$ 复制$s.asm$的内容到提交框内，点“$\underline{\color{C00000}\tt{提交本题作答}}$”按钮
