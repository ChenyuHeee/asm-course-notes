## 9-3 practice_asm_多文件_函数_004_逆序输出一个字符串

- **类型**: MULTIPLE_FILE
- **分值**: 10 分
- **作者**: blackwhite

---

$\huge{\color{#00C000}1.}$ $\large\texttt{本题题型: 程序填空(共1空)}$
$\huge{\color{#00C000}2.}$ $\large\texttt{代码描述}$
$\large\char"2460$ 已知数组$\color{#C00000}s$中存储了一个符合$C$语言标准的字符串(末尾有一个ASCII码等于0的字符)，请在$\color{008080}\large\underline{\tt{;\#1\_begin}}$ $\tt{与}$ $\color{008080}\large\underline{\tt{;\#1\_end}}$之间填写代码，按逆序输出$\color{#C00000}s$中的字符。
$\large\char"2461$ 例如：设$\color{#C00000}s$的内容为$\underline{\color{#C00000}\large\mathtt{abc123}}$ ，则应该输出$\underline{\color{#800080}\large\mathtt{321cba}}$   
$\large\char"2462$ 输出字符请调用$\color{C00000}\underline{int ~21h}$的$\color{008080}2$号功能

$\huge{\color{#00C000}3.}$ $\large\texttt{提示}$
$\large{可能会用到的指令：}$
$\char"2460$ $\tt{je\enspace{}target} $      $\,\color{008080};若相等(equal)则跳到target$
$\char"2461$ $\tt{jne\enspace{}target} $    $\color{008080};若不等(not~ equal)则跳到target$
$\char"2462$ $\tt{jmp\enspace{}target} $    $\color{008080};无条件跳到target$
$\char"2463$ $\tt{jge\enspace{}target} $   $\,\color{008080};若大于等于(greater~or~equal)则跳到target$
$\char"2464$ $\tt{jle\enspace{}target} $   $\,\color{008080};若小于等于(less~or~equal)则跳到target$
$\char"2465$ $\tt{jg\enspace{}target} $     $\,\color{008080};若大于(greater)则跳到target$
$\char"2466$ $\tt{jl\enspace{}target} $     $\,\color{008080};若小于(less)则跳到target$
$\char"2467$ $\tt{sub\enspace{}bx,\enspace{}1} $     $\,\color{008080};\,bx = bx - 1$

$\huge{\color{#00C000}4.}$ $\large\texttt{注意事项}$
$\large\char"2460$  请在$\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$之间补充代码，不可删除$\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$标记
$\large\char"2461$  $\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$之间允许写多条指令

$\huge{\color{#00C000}5.}$ ${\large\texttt{提交步骤}}$
$\large\char"2460$ 复制以下源程序内容
```x86asm
data segment
sth db 10h dup(0)
s db "abc123", 0; 此数组的内容在judge时会发生变化
data ends

code segment
assume cs:code, ds:data
main:
   mov ax, seg s
   mov ds, ax
;#1_begin-------------------------
                                 ;<--第1空, 请把解答写在分号左边, 可填多条指令
                                 
;#1_end===========================
exit:
   mov ah, 4Ch
   mov al, 0
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
