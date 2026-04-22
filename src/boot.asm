mboot_page_align equ 1 << 0
mboot_mem_info equ 1 << 1
mboot_use_gfx equ 0

mboot_magic equ 0x1badb002
mboot_flags equ mboot_page_align | mboot_mem_info | mboot_use_gfx
mboot_checksum equ -(mboot_magic + mboot_flags)

section .multiboot
align 4
  dd mboot_magic
  dd mboot_flags
  dd mboot_checksum
  dd 0, 0, 0, 0, 0

  dd 0
  dd 800
  dd 600
  dd 32

section .bss
align 16
stack_bottom:
  resb 16384 * 8
stack_top:

section .boot

global _start
_start:
  mov ecx, (initial_page_dir - 0xC0000000)
  mov cr3, ecx

  mov ecx, cr4
  or ecx, 0x10
  mov cr4, ecx

  mov ecx, cr0
  or ecx, 0x80000000
  mov cr0, ecx

  jmp higher_half

section .text
higher_half:
  mov esp, stack_top
  push ebx
  xor ebp, ebp
  extern kmain
  call kmain

halt:
  hlt
  jmp halt

section .data
align 4096
global initial_page_dir
initial_page_dir:
  dd 10000011b
  times 768-1 dd 0

  dd (0 << 22) | 10000011b
  dd (1 << 22) | 10000011b
  dd (2 << 22) | 10000011b
  dd (3 << 22) | 10000011b
  times 256-4 dd 0