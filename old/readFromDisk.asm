READ_DISK:
    mov ah, 0x02

    mov al, dh

    mov ch, 0x00
    mov dh, 0x00
    mov cl, 0x02

    mov dl, [BOOT_DISK]
    int 0x13

    jc DISK_ERROR

    cmp ah, 0
    jne DISK_ERROR

    mov bx, ax
    call PRINT_DECIMAL

    jmp AFTER_DISK_READ
    ret

DISK_ERROR:
    push ax
    mov bx, DISK_ERROR_MESSAGE

    call PrintString
    pop ax
    mov bh, ah
    call PRINT_DECIMAL
    jmp $

SECTOR_ERROR:
    mov bx, SECTOR_ERROR_MESSAGE
    call PrintString
    jmp $

BOOT_DISK: db 0

DISK_ERROR_MESSAGE:
    db "Disk Error!", 10, 13, 0

SECTOR_ERROR_MESSAGE:
    db "Sector Error!", 10, 13, 0