[org 0x7c00] ; the offset is the bootsector code

    mov bp, 0x9000 ; set the stack
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print ; will be written after the BIOS messages

    call switch_to_pm
    jmp $ 

%include "print.asm"
%include "print_hex.asm"
%include "32bit_print.asm"
%include "32bit_switch.asm"
%include "32bit_gdt.asm"


[bits 32]
BEGIN_PM: ; after the switch
    mov ebx, MSG_PROT_MODE
    call print_string_pm 
    jmp $

MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0

;	bootsector
times 510-($-$$) db 0
dw 0xaa55