DOSSEG
.MODEL SMALL
.STACK 100h
.DATA
A DB 5, 3, 9, 4, 5
Length_A   EQU  $ - A
Max DB 0
.CODE
	mov AX, @data
	mov DS, AX

	mov SI, OFFSET A
	mov CX, Length_A-1
	cld
	mov AL, [SI]
	mov Max, AL
L1:					
	inc SI
	mov AL,[SI]
	cmp AL, Max
	jbe L2
	mov Max, AL
L2:	
	loop L1	

mov AH,4Ch			;выход
int 21h				;из программы
	
END	
