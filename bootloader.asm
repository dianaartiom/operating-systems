[org 0x7c00] ; the offset is the bootsector code

mov bx, HELLO
call print

call new_line

mov bx, ADIOS
call print

call new_line

mov dx, 0x12af
call print_hex

jmp $

%include "print.asm"
%include "print_hex.asm"

; Data
HELLO:
	db "Hello!"	, 0

ADIOS:
	db "Adios", 0

times 510-($-$$) db 0
dw 0xaa55