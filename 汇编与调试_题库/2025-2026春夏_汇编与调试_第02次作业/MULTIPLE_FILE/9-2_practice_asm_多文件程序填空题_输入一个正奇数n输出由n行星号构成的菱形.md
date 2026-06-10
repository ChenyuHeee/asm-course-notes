## 9-2 practice_asm_多文件程序填空题_输入一个正奇数n输出由n行星号构成的菱形

- **类型**: MULTIPLE_FILE
- **分值**: 15 分
- **作者**: blackwhite

---

$\huge{\color{#00C000}1.}$ $\large\texttt{本题题型: 程序填空(共3空)}$
$\huge{\color{#00C000}2.}$ $\large\texttt{代码描述}$
输入一个正奇数$\color{C00000}n$，输出由$\color{008080}n$行星号构成的菱形

$\huge{\color{#00C000}3.}$ $\large\texttt{举例}$
$\large\char"2460$ 输入
$\hspace{4em}\color{#C00000}\tt{5}\color{#0000C0}\char"21B2$
则应该输出
$$
\hspace{4em}\color{#C00000}{\large\texttt{\char"2423{}\char"2423{}\char"2A}}\color{#0000C0}\char"21B2\\
\hspace{4em}\color{#C00000}{\large\texttt{\char"2423{}\char"2A\char"2A\char"2A}}\color{#0000C0}\char"21B2\\
\hspace{4em}\color{#C00000}{\large\texttt{\char"2A\char"2A\char"2A\char"2A\char"2A}}\color{#0000C0}\char"21B2\\
\hspace{4em}\color{#C00000}{\large\texttt{\char"2423{}\char"2A\char"2A\char"2A}}\color{#0000C0}\char"21B2\\
\hspace{4em}\color{#C00000}{\large\texttt{\char"2423{}\char"2423{}\char"2A}}\color{#0000C0}\char"21B2\\
$$

$\large\char"2461$ 输入
$\hspace{4em}\color{#C00000}\tt{7}\color{#0000C0}\char"21B2$
则应该输出
$$
\hspace{4em}\color{#C00000}{\large\texttt{\char"2423{}\char"2423{}\char"2423{}\char"2A}}\color{#0000C0}\char"21B2\\
\hspace{4em}\color{#C00000}{\large\texttt{\char"2423{}\char"2423{}\char"2A\char"2A\char"2A}}\color{#0000C0}\char"21B2\\
\hspace{4em}\color{#C00000}{\large\texttt{\char"2423{}\char"2A\char"2A\char"2A\char"2A\char"2A}}\color{#0000C0}\char"21B2\\
\hspace{4em}\color{#C00000}{\large\texttt{\char"2A\char"2A\char"2A\char"2A\char"2A\char"2A\char"2A}}\color{#0000C0}\char"21B2\\
\hspace{4em}\color{#C00000}{\large\texttt{\char"2423{}\char"2A\char"2A\char"2A\char"2A\char"2A}}\color{#0000C0}\char"21B2\\
\hspace{4em}\color{#C00000}{\large\texttt{\char"2423{}\char"2423{}\char"2A\char"2A\char"2A}}\color{#0000C0}\char"21B2\\
\hspace{4em}\color{#C00000}{\large\texttt{\char"2423{}\char"2423{}\char"2423{}\char"2A}}\color{#0000C0}\char"21B2\\
$$

$\huge{\color{#00C000}4.}$ $\large\texttt{提示}$
$\large\char"2460$  $\color{008080}call$指令用来调用一个函数，其语法为$\color{C00000}\underline{call~~标号}$，相应地，用$\color{008080}标号$来定义函数名，函数的最后一条语句必须是$\color{008080}ret$指令，表示函数返回
$\large\char"2461$ 在调试时跟踪到$\color{C00000}\underline{call~~标号}$语句时，若要跟踪进入($trace~into$)，请按$\color{C00000}F7$键，若想步过($step~over$)此函数调用，则应按$\color{C00000}F8$键

$\huge{\color{#00C000}5.}$ $\large\texttt{注意事项}$
$\large\char"2460$  请在$\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$之间补充代码，不可删除$\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$标记
$\large\char"2461$  $\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$之间允许写多条指令

$\huge{\color{#00C000}6.}$ ${\large\texttt{提交步骤}}$
$\large\char"2460$ 复制以下源程序内容
```x86asm
code segment
assume cs:code
output_cr:    ; 用标号来命名一个函数
   mov ah, 2
   mov dl, 0Dh; 回车符的ASCII码
   int 21h    ; putchar('\r');
   mov ah, 2
   mov dl, 0Ah; 换行符的ASCII码
   int 21h    ; putchar('\n');
   ret        ; 函数返回
   
output_space: ; 输出bp个空格
   push bp
output_space_next:
   cmp bp, 0
   je output_space_done
   mov ah, 2
   mov dl, ' '
   int 21h
   sub bp, 1
   jmp output_space_next
output_space_done:
   pop bp
   ret
   
output_star: ; 输出bp个*
   push bp
output_star_next:   
   mov ah, 2
   mov dl, '*'
   int 21h
   sub bp, 1
   jnz output_star_next
   pop bp
   ret
   
main:
   mov ah, 1   ; 调用DOS的1号功能输入一个字符
   int 21h     ; AL=输入的字符
               ; 假设输入的字符是{'1', '3', '5', '7', '9'}内的其中之一
   mov ah, 0   ; 把AX的高8位清零
   sub al, '0' ; 脱引号, 比如'5' -> 5
   mov bx, ax  ; bx=行数
   call output_cr
   ;#1_begin-------------------
                              ;<--第1空, 请把解答写在分号左边, 可填多条指令
                              ;第1空须完成以下计算:
                              ;①ax=行数/2; ②si=-(行数/2); ③di=行数/2
                           
             
                        
   ;#1_end=====================
next_row:   
   mov bp, si
   ;#2_begin-------------------
                              ;<--第2空, 请把解答写在分号左边, 可填多条指令
                              ;第2空须完成以下计算:                        
                              ;bp=待输出的空格数=abs(si)
             
                              
   ;#2_end=====================
bp_is_positive:
   call output_space
   ;#3_begin-------------------  
                              ;<--第3空, 请把解答写在分号左边, 可填多条指令
                              ;第3空须完成以下计算:                        
                              ;bp=待输出的*个数=bx - 2*abs(si)
                              
   ;#3_end=====================
   call output_star
   call output_cr
   add si, 1
   cmp si, di
   jle next_row
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
