DATAS SEGMENT
DATAS ENDS

STACKS SEGMENT
STACKS ENDS

CODES SEGMENT
	ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
	MOV DX,06C6H
	MOV AL,00010000B;
	OUT DX,AL
	MOV DX,06C0H
	MOV AL,05H
	OUT DX,AL
CODES ENDS
	END START