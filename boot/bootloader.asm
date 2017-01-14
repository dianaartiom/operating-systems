[org 0x7c00] ; the offset is the bootsector code
KERNEL_OFFSET equ 0x1000	;	same was used when linking the kernel
	
	mov [BOOT_DRIVE], dl	;	BIOS sets the boot drive in 'dl' on boot
	mov bp, 0x9000
	mov sp, bp

	mov bx, MSG_REAL_MODE 
    call print
    call new_line

    call load_kernel	;	read the kernel from disk
    call switch_to_pm
    jmp $


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
%include "disk.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print
    call new_line

    mov bx, KERNEL_OFFSET ; Read from disk and store in 0x1000
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    call KERNEL_OFFSET ; Give control to the kernel
    jmp $


BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0

;	bootsector
times 510-($-$$) db 0
dw 0xaa55