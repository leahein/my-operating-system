[bits 16]
switch_to_pm: ; 32 bit protected mode
    cli; 1. disable all interrupts, we'll need to handle those on our own with the GDT
    lgdt [gdt_descriptor] ; 2. load the GDT Descriptor
    mov eax, cr0 ; set a bit on cr0 (control register 0)
    or eax, 0x1; 3. set 32 bit mode bit in cr0
    mov cr0, eax
    jmp CODE_SEG:init_pm ; 4. far jump: jump to a different segment

[bits 32]
init_pm: ; we are now using 32 bit instructions
  mov ax, DATA_SEG ; 5. update ax register, use to update all segment registers
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  mov ebp, 0x90000 ; 6. update the stack at the top of the free space
  mov esp, ebp

  call BEGIN_PM ; Entry point for our kernel code (finally!)
