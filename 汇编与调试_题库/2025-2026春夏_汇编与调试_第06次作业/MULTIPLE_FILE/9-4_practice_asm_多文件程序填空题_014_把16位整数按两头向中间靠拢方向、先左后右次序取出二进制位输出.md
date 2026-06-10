## 9-4 practice_asm_多文件程序填空题_014_把16位整数按两头向中间靠拢方向、先左后右次序取出二进制位输出

- **类型**: MULTIPLE_FILE
- **分值**: 10 分
- **作者**: blackwhite

---

$\huge{\color{#00C000}1.}$ $\large\texttt{本题题型: 多文件程序填空题(共1空)}$
$\huge{\color{#00C000}2.}$ $\large\texttt{代码描述}$
变量$\color{C00000}abc$中存有一个$16$位整数，按以下步骤把它转化成一个二进制字符串，并保存到数组$\color{008080}buf$中，最后输出$buf$：
① $i=0, n=16$
② $buf[i*2]~=~abc$的第$n-1-i$位 $+ {\tt'}0{\tt'}$
③ $buf[i*2+1]~=~abc$的第$i$位 $+{\tt'}0{\tt'}$
④ $i++$
⑤ 若$i\leqslant{}7$则跳转到②
⑥ 输出$buf$

例如：若有$\underline{\color{#C00000}\large\mathtt{abc~ dw~1234h}}$ ，则应输出$\underline{\color{#800080}\large\mathtt{0000011001011000}}$

$\huge{\color{#00C000}3.}$ $\large\texttt{注意事项}$
$\large\char"2460$  请在$\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$之间补充代码，不可删除$\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$标记
$\large\char"2461$  $\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$之间允许写多条指令

$\huge{\color{#00C000}4.}$ ${\large\texttt{提交步骤}}$
$\large\char"2460$ 复制以下源程序内容
```x86asm
.386
data segment use16
;----以下变量的值在评测时会发生改变----
abc dw 1234h
;====以上变量的值在评测时会发生改变====
buf db 16 dup(0), 0Dh, 0Ah, '$' ; buf用来存放待输出的二进制字符串
data ends

code segment use16
assume cs:code, ds:data
main:
   mov ax, data
   mov ds, ax
;#1_begin-------------------------------------
                                             ;<--第1空, 请把解答写在分号左边, 可填多条指令
                                             
;#1_end=======================================
exit:
   mov ah, 9
   mov dx, offset buf
   int 21h
   mov ah, 4Ch
   int 21h
code ends
end main
```
$\large\char"2461$ 在桌面空白处，点右键$\rightarrow$新建$\rightarrow$文本文档，并把此文件重命名设为$\underline{\color{008080}s.asm}$
$\large\char"2462$ 用$\color{C00000}editplus$打开$s.asm$
$\large\char"2463$ 把步骤$\large\char"2460$复制的内容粘贴到$editplus$内
$\large\char"2464$ 在$editplus$中对代码进行完善，注意完善代码时切勿删除$\color{#C000C0}\underline{;\#n\_begin}$、$\color{#C000C0}\underline{;\#n\_end}$标记
$\large\char"2465$ 保存$s.asm$并在$XP$或$Bochs$虚拟机中编译、调试$s.asm$
$\large\char"2466$ 复制$s.asm$的内容到提交框内，点“$\underline{\color{C00000}\tt{提交本题作答}}$”按钮
