DOSSEG
.MODEL SMALL
.STACK 100h
.DATA
Arr DB 90,82,127,-91,34,76,	61,-75,-43,-119,-66,-6,-26,-20,95,-63,106,30,58,-120
Length_A   EQU  $ - Arr
List DB Length_A dup(0)
.CODE
	mov AX, @data
	mov DS, AX

	mov SI, OFFSET Arr		; Save Arr offset
	mov BX, OFFSET List		; Save List offset
	mov CX, Length_A		; Change CX for loop
	mov AL, [SI]			; First input
	
	cmp AL, 0				; First check
	jg SKIP_INSERT_TO_LIST

CHECK:
	inc SI
	mov AL,[SI]				; Write next num to AL
	cmp AL, 0
	jg SKIP_INSERT_TO_LIST

	inc DX					; Upd counter
	mov [BX], AL			; write num to List
	inc BX					; next pointer for List
	
SKIP_INSERT_TO_LIST:	
	loop CHECK	

mov AH,4Ch			;выход
int 21h				;из программы
	
END	
