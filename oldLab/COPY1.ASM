DOSSEG
.MODEL small
.STACK 100h

.DATA
mas1 db 3 dup ("Hi my name is Alexander Velikov!"), 3A0h dup(0) 
mas2 db 90h dup(0)

.CODE
mov AX, @data
mov DS, AX

mov cx, 60h
mov si, offset mas1
mov di, offset mas2

repit_:
mov al,[si]
mov [di],al
inc si
inc di
dec cx
jnz repit_

mov AH, 4Ch
int 21h
END