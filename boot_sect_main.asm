[org 0x7c00] ; Segmentation
  mov bp, 0x8000 ; set base pointer
  mov sp, bp ; set stack pointer (from base pointer), away from us

  mov bx, 0x9000; set bx register to 0x9000
  mov dh, 2 ; we want to read 2 sectors
  ; the BIOS uses the lower half of the register, 'dl', for our boot disk number
  call disk_load

  mov dx, [0x9000] ; retrieve first word from first loaded sector, at 0xdada
  call print_hex

  call print_nl

  mov dx, [0x9000 + 512] ; retrieve first word from second loaded sector (each sector is 512), at 0xface
  call print_hex

  jmp $

%include "boot_sect_print.asm"
%include "boot_sect_print_hex.asm"
%include "boot_sect_disk.asm"

; Padding
times 510-($-$$) db 0
; Magic number that tells the BIOS the disk is bootable
dw 0xaa55

; boot sector: sector 1 of cylinder 0 of head 0 or hdd 0
times 256 dw 0xdada ;sector 2!
times 256 dw 0xface ;sector 3!

