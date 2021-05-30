mov ah, 0x0e ; tty mode on the xh register (higher part of ax register)
mov al, 'H' ; Put H on the al register (lower part of ax register)
int 0x10 ; raise general interrupt for video services
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10
mov al, 'o'
int 0x10

jmp $ ; jump to current address - infinite loop

; Padding
times 510-($-$$) db 0
; Magic number that tells the BIOS the disk is bootable
dw 0xaa55
