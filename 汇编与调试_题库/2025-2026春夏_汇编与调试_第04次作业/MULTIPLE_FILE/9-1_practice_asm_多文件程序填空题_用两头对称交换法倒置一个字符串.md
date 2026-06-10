## 9-1 practice_asm_多文件程序填空题_用两头对称交换法倒置一个字符串

- **类型**: MULTIPLE_FILE
- **分值**: 10 分
- **作者**: blackwhite

---

$\huge{\color{#00C000}1.}$ $\large\texttt{本题题型: 程序填空(共1空)}$
$\huge{\color{#00C000}2.}$ $\large\texttt{代码描述}$
用两头对称交换法把数组$\color{C00000}s$的内容进行倒置，使得程序能输出$\color{008080}EBX$的十进制值。
$\huge{\color{#00C000}3.}$ $\large\texttt{举例}$
$\large\char"2460$ 设$\color{#C00000}\tt{EBX=7FFFFFFFh}$
则应该输出
$$
\hspace{4em}\color{#C00000}{\large\texttt{2147483647}}
$$

$\large\char"2461$ 设$\color{#C00000}\tt{EBX=12345678}$
则应该输出
$$
\hspace{4em}\color{#C00000}{\large\texttt{12345678}}
$$

$\huge{\color{#00C000}4.}$ $\large\texttt{注意事项}$
$\large\char"2460$  请在$\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$之间补充代码，不可删除$\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$标记
$\large\char"2461$  $\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$之间允许写多条指令

$\huge{\color{#00C000}5.}$ ${\large\texttt{提交步骤}}$
$\large\char"2460$ 复制以下源程序内容
```x86asm
.386
data segment use16
s db 10 dup(' '), 0
data ends

code segment use16
assume cs:code, ds:data
main:
   mov ax, seg s      ; seg s表示s的段地址
   mov ds, ax         ; ds=数组s的段地址
   mov si, offset s   ; offset s表示s的偏移地址
   mov ebx, 7FFFFFFFh ; ebx=待转化的32位数，其值在评测时会改变
   mov ebp, 10        ; ebp = 除数
again:   
   mov edx, 0         ; 清除64位被除数(由edx、eax拼接)的高32位
   mov eax, ebx       ; eax=64位被除数的低32位
   div ebp            ; edx、eax / ebp = eax..edx, 商为eax, 余数为edx
   add edx, '0'       ; 把edx中的余数转化成数字字符, 例如7转化成'7'
   mov ds:[si], dl    ; 把上条指令运算结果edx中的低8位dl保存到ds:[si]中
                      ; 这里不需要保存整个edx, 因为edx的高24位一定等于0
   add si, 1
   mov ebx, eax       ; 更新被除数
   cmp eax, 0         ; 若商≠0则...
   jne again          ; ==>again
done:   
   mov byte ptr ds:[si], 0 ; 在字符串末尾填入结束标志'\0'
   mov di, si
   sub di, 1               ; ds:di -> s的末元素
   mov si, offset s        ; ds:si -> s的首元素
   ;#1_begin------------------
                           ;<--第1空, 请把解答写在分号左边, 可填多条指令

   ;#1_end====================   
output:
   mov si, offset s
output_next:   
   mov ah, 2
   mov dl, ds:[si]
   cmp dl, 0
   je exit
   int 21h
   add si, 1
   jmp output_next
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
