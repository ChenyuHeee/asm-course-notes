## 9-2 practice_asm_多文件程序填空题_012_输出九九乘法表

- **类型**: MULTIPLE_FILE
- **分值**: 10 分
- **作者**: blackwhite

---

$\huge{\color{#00C000}1.}$ $\large\texttt{本题题型: 多文件程序填空题(共1空)}$
$\huge{\color{#00C000}2.}$ $\large\texttt{代码描述}$
请参考以下$C$语言代码，用汇编语言输出九九乘法表：
```c
#include 
char s[] = "1*1= 1  ";
char cr[] = "\r\n";
main()
{
   int ax;
   char al, ah;
   for(s[0]='1'; s[0]<='9'; s[0]++)
   {
      for(s[2]=s[0]; s[2]<='9'; s[2]++)
      {
         ax = (s[0]-'0') * (s[2]-'0');
         al = ax / 10;
         ah = ax % 10;
         if(al == 0)
            s[4] = ' ';
         else
            s[4] = al + '0';
         s[5] = ah + '0';
         printf(s);
      }
      printf(cr);
   }
}
```

$\huge{\color{#00C000}3.}$ $\large\texttt{输出样例}$
```
1*1= 1  1*2= 2  1*3= 3  1*4= 4  1*5= 5  1*6= 6  1*7= 7  1*8= 8  1*9= 9  
2*2= 4  2*3= 6  2*4= 8  2*5=10  2*6=12  2*7=14  2*8=16  2*9=18  
3*3= 9  3*4=12  3*5=15  3*6=18  3*7=21  3*8=24  3*9=27  
4*4=16  4*5=20  4*6=24  4*7=28  4*8=32  4*9=36  
5*5=25  5*6=30  5*7=35  5*8=40  5*9=45  
6*6=36  6*7=42  6*8=48  6*9=54  
7*7=49  7*8=56  7*9=63  
8*8=64  8*9=72  
9*9=81  

```

$\huge{\color{#00C000}5.}$ $\large\texttt{注意事项}$
请在$\color{#C000C0}\underline{;\#1\_begin}$与$\color{#C000C0}\underline{;\#1\_end}$之间补充代码，不可删除$\color{#C000C0}\underline{;\#1\_begin}$、$\color{#C000C0}\underline{;\#1\_end}$标记

$\huge{\color{#00C000}6.}$ ${\large\texttt{提交步骤}}$
$\large\char"2460$ 复制以下源程序内容
```x86asm
data segment
s  db "1*1= 1  ", '$'  ; s[0]=被乘数+'0', s[2]=乘数+'0'，s[4]=乘积的十位+'0' 
                       ; （若乘积为个位数则s[4]=' '），s[5]=乘积的个位+'0'
                       ; 一个乘法算式总共包含8个字符，故文本模式下每行（80列）
                       ; 足够输出9个算式
cr db 0Dh, 0Ah, '$'    ; 定义一个由回车及换行构成的字符串
data ends

code segment
assume cs:code, ds:data
main:
   mov ax, data
   mov ds, ax
;#1_begin-------------------------------------

;#1_end========================================
exit:                
   mov ah, 4Ch
   int 21h             ; 结束程序运行
code ends
end main
```
$\large\char"2461$ 在桌面空白处，点右键$\rightarrow$新建$\rightarrow$文本文档，并把此文件重命名设为$\underline{\color{008080}s.asm}$
$\large\char"2462$ 用$\color{C00000}editplus$打开$s.asm$
$\large\char"2463$ 把步骤$\large\char"2460$复制的内容粘贴到$editplus$内
$\large\char"2464$ 在$editplus$中对代码进行完善，注意完善代码时切勿删除$\color{#C000C0}\underline{;\#1\_begin}$、$\color{#C000C0}\underline{;\#1\_end}$标记
$\large\char"2465$ 保存$s.asm$并在$XP$或$Bochs$虚拟机中编译、调试$s.asm$
$\large\char"2466$ 复制$s.asm$的内容到提交框内，点“$\underline{\color{C00000}\tt{提交本题作答}}$”按钮
