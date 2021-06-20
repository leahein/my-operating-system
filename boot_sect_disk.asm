; Goal: Read data from disk (our kernel, eventually)
; We want to load the 'dh' sectors, from drive 'dl' into ES:BX registers
disk_load:
  pusha ; push all registers onto the stack
  ; reading from disk requires setting specific values in all registers. So as
  ; not to lose and parameters from the dx register, we push it onto the stack first.
  push dx

  mov ah, 0x02 ; 0x02 = read
  mov al, dh ; this specifies the number of sectors to read
  mov cl, 0x02 ; 0x02 is the first available sector, since 0x01 is our boot sector (sectors start at 1)
  mov ch, 0x00 ; ?
  mov dh, 0x00 ; head number

  ; do our BIOS interrupt! int13: https://en.wikipedia.org/wiki/INT_13H
  ; we tell it to read from disk
  int 0x13 ; BIOS interrupt
  jc disk_error ; jump if there is a carry bit, errors are stored in there

  pop dx ; pop from the dx register
  cmp al, dh ; 'al' register stores the # of sectors read
  jne sectors_error
  popa ; finally, pop all from the stack
  ret

; Errors
disk_error:
    mov bx, DISK_ERROR
    call print
    call print_nl
    mov dh, ah ; ah = error code, dl = disk drive that dropped the error
    call print_hex
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print

disk_loop:
    jmp $

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0
