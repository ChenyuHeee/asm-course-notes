## 9-2 practice_asm_编程题_判断素数

- **类型**: MULTIPLE_FILE
- **分值**: 10 分
- **作者**: blackwhite

---

$\huge{\color{#00C000}1.}$ $\large\texttt{本题题型: 编程题}$
$\huge{\color{#00C000}2.}$ $\large\texttt{代码描述}$
已知寄存器$\color{C00000}CX$中保存了一个正整数，且$CX\in[0, 32767]$，请模仿以下$C$语言代码写一个汇编语言程序判断$CX$是否为素数，若是则$\color{008080}\tt{AX=1}$，否则$\color{008080}\tt{AX=0}$：
```c
bx = 2;
again:
if(bx < cx)
{
   if(cx % bx == 0)
      goto check;
   bx = bx + 1;
   goto again;
}
check:
if(bx == cx)
   ax = 1;
else
   ax = 0;
```

$\huge{\color{#00C000}3.}$ $\large\texttt{举例}$
$\large\char"2460$ 若
$\hspace{4em}\color{#C00000}\tt{CX=5}$
则
$\hspace{4em}\color{#C00000}\tt{AX=1}$
$\large\char"2461$ 若
$\hspace{4em}\color{#C00000}\tt{CX=9}$
则
$\hspace{4em}\color{#C00000}\tt{AX=0}$

$\huge{\color{#00C000}4.}$ $\large\texttt{提示}$
$\large\char"2460$ $16位/8位$ 除法举例
```x86asm
mov ax, 123h
mov bl, 10h
div bl ; 当除数为8位时，被除数默认为AX，故div bl就是计算 AX/BL=AL..AH，其中AL为商=12h，AH为余数=03h 
```

$\large\char"2461$ $32位/16位$ 除法举例
```x86asm
mov dx, 123h
mov ax, 4567h
mov bx, 1000h
div bx ; 当除数为16位时，被除数默认为DX与AX组合而成的32位数，
       ; 故div bx就是计算 (DX*0x10000+AX)/BX=AX..DX，
       ; 其中AX为商=1234h，DX为余数=567h 
```

$\huge{\color{#00C000}5.}$ $\large\texttt{注意事项}$
请在$\color{#C000C0}\underline{;\#1\_begin}$与$\color{#C000C0}\underline{;\#1\_end}$之间补充代码，不可删除$\color{#C000C0}\underline{;\#1\_begin}$、$\color{#C000C0}\underline{;\#1\_end}$标记

$\huge{\color{#00C000}6.}$ ${\large\texttt{提交步骤}}$
$\large\char"2460$ 复制以下源程序内容
```x86asm
.386
code segment use16
assume cs:code
main:
   mov cx, 5; cx的值在评测时会发生改变
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
