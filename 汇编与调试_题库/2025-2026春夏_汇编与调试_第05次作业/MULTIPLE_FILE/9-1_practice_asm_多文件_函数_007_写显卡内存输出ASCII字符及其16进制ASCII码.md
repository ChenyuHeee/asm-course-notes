## 9-1 practice_asm_多文件_函数_007_写显卡内存输出ASCII字符及其16进制ASCII码

- **类型**: MULTIPLE_FILE
- **分值**: 10 分
- **作者**: blackwhite

---

# 一. 题目描述
以下程序的功能是从键盘输入一个十六进制数，该十六进制数一共$2$位，其中十位保存到$buf[0]$中，个位保存到$buf[1]$中，无论十位还是个位只要输入的是字母则一定是大写形式。
接下去按以下步骤从屏幕第0行起输出16行内容，每行都输出字符$\underline{c+i}$($i$为屏幕行号,$c$为输入的16进制ASCII码对应的字符)及其16进制ASCII码:
$\large\char"2776$把$buf[0]$及$buf[1]$中的十六进制字符脱去引号
$\large\char"2777$计算$(buf[0]http://cc.zju.edu.cn/bhh/asm/ascii.c 用C语言写的解答
http://cc.zju.edu.cn/bhh/asm/calldemo.asm 演示如何定义并调用函数
# 四. 提交步骤
下载zip题目包，解压缩，对$src/main.asm$进行完善，选中$main.sh$及$src$目录$\rightarrow$右键$\rightarrow$压缩成$submit.zip$文件，提交$submit.zip$。
