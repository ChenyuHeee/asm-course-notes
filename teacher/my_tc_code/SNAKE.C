/*****************************************************/
/* Snake v1.0                                        */
/* Copyright (c) Black White, Dec 20, 2023.          */
/* email: iceman@zju.edu.cn                          */
/* This program is for teaching purpose only, and    */
/* it can ONLY be shared within Zhejiang University. */
/* Everyone at ZJU who has downloaded this program   */
/* is NOT allowed to upload it to internet & CC98    */
/* without my permission.                            */
/*****************************************************/

/* 编译及运行步骤:
把此文件复制到xp虚拟机d:\tc中
运行tc后:
Alt+F选择File->Load->snake.c
Alt+C选择Compile->Compile to OBJ 编译
Alt+C选择Compile->Line EXE file 连接
Alt+R选择Run->Run 运行

    或

把此文件复制到Bochs虚拟机的c:\tc中, 
运行Bochs虚拟机
c:
cd \tc
tc
Alt+F选择File->Load->snake.c
Alt+C选择Compile->Compile to OBJ 编译
Alt+C选择Compile->Line EXE file 连接
Alt+R选择Run->Run 运行
 */

#include <stdio.h>
#include <stdlib.h>
#include <dos.h>
#include <bios.h>
#define HEAD 0xEE
#define NECK 0xF7
#define BODY 0x0F
#define WALL 0xB2
#define FOOD 0x04
#define RED 0x0C
#define YELLOW 0x0E
#define GREEN 0x0A
#define CYAN 0x0B
#define WHITE 0x07
#define UP 0x4800
#define DOWN 0x5000
#define LEFT 0x4B00
#define RIGHT 0x4D00
#define ESC 0x011B
#define RIGHT_BOUND 79
#define BOTTOM_BOUND 24
#define DELAY_TICKS 9
#define MIN_NODES 2
#define MAX_NODES 400
#define MAX_FOOD 32

typedef struct
{
   unsigned char shape, color;
} TILE;  /* a node for maze */

typedef struct
{
   unsigned char shape, color;         /* 节点的字符及颜色 */
   int x, y;                           /* 节点的坐标 */
   unsigned char old_shape, old_color; /* 被节点遮住的原字符及颜色 */
} NODE;  /* a node for snake or food */

unsigned long int seed = 0; /* 随机数种子 */

typedef void interrupt InterruptFunction(void); /* 自定义中断函数类型InterruptFunction */
InterruptFunction *old_8h;  /* old_8h是中断函数指针(宽度跟远指针一样也是32位), 
                               用来保存原int 8h的中断向量 */
int   ticks = 0, stop = 0;  /* ticks用于延时计数, stop用来控制游戏结束 */
TILE  (far *maze)[80] = (TILE (far *)[80])0xB8000000; 
/* maze是数组指针, 它指向一个一维数组, 该一维数组由80个TILE构成;
   maze是一个远指针, 它的值=0xB8000000, 它指向屏幕首行的80个TILE;
   maze[row][col].shape及maze[row][col].color是屏幕坐标(col,row)处的字符及颜色
 */
NODE  snake[MAX_NODES];
NODE  food[MAX_FOOD];
int   snake_nodes = 2; /* The initial snake nodes include HEAD & NECK */
int   food_count = 0;
int   delta[4][2]={{0,-1}, {1,0}, {0,1}, {-1, 0}}; 
/* delta[i][0]表示i方向的x增量, delta[i][1]表示i方向的y增量,
   其中i=0、1、2、3分别表示上、右、下、左四个方向
 */
int   old_direction = 3; /* 初始蛇头朝左 */

void set_rand_seed(void);
unsigned short int get_rand(void);
void clear_screen(void);
void save_char(int x, int y, char *p_shape, char *p_color);
void draw_char(int x, int y, char shape, char color);
void init_maze(int x0, int y0, int x1, int y1);
void init_snake(int x, int y, NODE snake[], int n);
int  available(int x, int y);
void init_food(NODE f[], int n);
int  get_tail_direction(void);
int  target_is_valid(int tx, int ty);
int  move_snake(int tx, int ty);
void my_delay(int t);
void interrupt int_8h(void);

