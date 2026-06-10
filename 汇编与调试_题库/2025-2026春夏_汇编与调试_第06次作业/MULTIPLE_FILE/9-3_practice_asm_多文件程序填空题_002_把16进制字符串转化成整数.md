## 9-3 practice_asm_多文件程序填空题_002_把16进制字符串转化成整数

- **类型**: MULTIPLE_FILE
- **分值**: 10 分
- **作者**: blackwhite

---

# 一. 题目描述
$\color{#00C000}\huge{1.}$ 本题是多文件题，先由judge程序生成输出，再把该输出作为用户程序的输入，用户程序根据输入进行计算，最后judge程序判断用户计算结果是否正确。
$\color{#00C000}\huge{2.}$ 用户程序的工作流程如下:
从键盘输入一行长度不超过8个字符的16进制字符串并保存到数组$\color{#C00000}s$中，再把该字符串转化成
32位整数并保存到变量result中。注意字符串s一定以$00h$字符结束。
例如：输入$\underline{\color{#C00000}\large\mathtt{8086CaFe}}$ ，则$result$的值=$\underline{\color{#800080}\large\mathtt{8086CAFEh}}$。

# 二. 提交步骤
下载zip题目包，解压缩，对$src/main.c$进行完善，选中$main.sh$及$src$目录$\rightarrow$右键$\rightarrow$压缩成$submit.zip$文件，提交$submit.zip$。
