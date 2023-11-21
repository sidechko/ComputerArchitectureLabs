DOSSEG
.MODEL SMALL
.STACK 100h
.DATA
A DB 102, -65, 126, 75, -80, -80, -94, 97, -104, 115, 33, -27, -80, -53, -7
B DB 101, -9, 81, 2, -114, 9, 117, -100, -1, 97, 3, 32, -84, -26, 103, 120
C_arr DB -40, 13, -95, 1, -42, -24, 7, 65, -24, -88, 57, -106, -36, 62, 105, 109
Length_Arrs EQU  $ - C_arr ;от текущего адреса отнимаем адрес переменной C. Все длинны массивов равны
Max DB 80h
.CODE
	mov AX, @data
	mov DS, AX
	MOV DX, 0
	
BIND_A:
	mov SI, OFFSET A
	INC DX
	jmp FIRST_BIND
BIND_B:
	mov SI, OFFSET B
	INC DX
	jmp FIRST_BIND
BIND_C:
	mov SI, OFFSET C_arr
	INC DX
	jmp FIRST_BIND

FIRST_BIND:
	mov Max, 80h	; Обнуление Max до минимального знакового значения.
	mov CX, Length_Arrs
	dec CX
	cld
	mov AL, [SI]
	mov Max, AL
	
CHECK_NEXT:					
	inc SI
	mov AL,[SI]
	cmp Max, AL
	jg SKIP_BIND	; так как операнды у нас знаковые, требуется проверять знак, jg подходит 
	; проверяет одновременно два условия SF == OF и ZF == 0 (оба условия должны быть истинными). 
	; Выполняет переход, если первый операнд больше второго. Оба операнда со знаком.
	mov Max, AL		; Бинд максимума
SKIP_BIND:
	loop CHECK_NEXT

mov CX, 0
mov CL, Max			;Сохраняем значение для максимума
push CX

cmp DX, 1
je BIND_B
cmp DX, 2
je BIND_C

mov AH,4Ch			;выход
int 21h				;из программы
	
END	
