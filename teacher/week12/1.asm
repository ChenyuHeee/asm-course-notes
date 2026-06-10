1. 中断(interrupt)
中断分成软件中断和硬件中断
像int 21h这种由程序员发起的，指令本身真实存在于
内存空间的中断称为软件中断;
硬件中断是指由外部事件触发的，由CPU发起的，指令本身
不存在于内存空间的中断，比如int 8h时钟中断以及int 9h
键盘中断就是硬件中断。
mov ax, 0; 假定这条指令消耗了1/18秒
;cpu会此处插入并调用int 8h指令, 同样, 这条指令不在内存中
mov bx, 1
again:
add ax, bx
;用户敲击某个键
;cpu会在此处插入并调用int 9h指令, 但这条指令不在内存中
cmp ax, 100
jb again


2. int指令和iret指令
mov ah, 2
mov dl, 'A'
int 21h; 当cpu执行int 21h指令时会做以下操作
       ; ①pushf ; 把标志寄存器FL压入堆栈, 可理解为push fl
       ; ②push cs
       ; ③push offset back
       ; ④jmp dword ptr 0:[84h] 
       ; int n的目标地址一定保存在dword ptr 0:[n*4]中,
       ; dword ptr 0:[n*4]称为int n的中断向量
back:
mov ah, 4Ch
mov al, 0
int 21h


int_21h: ; 设offset int_21h已保存到word ptr 0:[84h]中
         ; 且seg int_21h已保存到word ptr 0:[86h]中
         
...
iret ; iret是中断返回指令(interrupt return)
     ; cpu在执行iret时会做以下操作:
     ; ①pop ip
     ; ②pop cs
     ; ③popf
     