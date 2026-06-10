## 9-1 practice_asm_多文件_函数_001_输入一个大写英文字母，输出该字母至'Z'的所有字母

- **类型**: MULTIPLE_FILE
- **分值**: 10 分
- **作者**: blackwhite

---

# 一. 题目描述
$\Large\color{008080}1.$ 本题要求从键盘输入一个大写英文字母$\color{C00000}c$，再输出$\color{C00000}c$至$\color{008080}\tt{'Z'}$的所有字母

$\Large\color{008080}2.$ 输入字符请调用$\color{C00000}\underline{int ~21h}$的$\color{008080}1$号功能

$\Large\color{008080}3.$ 输出字符请调用$\color{C00000}\underline{int ~21h}$的$\color{008080}2$号功能

# 二. 输入输出样例 
$\Large\color{008080}1.$ 输入样例
$\large\color{C00000}\tt\underline{X}$

$\Large\color{008080}2.$ 输出样例  
$\large\tt{XYZ}$

# 三. 提交步骤
$\large\char"2460$ 复制以下源程序内容
```x86asm
;本题要求:
comment %
以下程序的功能是从键盘输入一个大写英文字母c，
再输出c至′Z′的所有字母
例如：输入X，则应该输出XYZ
;请把以下代码补充完整
%
code segment
assume cs:code
main:
;请在#1_begin和#1_end之间补充代码实现以下功能:
;从键盘输入一个大写英文字母c，再输出c至′Z′的所有字母
;#1_begin-------------------------------------

;#1_end=======================================
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
