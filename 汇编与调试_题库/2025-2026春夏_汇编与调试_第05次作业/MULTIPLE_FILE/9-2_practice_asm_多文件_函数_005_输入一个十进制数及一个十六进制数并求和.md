## 9-2 practice_asm_多文件_函数_005_输入一个十进制数及一个十六进制数并求和

- **类型**: MULTIPLE_FILE
- **分值**: 10 分
- **作者**: blackwhite

---

# 一. 题目描述
$\color{#00C000}\huge{1.}$ 从键盘输入一个其值不超过$4294967295$的十进制数及一个其值不超过$0FFFFFFFFh$的十六进制数，这两个数输入时均以回车结束，其中十进制数保存在数组$d$中，十六进制数保存在数组$h$中。因judge程序会提供符合范围的输入，故程序中不需要对两个数的范围进行检测。
$\color{#00C000}\huge{2.}$ 把$d$中的字符串转化成整数，把$h$中的字符串也转化成整数，求它们的和，结果保存到变量$result$中。若求和时有进位，则丢弃该进位。
$\color{#00C000}\huge{3.}$ 例如：输入
$\hspace{2em}\underline{\color{#C00000}\large\mathtt{2147483647}}\char"21B2$
$\hspace{2em}\underline{\color{#800080}\large\mathtt{8086CaFe}}\char"21B2$
则$result=\tt{0086CAFDh}$。
# 二. 提交步骤
下载zip题目包，解压缩，对$src/main.c$进行完善，选中$main.sh$及$src$目录$\rightarrow$右键$\rightarrow$压缩成$submit.zip$文件，提交$submit.zip$。