/* 设置随机数发生器的种子值, dword ptr 0:[46Ch]是DOS系统中自开机以来的ticks数 */
void set_rand_seed(void) 
{
   unsigned long int far *pticks;
   pticks = (unsigned long int far *)0x0000046C;
   seed = *pticks; /* seed是全局变量 */
}

/* 产生一个[0, 7FFFh]之间的随机数 */
unsigned short int get_rand(void)
{
   seed = (seed * 0x015A4E35L) + 1;
   return *((unsigned short int *)&seed+1) & 0x7FFF;
}

/* 检测坐标(tx, ty)是否落在墙或蛇身的某一节上 */
int target_is_valid(int tx, int ty)
{
   int i;
   if(tx <=0 || tx >= RIGHT_BOUND || ty <= 0 || ty >= BOTTOM_BOUND)
      return 0; /* 不能撞墙 */
   for(i=0; i<snake_nodes; i++)
   {
      if(tx == snake[i].x && ty == snake[i].y)
         return 0; /* 不能碰到自己的身体 */
   }
   return 1;
}

/* 生成一粒新的食物 */
void new_food(NODE *pf)
{
   int x, y;
   do
   {
      x = 1 + get_rand() % (RIGHT_BOUND-1);
      y = 1 + get_rand() % (BOTTOM_BOUND-1);
   } while(!available(x, y)); /* 循环生成新食物的坐标, 该坐标不能与原食物坐标相重, 
                                 也不可与蛇身任何一节坐标相重
                               */
   pf->x = x; /* 保存食物的x坐标 */
   pf->y = y; /* 保存食物的y坐标 */
   save_char(x, y, &pf->old_shape, &pf->old_color); /* 保存被食物遮住的原字符及颜色 */
   pf->shape = FOOD; /* 设置食物的图像 */
   pf->color = CYAN; /* 设置食物的颜色 */
   draw_char(x, y, pf->shape, pf->color); /* 画一粒食物 */
}

/* 计算蛇的末尾那一节的方向 */
int get_tail_direction(void)
{
   int dx, dy, i;
   dx = snake[snake_nodes-1].x - snake[snake_nodes-2].x;
   dy = snake[snake_nodes-1].y - snake[snake_nodes-2].y;
   for(i=0; i<4; i++)
   {
      if(dx == delta[i][0] && dy == delta[i][1])
         break;
   }
   return i;
}

/* 移动蛇头到坐标(tx, ty)处 */
int move_snake(int tx, int ty)
{
   int i, direction;
   if(!target_is_valid(tx, ty))
   {  /* 撞墙或碰到自身即死 */
      return 0;
   }
   for(i=0; i<food_count; i++)
   {  /* 判断蛇头有没有吃到食物 */
      if(tx == food[i].x && ty == food[i].y)
      {
         draw_char(tx, ty, food[i].old_shape, food[i].old_color); /* remove food */
         new_food(&food[i]); /* 生成一粒新的食物 */
         if(snake_nodes+1 >= MAX_NODES)    /* 若吃撑了 */
            return 0;                      /* 就结束程序 */
         direction = get_tail_direction(); /* 获得蛇尾的方向 */
         snake[snake_nodes].x = snake[snake_nodes-1].x + delta[direction][0];
         snake[snake_nodes].y = snake[snake_nodes-1].y + delta[direction][1];
         /* 蛇身增加1节, 新的这节的方向必须与原蛇尾方向保持一致, 
            即原倒数第2节、原倒数第1节、新的1节必须在一条直线上 */

         save_char(snake[snake_nodes].x, snake[snake_nodes].y, 
         /*=*/ &snake[snake_nodes].old_shape, &snake[snake_nodes].old_color);
         /* 保存被新蛇尾遮住的字符及颜色 */

         snake[snake_nodes].shape = BODY;
         snake[snake_nodes].color = GREEN;
         /* 设置新蛇尾的图像及颜色 */

         snake_nodes++; /* 蛇身节数加1 */
         break;
      }
   }
   for(i=0; i<snake_nodes; i++)
   {  /* remove the snake */
      draw_char(snake[i].x, snake[i].y, snake[i].old_shape, snake[i].old_color);
   }
   for(i=snake_nodes-1; i>=1; i--)
   {  /* 把上一节的坐标、遮住字符及颜色传递给下一节,
         例如当蛇头移动到新坐标(tx,ty)时, 蛇颈会移到原蛇头位置, 蛇身第1节
         会移到原蛇颈位置, 蛇身第2节会移到原第1节位置等等
       */
      snake[i].x = snake[i-1].x;
      snake[i].y = snake[i-1].y;
      snake[i].old_shape = snake[i-1].old_shape;
      snake[i].old_color = snake[i-1].old_color;
   }
   snake[0].x = tx; /* 保存蛇头x坐标 */
   snake[0].y = ty; /* 保存蛇头y坐标 */
   save_char(tx, ty, &snake[0].old_shape, &snake[0].old_color);
   /* 保存被蛇头遮住的字符及颜色 */

   for(i=0; i<snake_nodes; i++) /* 在(tx, ty)坐标处画蛇 */
   {
      draw_char(snake[i].x, snake[i].y, snake[i].shape, snake[i].color);
   }
   my_delay(DELAY_TICKS); /* 精确延时0.5秒 */
   return 1;
}


