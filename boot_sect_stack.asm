mov ah, 0x0e ; tty mode

mov bp, 0x8000 ; address far away from 0x7c00, where the bootsector is loaded, so we don't get overwritten
mov sp, bp ; move the base pointer register onto the stack pointer register

push 'A'
push 'B'
push 'C'

mov al, [0x7ffc] ; 0x8000 - 2
int 0x10 ; raise interrupt for video services

; mov al, [0x8000] ; we can't access this, it's not the top of the stack
; int 0x10

pop bx
mov al, bl ; move lower part of the bx register onto al (we only want the character 'C', not the higher 0)
int 0x10; print C by raising interrupt to video services

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

; Remove all data that hasn't been popped from the stack yet
mov al, [0x8000]
int 0x10

jmp $
times 510-($-$$) db 0
dw 0xaa55
