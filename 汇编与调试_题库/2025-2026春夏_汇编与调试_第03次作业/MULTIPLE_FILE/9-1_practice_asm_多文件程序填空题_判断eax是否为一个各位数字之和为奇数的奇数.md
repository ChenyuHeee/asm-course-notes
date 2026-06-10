## 9-1 practice_asm_多文件程序填空题_判断eax是否为一个各位数字之和为奇数的奇数

- **类型**: MULTIPLE_FILE
- **分值**: 10 分
- **作者**: blackwhite

---

$\huge{\color{#00C000}1.}$ $\large\texttt{本题题型: 程序填空(共1空)}$
$\huge{\color{#00C000}2.}$ $\large\texttt{代码描述}$
寄存器$\color{#C00000}eax$中保存了一个$32$位的非符号整数，若它同时满足以下两个条件则输出$\color{#008080}\tt{Y}$，否则输出$\color{#008080}\tt{N}$：
$\large\char"2460$ $eax$本身是一个奇数
$\large\char"2461$ $eax$的十进制各位数字之和也是一个奇数

$\huge{\color{#00C000}3.}$ $\large\texttt{举例}$
$\large\char"2460$ 若$eax=111$，则应该输出$\color{#008080}\tt{Y}$，因为$111$本身是一个奇数，且$1+1+1=3$也是一个奇数

$\large\char"2461$ 若$eax=101$，则应该输出$\color{#008080}\tt{N}$，因为$1+0+1=2$不是奇数

$\huge{\color{#00C000}5.}$ $\large\texttt{注意事项}$
$\large\char"2460$  请在$\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$之间补充代码，不可删除$\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$标记
$\large\char"2461$  $\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$之间允许写多条指令

$\huge{\color{#00C000}6.}$ ${\large\texttt{提交步骤}}$
$\large\char"2460$ 复制以下源程序内容
```x86asm
.386
code segment use16
assume cs:code
main:
   mov eax, 2147483647 ; eax的值在评测时会发生改变
   mov ebx, 10
   mov ecx, 0
   ;#1_begin--------------------------------------   
                                                 ;<--第1空, 请把解答写在分号左边, 可填多条指令
                                                 
   ;#1_end========================================   
   jmp done
no:
   mov ah, 2
   mov dl, 'N'
   int 21h
   jmp done
yes:
   mov ah, 2
   mov dl, 'Y'
   int 21h
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
