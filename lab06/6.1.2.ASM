﻿; Дана матрица. Обнулить все элементы, лежащие ниже главной диагонали включительно.
%TITLE ""
INCLUDE IO.ASM

MODEL   small

ST1 SEGMENT                     ; Stack segment desc ;
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
	arr DW 256 DUP(?)
	N DW ?
	i DW ?
DATA ENDS


CODE    SEGMENT                 ; Code segment opened ;
ASSUME  SS:ST1,DS:DATA,CS:CODE  ; Registry segments assignment ;
EXTRN   fib:near


Start:
    PUSH    ds
    PUSH    ax
    MOV     ax, data    
    MOV     ds, ax
;========== Put your code below =========================

;========== ВВОД МАТРИЦЫ ==========
	ININT N
	MOV CX, N
	MOV BX, 0

A1:
	PUSH CX
	MOV CX, N
	MOV SI, 0	; Регистр, отвечаюий за столбцы

A2:
	ININT arr[BX][SI]
	ADD SI, 2
	LOOP	A2

	ADD BX, N
	ADD BX, N
	POP CX
	LOOP	A1
	
;========== Обнуление элементов ниже главной диагонали включительно ==========
	MOV BX, 0
	MOV CX, N
	MOV i, 1

A3:
	PUSH CX
    MOV CX, i
	MOV SI, 0

A4:
	MOV arr[BX][SI], 0
	ADD SI, 2
	LOOP	A4

	INC i
	ADD BX, N
	ADD BX, N
	POP	CX
	LOOP A3
;========== ВЫВОД МАТРИЦЫ ==========

	MOV CX, N
	MOV BX, 0

A5:
	PUSH CX
	MOV CX, N
	MOV SI, 0

A6:
	OUTINT arr[BX][SI], 4
	ADD SI, 2
	LOOP	A6
	
	NEWLINE
	ADD BX, N
	ADD BX, N
	POP CX
	LOOP	A5
;========== End of your code block ======================
    POP     ax
    POP     ds
Exit:
    finish
ENDS

END Start