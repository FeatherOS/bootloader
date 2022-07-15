PRINT_DECIMAL:
    mov dx, 0
        mov ax, bx
        mov bx, 10000
        div bx
        mov ah, 0
        call PRINT_DIGIT
        mov bx, dx
    mov dx, 0
        mov ax, bx
        mov bx, 1000
        div bx
        mov ah, 0
        call PRINT_DIGIT
        mov bx, dx
        mov dx, 0
        mov ax, bx
        mov bx, 100
        div bx
        mov ah, 0
        call PRINT_DIGIT
        mov bx, dx
        mov dx, 0
        mov ax, bx
        mov bx, 10
        div bx
        mov ah, 0
        call PRINT_DIGIT
        mov ax, dx
        mov ah, 0
        call PRINT_DIGIT
        ret
PRINT_DIGIT:
    mov ah, 0x0e
    add al, 48
    int 0x10
    ret