print:
	pusha

; print until the null byte
start:
 	mov al, [bx] ; 'bx' - base address for the string
 	cmp al, 0
 	je done

 	; print with the bios help
 	mov ah, 0x0e
 	int 0x10 ; al contains the char already
 	
 	; increment the pointer
 	add bx, 1

 	; do the next loop
 	jmp start

 done:
 	popa
 	ret

 new_line:
 	pusha
 	mov ah, 0x0e
 	mov al, 0x0a ; new line char
 	int 0x10
 	mov al, 0x0d ; return carry
 	int 0x10

 	popa
 	ret
