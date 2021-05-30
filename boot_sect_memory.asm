; [org 0x7c00] offset for where the bootsector is loaded into memory
mov ah, 0x0e ; tty mode on the ah register (higher part of ax register)


mov bx, the_secret; use a different register since source, destination can't be the same
add bx, 0x7c00 ; where the bootsector is loaded into memory
mov al, [bx] # dereference the pointer
int 0x10

jmp $ ; jump to current address - infinite loop

the_secret:
  db "X"

; Padding
times 510-($-$$) db 0
; Magic number that tells the BIOS the disk is bootable
dw 0xaa55
