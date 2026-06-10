## 9-3 practice_asm_多文件_函数_011(new)_输入一个十进制字符串,输出该字符串所含字符的8x16点阵

- **类型**: MULTIPLE_FILE
- **分值**: 10 分
- **作者**: blackwhite

---

![dotmatrix.png](~/3036ea26-a7e5-49b8-98ee-5b44ca6c4221.png)
$\huge{\color{#00C000}1.}$ $\large\texttt{本题题型: 多文件程序填空题(共1空)}$
$\huge{\color{#00C000}2.}$ $\large\texttt{代码描述}$
$\large\char"2460$ 从键盘输入一个十进制字符串并保存到数组$\color{C00000}buf$中，该字符串的长度$\leqslant{}10$
$\large\char"2461$ $i=0$
$\large\char"2462$ 从$buf$中取出字符$buf[i]$，若$buf[i]==0$则跳转到$\large\char"2467$
$\large\char"2463$ 按以下公式计算出该字符的8x16点阵信息的偏移地址$matrix\_addr$：
$\hspace{3em}matrix\_addr = (offset~~ matrix) ~+~ {\large{(}}(buf[i] - \tt{'}0\tt{'}) input_done
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
   mov ah, 0
   mov al, 13h
   int 10h        ; 切换到320*200图形模式
   mov ax, 0A000h
   mov es, ax     ; 设置显卡地址为A000:0000   
   mov bx, -1
   mov bp, bx
   mov si, bx
   mov di, bx
;#1_begin-------------------------------------
                                             ;<--第1空, 请把解答写在分号左边, 可填多条指令

;#1_end=======================================
exit:
   mov ah, 0
   mov al, 3
   int 10h        ; 切换回80*25文本模式
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
