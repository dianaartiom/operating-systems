[bits 32]
[extern main]	; Define kernel point - should be the same as kernel.c main fun
call main	; calls the c fun
jmp $
