# 汇编语言程序设计与调试

> 浙江大学《汇编与调试》课程笔记与课件

## 在线实验平台

**[asm.hechenyu.xin](https://asm.hechenyu.xin)** — 基于 DOSBox 后端的 x86 汇编在线编译器，支持 TASM 语法，可直接在浏览器中编写、编译、运行课程代码。

源码：[github.com/ChenyuHeee/asm-web](https://github.com/ChenyuHeee/asm-web)

---

## 目录

### 笔记（`notes/`）

| 周 | 内容 |
|----|------|
| 01 | 环境与入门 — 第一个程序、if-else、while、factorial |
| 02 | 除法、分支、循环 — div、cmp/jxx、嵌套循环 |
| 03 | 算术与位运算 — add/sub/mul/imul、and/or/xor、移位 |
| 04 | 运算分支循环总结 — 综合复习、loop 指令 |
| 05 | 输入输出 — int 21h I/O、push/pop、小端序 |
| 06 | 内存与变量 — db/dw/dd、段寻址、byte/word ptr |
| 07 | 数组与显存 — 间接寻址、B800 文本模式、A000 图形模式 |
| 08 | 堆栈与函数 — call/ret、栈帧、参数传递 |
| 09 | 调用约定与递归 — cdecl/pascal/stdcall、递归 |
| 10 | 远指针与断点 — far call/retf、软件/硬件断点 |
| 11 | 中断 — 软中断/硬中断、int/iret、中断向量表 |
| 12 | 中断实战 — int 8h 时钟中断、TSR、int 80h |
| 13 | 键盘与单步中断 — int 9h、int 1h、反调试 |

### 课件（`teacher/`）

week02–week14 教师示例代码（.asm 文件）及课件材料。

### 作业（`作业题解.md`）

8 次作业共 17 道题，全部附答案与解题思路。

### 题库（`汇编与调试_题库/`）

考试题库。
