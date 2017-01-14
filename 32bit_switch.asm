; To jump into 32-bit mode:

; Disable interrupts
; Load our GDT
; Set a bit on the CPU control register cr0
; Flush the CPU pipeline by issuing a carefully crafted far jump
; Update all the segment registers
; Update the stack
; Call to a well-known label which contains the first useful code in 32 bits

[bits 16]
switch_to_pm:
    cli 	; disable interrupts
    lgdt [gdt_descriptor] ; load the GDT descriptor
    mov eax, cr0
    or eax, 0x1 ; set 32-bit mode bit in cr0
    mov cr0, eax
    jmp CODE_SEG:init_pm ; far jump 

[bits 32]
init_pm:
    mov ax, DATA_SEG ; update the segment registers
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000 ; update the stack to be at the top of the free space
    mov esp, ebp

    call BEGIN_PM 