; Credits
; Information about operating system start - https://youtube.com/playlist?list=PLm3B56ql_akNcvH8vvJRYOc7TbYhRs19M
; Grub implementation - https://wiki.osdev.org/GRUB
; Information about creating Operating Systems - https://wiki.osdev.org
; Keyboard Scancodes - https://www.win.tue.nl/~aeb/linux/kbd/scancodes-1.html
; Intel 64x and ia 32x architectures programming guide - https://software.intel.com/content/www/us/en/develop/download/intel-64-and-ia-32-architectures-sdm-combined-volumes-3a-3b-3c-and-3d-system-programming-guide.html

[org 0x7c00]


KERNEL_LOCATION equ 0x1000


mov [BOOT_DISK], dl


xor ax, ax
mov es, ax
mov ds, ax
mov bp, 0x8000
mov sp, bp

mov bx, KERNEL_LOCATION
mov dh, 2

mov ah, 0x02
mov al, dh
mov ch, 0x00
mov dh, 0x00
mov cl, 0x02
mov dl, [BOOT_DISK]
int 0x13 ; TODO: Error management!


mov ah, 0x0
mov al, 0x3
int 0x10

cli
lgdt [GDT_DESCRIPTOR]
mov eax, cr0
or eax, 1
mov cr0, eax
jmp CODE_SEG:start_protected_mode

jmp $

BOOT_DISK: db 0

%include "Bootloader/gdt.asm"

[bits 32]
start_protected_mode:
    mov ax, DATA_SEG
	    mov ds, ax
	    mov ss, ax
	    mov es, ax
	    mov fs, ax
	    mov gs, ax

	    mov ebp, 0x90000
	    mov esp, ebp

    jmp KERNEL_LOCATION


; Before Before ;

;mov ah, 0x0e
;mov bx, printedString
;printString:
    ;mov al, [bx]
    ;cmp al, 0
    ;je end
    ;int 0x10
    ;inc bx
    ;jmp printString
;end:
;jmp $
;printedString:
    ;db "Hello there!", 0


; Before ;

;KERNEL_LOCATION equ 0x1000

;mov [BOOT_DISK], dl

;mov bx, OK
;call PrintString

;xor ax, ax
;mov es, ax
;mov ds, ax
;mov bp, 0x8000
;mov sp, bp

;mov bx, KERNEL_LOCATION
;mov dh, 50

;call READ_DISK


;AFTER_DISK_READ:

;mov bx, NL
;call PrintString
;mov bx, NL
;call PrintString

;call GET_MEMORY_MAP


;mov ah, 0x0
;mov al, 0x3
;int 0x10

;call GraphicMode ;(later i guess)

;call switchToPM

        ;jmp $

;ERROR:
    ;mov bx, ERROR_MSG
    ;call PrintString
    ;jmp $

;GraphicMode:
    ;mov ah, 0
    ;mov al, 0x13
    ;int 10h
    ;ret

;%include "printString.asm"
;%include "readFromDisk.asm"
;%include "printDecimal.asm"
;%include "availableMemory.asm"
;%include "gdt_old.asm"

;%include "protectedMode.asm"

;OK:
    ;db 'Ok', 10, 13, 0

;NL:
    ;db 10, 13, 0

;ERROR_MSG:
    ;db 10, 13, 'Error', 10, 13, 0

;Extended_Memory_Size: db 0, 0

;[bits 32]

;BEGIN_PM:
    ;mov bx, [Extended_Memory_Size]
        ;jmp KERNEL_LOCATION


times 510-($-$$) db 0
dw 0xaa55