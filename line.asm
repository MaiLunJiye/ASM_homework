DATAS SEGMENT
	;此处输入数据段代码
DATAS ENDS
STACKS SEGMENT
	;此处输入堆栈段代码
STACKS ENDS
CODES SEGMENT
	ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
	MOV AX,DATAS
	MOV DS,AX
	mov ah,0
	mov al,13
	int 10h; 创建画布
	mov ah,0bh
	mov bh,0
	mov bl,9
	int 10h; 画布背景色
	mov ah,0CH
	mov bh,0
	mov al,6
	mov cx,20
	mov dx,20 ;把不用改变的量放到循环体外面
next1:
	int 10H; 上边
  inc cx ;X坐标+1
	cmp cx,100
	jnz next1 ;CX不为320就继续循环
next2:
	int 10H；	
  inc DX
	cmp dx,100
	jnz next2
next3:
	int 10H
	dec cx
	cmp cx,20
	jnz next3
next4:
	int 10H
	dec dx
	cmp dx,20
	jnz next4
EXIT:
	MOV AH,07H
	INT 21H
	MOV AH,4CH
	INT 21H
	CODES ENDS
	END START
