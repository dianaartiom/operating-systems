; The OS won't fit inside the bootsector 512bytes, so we need to read data from a disk in order to run the kernel

disk_load:
	pusha

	; configure values in all registers
	; save the stack for later use
	push dx

    mov ah, 0x02
    mov al, dh  
    mov cl, 0x02
    mov ch, 0x00
    mov dh, 0x00
    int 0x13     
    jc disk_error

    pop dx
    cmp al, dh
    jne sectors_error
    popa
    ret


disk_error:
    mov bx, DISK_ERROR
    call print
    call new_line
    mov dh, ah
    call print_hex
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print

disk_loop:
    jmp $

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0