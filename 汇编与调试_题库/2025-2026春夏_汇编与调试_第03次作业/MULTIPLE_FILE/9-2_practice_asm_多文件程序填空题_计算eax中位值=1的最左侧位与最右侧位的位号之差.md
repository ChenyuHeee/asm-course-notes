## 9-2 practice_asm_多文件程序填空题_计算eax中位值=1的最左侧位与最右侧位的位号之差

- **类型**: MULTIPLE_FILE
- **分值**: 10 分
- **作者**: blackwhite

---

$\huge{\color{#00C000}1.}$ $\large\texttt{本题题型: 程序填空(共1空)}$
$\huge{\color{#00C000}2.}$ $\large\texttt{代码描述}$
$\large\char"2460$ 寄存器$\color{#C00000}eax$中保存了一个$32$位的非符号整数，请计算$eax$中$\underline{位值=1}$的最左侧位与最右侧位的位号之差，并以十进制格式输出位号之差。
$\large\char"2461$ 二进制位的编号以$0$为基数，并且按从右到左方向编号，故一个$32$位数的最高位也称作第$\color{C00000}31$位，最低位也称作第$\color{008080}0$位。当$eax=80000001h$时，$\underline{位值=1}$的最左侧位号$=31$，$\underline{位值=1}$的最右侧位号$=0$，故位号之差$=31-0=31$
$\large\char"2462$ 若$\underline{位值=1}$的最左侧位或最右侧位不存在，则应该输出$0$
$\large\char"2463$ 输出结果的末尾不得添加回车及换行，若位号之差是个位数，输出时不可添加前导0
 
$\huge{\color{#00C000}3.}$ $\large\texttt{举例}$
$\large\char"2460$ 若$eax=80008000h$，则应该输出$\color{#008080}16$，因为$\underline{位值=1}$的最左侧位及最右侧位的位号分别为$31、15$，故位号之差$=31-15=16$

$\large\char"2461$ 若$eax=00010000h$，则应该输出$\color{#008080}0$，因为$\underline{位值=1}$的最左侧位及最右侧位的位号分别为$16、16$，故位号之差$=16-16=0$

$\huge{\color{#00C000}4.}$ $\large\texttt{注意事项}$
$\large\char"2460$  请在$\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$之间补充代码，不可删除$\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$标记
$\large\char"2461$  $\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$之间允许写多条指令

$\huge{\color{#00C000}5.}$ ${\large\texttt{提交步骤}}$
$\large\char"2460$ 复制以下源程序内容
```x86asm
.386
code segment use16
assume cs:code
main:
   mov eax, 80000001h  ; eax的值在评测时会改变
   mov ebx, 80000000h  ; ebx = 最高位(即第31位)的掩码
   mov edx, 1          ; edx = 最低位(即第0位)的掩码
   mov esi, 31         ; esi = 最高位的位号
   mov edi, 0          ; edi = 最低位的位号
   ;#1_begin--------------------------------------
                                                 ;<--第1空, 请把解答写在分号左边, 可填多条指令

   ;#1_end========================================   
done:
   mov ah, 4Ch
   mov al, 0
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