/* 清屏 */
void clear_screen(void)
{
   _AX=0x0003;          /* 对应的汇编代码为: */
   geninterrupt(0x10);  /* mov ax, 0003h; int 10h */
}

/* 清屏并画围墙 */
void init_maze(int x0, int y0, int x1, int y1)
{
   int x, y;
   clear_screen();
   for(x=x0, y=y0; x<=x1; x++) /* top edge */
   {
      maze[y][x].shape = WALL;
      maze[y][x].color = WHITE;
   }

   for(x=x0, y=y1; x<=x1; x++) /* bottom edge */
   {
      maze[y][x].shape = WALL;
      maze[y][x].color = WHITE;
   }

   for(x=x0, y=y0; y<=y1; y++) /* left edge */
   {
      maze[y][x].shape = WALL;
      maze[y][x].color = WHITE;
   }

   for(x=x1, y=y0; y<=y1; y++) /* right edge */
   {
      maze[y][x].shape = WALL;
      maze[y][x].color = WHITE;
   }
}

/* 初始化蛇, 只有蛇头及蛇颈2节 */ 
void init_snake(int x, int y, NODE s[], int n)
{
   int i;
   for(i=0; i<n; i++)
   {
      s[i].x = x;
      s[i].y = y;
      save_char(x, y, &s[i].old_shape, &s[i].old_color);
      /* 保存被这一节遮住的字符及颜色 */

      if(i == 0) /* head */
      {
         s[i].shape = HEAD;
         s[i].color = RED;
      }
      else if(i == 1) /* neck */
      {
         s[i].shape = NECK;
         s[i].color = YELLOW;
      }
      else
      {
         s[i].shape = BODY;
         s[i].color = GREEN;
      }
      draw_char(x, y, s[i].shape, s[i].color); /* 画这一节 */
      x++; /* 下一节在当前这节的右侧, 故初始方向是左 */
   }
}

/* 检测(x,y)是否与已有的food坐标及snake节点坐标冲突 */
int available(int x, int y)
{
   int i;
   for(i=0; i<food_count; i++)
   {  
      if(x == food[i].x && y == food[i].y)
         return 0;
   }
   for(i=0; i<snake_nodes; i++)
   {
      if(x == snake[i].x && y == snake[i].y)
         return 0;
   }
   return 1;
}

