## 9-1 practice_asm_多文件_函数_021_迷宫

- **类型**: MULTIPLE_FILE
- **分值**: 20 分
- **作者**: blackwhite

---

$\huge{\color{#00C000}1.}$ $\large\texttt{本题题型: 多文件程序填空题(共2空)}$
$\huge{\color{#00C000}2.}$ $\large\texttt{代码描述}$
本题要求实现2个函数：
$\large\char"2460$ $\color{#C00000}{\underline{int~~ move\_bug(int~ x0, ~int~ y0, ~int~ x1, ~int~ y1);}}$
$\hspace{1.5em}$$\large\char"2776$用深度优先算法搜索迷宫，查找起点到终点的路径, 
$\hspace{1.5em}$其中$\color{C00000}(x0,~y0)$是起点, $\color{008080}(x1,~y1)$是终点
$\hspace{1.5em}$$\large\char"2777$当搜索失败时函数的返回值$=0$，否则返回值$=1$

$\large\char"2461$ $\color{#C00000}{\underline{void~~show\_maze(int~ x0, ~int~ y0,~ int~ x1,~ int~ y1);}}$
$\hspace{1.5em}$画迷宫

$\huge{\color{#00C000}3.}$ $\large\texttt{{\Large{C}}语言参考代码}$

/&ast; 编译及运行步骤:
把此文件复制到Bochs虚拟机的c:\tc中,
运行Bochs虚拟机
c:
cd \tc
tc
Alt+F选择File-&gt;Load-&gt;maze.c
Alt+C选择Compile-&gt;Compile to OBJ 编译
Alt+C选择Compile-&gt;Line EXE file 连接
Alt+R选择Run-&gt;Run 运行
 &ast;/

#include &lt;stdio.h&gt;
#include &lt;dos.h&gt;

#define WALL 0xB2
#define RED 0x0C
#define WHITE 0x07
#define RIGHT_BOUND 40
#define BOTTOM_BOUND 12

unsigned char maze[BOTTOM_BOUND+1][RIGHT_BOUND+1] =
{
   {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
   {1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1},
   {1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1},
   {1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1},
   {1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1},
   {1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1},
   {1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1},
   {1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1},
   {1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1},
   {1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1},
   {1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1},
   {1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1},
   {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
};
unsigned char mark[BOTTOM_BOUND+1][RIGHT_BOUND+1];
unsigned char trace[BOTTOM_BOUND+1][RIGHT_BOUND+1];
int tx=39, ty=11;

void draw_char(int x, int y, unsigned char shape, unsigned char color);
void show_maze(int x0, int y0, int x1, int y1);
int  move_bug(int x0, int y0, int x1, int y1);
void show_trace(void);

/&ast; 在坐标(x,y)处画一个颜色为color的字符shape &ast;/
void draw_char(int x, int y, unsigned char shape, unsigned char color)
{
   char far &ast;p = (char far &ast;)0xB8000000 + (y&ast;80+x)&ast;2;
   &ast;p++ = shape;
   &ast;p = color;
}

/&ast; 显示迷宫 &ast;/
void show_maze(int x0, int y0, int x1, int y1)
{
   int x, y;
   unsigned char c;
   for(y=y0; y&lt;=y1; y++)
   {
      for(x=x0; x&lt;=x1; x++)
      {
         c = maze[y][x];
         if(c == 0)
            c = ' ';
         else if(c == 1)
            c = WALL;
         draw_char(x, y, c, WHITE);
      }
   }
}

/&ast; 画路线 &ast;/
void show_trace(void)
{
   int x, y;
   for(x=1; x&lt;RIGHT_BOUND; x++)
   {
      for(y=1; y&lt;BOTTOM_BOUND; y++)
      {
         if(trace[y][x] == 1)
            draw_char(x, y, ' ', 0x47);
      }
   }
}

/&ast; 用深度优先算法搜索迷宫查找目标, (x0,y0)是起点, (x1,y1)是终点 &ast;/
int move_bug(int x0, int y0, int x1, int y1)
{
   int k, nx, ny;
   static int d[4][2]={{-1,0},{0,1},{1,0},{0,-1}};
   if(x0&lt;0 || y0&lt;0 || x0&gt;RIGHT_BOUND || y0&gt;BOTTOM_BOUND)
      return 0;
   if(maze[y0][x0] == 1)
      return 0;
   if(mark[y0][x0] == 1)
      return 0;
   mark[y0][x0] = 1;  /&ast; Mark it so that we will not come here again &ast;/
                      /&ast; 做个记号, 表示已来过此处, 下次递归时再遇到此处应该回头 &ast;/

   trace[y0][x0] = 1; /&ast; This may be a node on the way to the target &ast;/
                      /&ast; 暂时把(x0,y0)存放到路线中 &ast;/
   if(x0 == x1 && y0 == y1)
   {
      return 1;        /&ast; 到达目标, 返回真 &ast;/
   }
   for(k=0; k&lt;4; k++)  /&ast; 尝试让虫子爬到某个方向 &ast;/
   {
      nx = x0+d[k][0];
      ny = y0+d[k][1];
      if(move_bug(nx, ny, x1, y1) == 1)
         return 1;       /&ast; 若让虫子从(x0,y0)出发, 顺着第k个方向爬到(nx,ny)并
                            最终能遇到目标则返回真 &ast;/
   }
   trace[y0][x0] = 0; /&ast; After 4 loops above, we have proved that this is not 
                         a node on the way to the target &ast;/
                      /&ast; 由于4个方向都是错误的, 故在路线中删除此坐标 &ast;/
   return 0;
}

main()
{
   _AX = 0x0003;        /&ast; 相当于汇编语言的mov ax, 3; &ast;/
   geninterrupt(0x10);  /&ast; 相当于汇编语言的int 10h    &ast;/
                        /&ast; 上述2条语句可实现清屏效果  &ast;/
   maze[1][1]   = 0x0F; /&ast; 在maze[1][1]处填入虫子字符, 此字符代表源 &ast;/
   maze[ty][tx] = 0x1E; /&ast; 在maze[ty][tx]处填入三角形字符, 此字符代表目标 &ast;/
   show_maze(0, 0, RIGHT_BOUND, BOTTOM_BOUND); /&ast; 显示迷宫 &ast;/
   move_bug(1, 1, tx, ty); /&ast; 让虫子在迷宫中用深度优先算法寻找右下角的目标 &ast;/
   show_trace();        /&ast; 显示正确路线 &ast;/
}`
```

$\huge{\color{#00C000}4.}$ $\large\texttt{输入输出样例}$
$\large\char"2460$ $\large{输入样例}$

maze label byte
db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
db 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1
db 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1
db 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1
db 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1
db 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1
db 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1
db 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1
db 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1
db 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1
db 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1
db 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1
db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
tx dw 39
ty dw 11
`
```

$\large\char"2461$ $\large{输出样例}$
![maze.PNG](~/96a9447c-d312-4358-8c6c-44e77dab8e9b.PNG)

$\huge{\color{#00C000}5.}$ $\large\texttt{注意事项}$
$\large\char"2460$  请在$\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$之间补充代码，不可删除$\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$标记
$\large\char"2461$  $\color{#C000C0}\underline{\#n\_begin}$和$\color{#C000C0}\underline{\#n\_end}$之间允许写多条指令

$\huge{\color{#00C000}6.}$ ${\large\texttt{提交步骤}}$
$\large\char"2460$ 复制以下源程序内容
```x86asm
.386

data segment use16
WALL         equ 0B2h
RED          equ 0Ch
WHITE        equ 07h
RIGHT_BOUND  equ 40
BOTTOM_BOUND equ 12
W            equ (RIGHT_BOUND+1)
H            equ (BOTTOM_BOUND+1)
;
;-------以下定义在judge时会改变---------
maze label byte
db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
db 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1
db 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1
db 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1
db 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1
db 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1
db 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1
db 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1
db 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1
db 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1
db 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1
db 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1
db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
tx dw 39
ty dw 11
;=======以上定义在judge时会改变=========
;
trace db (BOTTOM_BOUND+1)*(RIGHT_BOUND+1) dup (0)
mark  db (BOTTOM_BOUND+1)*(RIGHT_BOUND+1) dup (0)
;
d dw -1, 0, 0, 1, 1, 0, 0, -1; int d[4][2]={{-1,0},{0,1},{1,0},{0,-1}}
data ends

code segment use16
assume cs:code, ds:data
;把二维数组下标转化为一维数组下标
;int __stdcall index(int y, int x)
;input:
;   y = word ptr [bp+4]
;   x = word ptr [bp+6]
;output:
;   di = y*W+x
index proc
   push bp
   mov bp, sp
   mov ax, [bp+4]
   mov cx, W
   mul cx
   add ax, [bp+6]
   mov di, ax
   pop bp
   ret 4
index endp

;在坐标(x,y)处画一个颜色为color的字符shape
;void __cdecl draw_char(int x, int y, unsigned char shape, unsigned char color)
;input:
;   x = [bp+4]
;   y = [bp+6]
;   shape = [bp+8]
;   color = [bp+0Ah]
;output:
;   draw shape with color at (x,y)
draw_char:
   push bp
   mov bp, sp
   push di
   mov ax, [bp+6]
   mov cx, 80
   mul cx
   add ax, [bp+4]
   shl ax, 1
   mov di, ax
   mov al, [bp+8]
   mov ah, [bp+0Ah]
   mov es:[di], ax
   pop di
   pop bp
   ret

;显示迷宫
;void __cdecl show_maze(int x0, int y0, int x1, int y1)
;input:
;   x0 = [bp+4]
;   y0 = [bp+6]
;   x1 = [bp+8]
;   y1 = [bp+0Ah]
;output:
;   show maze
show_maze:
;#1_begin------------------------------
                                      ; <--第1空, 请把解答写在分号左边, 可填多条指令

;#1_end================================

;画路线
;void __cdecl show_trace(void)
show_trace:
   push bp
   mov bp, sp
   push bx
   push si
   push di
   mov bx, 1
show_trace_next_row:
   cmp bx, BOTTOM_BOUND
   jge show_trace_done
   mov si, 1
show_trace_next_node:
   cmp si, RIGHT_BOUND
   jge show_trace_one_row_done
   push si
   push bx
   call index
   mov al, trace[di]
   cmp al, 1
   jne show_trace_one_node_done
show_this_trace_node:
   mov al, 47h
   push ax
   mov al, ' '
   push ax
   push bx
   push si
   call draw_char
   add sp, 8
show_trace_one_node_done:
   inc si
   jmp show_trace_next_node
show_trace_one_row_done:
   inc bx
   jmp show_trace_next_row
show_trace_done:
   pop di
   pop si
   pop bx
   pop bp
   ret   

;用深度优先算法搜索迷宫查找目标, (x0,y0)是起点, (x1,y1)是终点
;int __cdecl move_bug(int x0, int y0, int x1, int y1)
;input:
;   x0 = [bp+4]
;   y0 = [bp+6]
;   x1 = [bp+8]
;   y1 = [bp+0Ah]
;output:
;   ax = 1 as true
;   ax = 0 as false
;locals:
;   k  = word ptr [bp-6]
;   nx = word ptr [bp-4]
;   ny = word ptr [bp-2]
k  equ word ptr [bp-6]
nx equ word ptr [bp-4]
ny equ word ptr [bp-2]
move_bug:
;#2_begin------------------------------
                                      ; <--第2空, 请把解答写在分号左边, 可填多条指令

;#2_end================================

main:
   mov ax, data
   mov ds, ax
   mov ax, 0B800h
   mov es, ax
   cld
   ;
   mov ax, 0003h
   int 10h
   ;
   mov maze[W*1+1], 0Fh
   ;
   push [tx]
   push [ty]
   call index
   mov maze[di], 1Eh
   ;
   mov ax, BOTTOM_BOUND
   push ax
   mov ax, RIGHT_BOUND
   push ax
   xor ax, ax
   push ax
   push ax
   call show_maze
   add sp, 8
   ;
   push [ty]
   push [tx]
   mov ax, 1
   push ax
   push ax
   call move_bug
   add sp, 8
   ;
   call show_trace
   ;
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
