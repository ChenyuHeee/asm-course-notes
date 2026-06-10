push、pop的语法：
push 一个16位的寄存器或16位的变量
push 一个32位的寄存器或32位的变量
pop  一个16位的寄存器或16位的变量
pop  一个32位的寄存器或32位的变量

push、pop的原理:      
设堆栈指针sp=0x1000 
mov ax, 1234h
mov bx, 5678h
push ax ; CPU在执行此指令时会做以下步骤:
        ;   sp = sp - 2 = 0x0FFE
        ;   *sp = ax
  +0FFE  34h  ;1234h必须按小端规则保存到堆栈中
  +0FFF  12h  ;小端规则(little-endian)是指宽度大于8位的值保存
  +1000       ;到内存中时必须把低8位保存到低地址处，
              ;高8位保存到高地址处

push bx ; CPU在执行此指令时会做以下步骤: 
        ;   sp = sp - 2 = 0x0FFC         
        ;   *sp = bx    
  +0FFC  78h
  +0FFD  56h
  +0FFE  34h  ;1234h必须按小端规则保存到堆栈中
  +0FFF  12h  ;小端规则(little-endian)是指宽度大于8位的值保存
  +1000       ;到内存中时必须把低8位保存到低地址处，
              ;高8位保存到高地址处

设堆栈指针sp=0x1000 
mov eax, 12345678h
mov ebx, 89ABCDEFh 
push eax      ; ①sp=sp-4=0FFCh ②*sp=eax
  +0FFC  78h  ;12345678h必须按小端规则保存到堆栈中               
  +0FFD  56h  ;小端规则(little-endian)是指宽度大于8位的值保存
  +0FFE  34h  ;到内存中时必须把低8位保存到低地址处，         
  +0FFF  12h  ;高8位保存到高地址处                           
  +1000       
              
push ebx       ; ①sp=sp-4=0FF8h ②*sp=ebx
  +0FF8  0EFh  ;89ABCDEFh必须按小端规则保存到堆栈中               
  +0FF9  0CDh  ;小端规则(little-endian)是指宽度大于8位的值保存
  +0FFA  0ABh  ;到内存中时必须把低8位保存到低地址处，         
  +0FFB  89h   ;高8位保存到高地址处                           
  +0FFC  78h
  +0FFD  56h
  +0FFE  34h  
  +0FFF  12h  
  +1000       
              

pop ebx       ; ①ebx = *sp; ②sp=sp+4=0FFCh
  +0FF8  0EFh ; pop ebx前sp=0FF8h
  +0FF9  0CDh
  +0FFA  0ABh
  +0FFB  89h
  +0FFC  78h  ; pop ebx后sp=0FFCh
  +0FFD  56h
  +0FFE  34h  
  +0FFF  12h  
  +1000       
              
pop eax       ; ①eax=*sp; sp=sp+4=1000h
  +0FFC  78h  ; pop eax前sp=0FFCh
  +0FFD  56h
  +0FFE  34h  
  +0FFF  12h  
  +1000       ; pop eax后sp=1000h
              
