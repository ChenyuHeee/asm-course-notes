## 9-1 practice_asm_编程题_AX为正时计算2*AX否则计算AX的平方

- **类型**: MULTIPLE_FILE
- **分值**: 10 分
- **作者**: blackwhite

---

$\huge{\color{#00C000}1.}$ $\large\texttt{本题题型: 编程题}$
$\huge{\color{#00C000}2.}$ $\large\texttt{代码描述}$
$\large\char"2460$  已知寄存器$\color{C00000}AX$中保存了一个符号数
$\large\char"2461$  若$AX\geqslant{}0$则计算$AX=2\times{}AX$
$\large\char"2462$  若$AX<0$则计算$AX=AX^2$
  
$\huge{\color{#00C000}3.}$ $\large\texttt{举例}$
$\large\char"2460$ 若
$\hspace{4em}\color{#C00000}\tt{AX=5}$
则
$\hspace{4em}\color{#C00000}\tt{AX=000Ah}$
$\large\char"2461$ 若
$\hspace{4em}\color{#C00000}\tt{AX=-3}$
则
$\hspace{4em}\color{#C00000}\tt{AX=0009h}$

$\huge{\color{#00C000}4.}$ $\large\texttt{注意事项}$
请在$\color{#C000C0}\underline{;\#1\_begin}$与$\color{#C000C0}\underline{;\#1\_end}$之间补充代码，不可删除$\color{#C000C0}\underline{;\#1\_begin}$、$\color{#C000C0}\underline{;\#1\_end}$标记

$\huge{\color{#00C000}5.}$ ${\large\texttt{提交步骤}}$
$\large\char"2460$ 复制以下源程序内容
```x86asm
.386
code segment use16
assume cs:code
main:
   mov ax, -2; ax的值在评测时会发生改变
   ;#1_begin--------------------------------------

   ;#1_end========================================
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
