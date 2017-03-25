DATAS SEGMENT
COUNT	EQU	50
BUFFER	DB	COUNT	DUP(?)
DATAS ENDS

STACKS SEGMENT

STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX

	NOP;	input
	MOV DI,OFFSET BUFFER
	MOV CX,COUNT
INPUT:
	MOV ah,01h
	INT 21H
	MOV [DI],AL
	INC DI
	LOOP INPUT
	
	NOP;	sort
	MOV DI, OFFSET BUFFER


	MOV CX,COUNT
SORT:
	MOV SI, OFFSET BUFFER
	MOV AL,[DI]
	push CX
	MOV CX,COUNT
NEXT:
	CMP [SI],al
	JNA CHANG
	XCHG AL,[SI]
CHANG:
	INC SI
	LOOP NEXT
	pop CX
	MOV [DI],AL
	INC DI
	LOOP SORT
	

	NOP;	output
	MOV DL,dh
	MOV ah,02h
	int 21h
	
	MOV DI, OFFSET BUFFER
	MOV CX,COUNT
OUTPUT:
	MOV DL,[DI]
	MOV ah,02h
	INT 21H
	INC DI
	LOOP OUTPUT
	
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START