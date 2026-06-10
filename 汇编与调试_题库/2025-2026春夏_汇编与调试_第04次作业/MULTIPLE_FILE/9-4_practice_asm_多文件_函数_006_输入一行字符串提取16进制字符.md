## 9-4 practice_asm_多文件_函数_006_输入一行字符串提取16进制字符

- **类型**: MULTIPLE_FILE
- **分值**: 10 分
- **作者**: blackwhite

---

# 一. 题目描述
从键盘输入一行字符串并保存到数组$\color{#C00000}s$中，再从数组$s$中按从左到右顺序提取16进制字符并保存到数组$\color{#C00000}t$中，其中16进制字符是指以下这些字符：
$\hspace{4em}\color{008080}[\tt{'A', ~'F'}]$
$\hspace{4em}\color{008080}[\tt{'a', ~'f'}]$
$\hspace{4em}\color{008080}[\tt{'0', ~'9'}]$
在提取及保存过程中，请注意以下2个规则:
$\large\char"2460$若遇到小写字母则必须先转化成大写再保存到$t$中
$\large\char"2461$$s$及$t$中的字符串均必须用$00h$字符(即C语言中的'\0'字符)结束
例如：输入$\underline{\color{#C00000}\large\mathtt{abcXEYfZ123\char"24\,\^{}\,\#@}}$ ，则数组t中应该存放$\underline{\color{#800080}\large\mathtt{ABCEF123}}$                       
# 二. 提交步骤
下载zip题目包，解压缩，对$src/main.c$进行完善，选中$main.sh$及$src$目录$\rightarrow$右键$\rightarrow$压缩成$submit.zip$文件，提交$submit.zip$。
