DOSSEG
.MODEL TINY

.CODE
ORG 100h

Start: JMP BEGIN

HELLOMSG DB 'HELLO, WORLD!$'
REVERSMSG DB 0Dh dup(0), '$'
HELPMSG DB 'Wirte HELLO, WORLD!$'
KEYMASG DB '/h - get help',0Ah,0Dh,'/f - forward output',0Ah,0Dh,'/r - revers output$'
ERRMSG DB '*ERROR* incorrect agrs, run without args to get info about programm.$'

BEGIN:
	MOV DX, offset KEYMASG
	CMP BYTE PTR ES:[80h],0
	JZ OUTPUT
	CMP BYTE PTR ES:[82h],'/'
	JNZ ERR1
	CMP BYTE PTR ES:[83h],'f'
	JZ FORWARD
	CMP BYTE PTR ES:[83h],'r'
	JZ REVERS
	CMP BYTE PTR ES:[83h],'h'
	JZ HELP
	JMP ERR1

FORWARD:
	MOV DX, offset HELLOMSG
	JMP OUTPUT

REVERS:
	MOV DX, offset REVERSMSG
	
	MOV CX, 0Dh
	MOV SI, offset HELLOMSG
	ADD SI, 0Ch
	MOV DI, offset REVERSMSG
	
	_WHILE:
		MOV AL, [SI]
		MOV [DI], AL
		DEC SI
		INC DI
		DEC CX
		JNZ _WHILE
	JMP OUTPUT

HELP:
	MOV DX, offset HELPMSG
	JMP OUTPUT
	
ERR1:
	MOV DX, offset ERRMSG

OUTPUT:
	MOV AH, 9
	INT 21h
	INT 20h

END Start