/* 初始化食物 */
void init_food(NODE f[], int n)
{
   int i, x, y;
   for(i=0; i<n; i++)
   {
      food_count = i; /* food_count是全局变量 */
      do
      {
         x = 1 + get_rand() % (RIGHT_BOUND-1);
         y = 1 + get_rand() % (BOTTOM_BOUND-1);
      } while(!available(x, y)); /* 生成有效的食物坐标(x, y), 
                                    食物坐标不可与已有食物坐标相重, 
                                    也不可与蛇身坐标相重
                                  */
      f[i].x = x; /* 保存食物的x坐标 */
      f[i].y = y; /* 保存食物的y坐标 */
      save_char(x, y, &f[i].old_shape, &f[i].old_color);
      /* 保存被食物遮住的字符及颜色 */

      f[i].shape = FOOD; /* 设置食物的图像 */
      f[i].color = CYAN; /* 设置食物的颜色 */ 
      draw_char(x, y, f[i].shape, f[i].color); /* 画食物 */
   }
   food_count = n; /* 更新食物的数量 */
}

/* 在坐标(x,y)处画字符 */
void draw_char(int x, int y, char shape, char color)
{  
   maze[y][x].shape = shape;
   maze[y][x].color = color;
}

/* 把坐标(x,y)处的字符的shape、color保存到*p_shape、*p_color */
void save_char(int x, int y, char *p_shape, char *p_color)
{  
   *p_shape = maze[y][x].shape;
   *p_color = maze[y][x].color;
}

/* 新的int 8h中断 */
void interrupt int_8h(void)
{
   if(ticks != 0)
      --ticks;  /* 每隔1/18秒ticks减1 */
   (*old_8h)(); /* 调用原int 8h中断函数 */
}

/* 延时 */
void my_delay(int t)
{
   ticks = t;
   while(ticks != 0)
      ;
}

main()
{
   int key, i, tx, ty;
   int direction_key[4]={UP, RIGHT, DOWN, LEFT};
   int direction;   /* 0=up, 1=right, 2=down, 3=left */
   set_rand_seed(); /* 设置随机数种子数 */
   init_maze(0, 0, RIGHT_BOUND, BOTTOM_BOUND);
   init_snake(RIGHT_BOUND/2, BOTTOM_BOUND/2, snake, snake_nodes);
   init_food(food, MAX_FOOD);
   old_8h = getvect(8); /* 保存int 8h的中断向量, 
                           汇编语言可以直接读取dword ptr 0:[20h]处的值 
                         */
   setvect(8, int_8h);  /* 修改int 8h的中断向量,
                           汇编语言可以直接修改dword ptr 0:[20h]处的值
                         */
   while(!stop)
   {
      if(bioskey(1)) /* 若键盘缓冲有按键, 则读键并判断方向 */
      {              /* bioskey(1)对应的汇编代码为: mov ah, 1; int 16h */
         key = bioskey(0); /* 读键, 汇编对应代码为: mov ah, 0; int 16h */
         if(key == ESC)
         {
            stop = 1;
            continue;
         }
         for(i=0; i<4; i++) 
         {  /* 判断是否为方向键 */
            if(key == direction_key[i])
               break;
         }
         if(i == 4)                    /* 若不是方向键 */
         {
            direction = old_direction; /* 则蛇的移动将保持原方向 */
         }
         else /* 若是方向键 */
         {
            direction = i;
            tx = snake[0].x + delta[direction][0]; /* 计算该方向的x坐标 */
            ty = snake[0].y + delta[direction][1]; /* 计算该方向的y坐标 */
            if(!target_is_valid(tx, ty))  /* 若该方向不合法(如撞墙或碰到自己) */
            {
	            direction = old_direction; /* 则维持原方向 */
            }
         }
      }
      else /* 若没有按键, 则维持原方向 */
      {
         direction = old_direction;
      }
      tx = snake[0].x + delta[direction][0]; /* 计算该方向的x坐标 */
      ty = snake[0].y + delta[direction][1]; /* 计算该方向的y坐标 */
      old_direction = direction;
      if(!move_snake(tx, ty)) /* 若移动失败如撞墙或碰到自己就结束游戏 */
      {
         stop = 1;
         continue;
      }
   }
   setvect(8, old_8h); /* 恢复int 8h的中断向量 */
   bioskey(0);         /* 等待敲键 */
}
