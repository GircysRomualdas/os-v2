BITS 32

section .text
  align 4
  dd 0x1badb002
  dd 0x00000003
  dd -(0x1BADB002 + 0x00000003)

global start
extern kmain

start:
  cli
  mov esp, stack_space
  call kmain
  hlt

halt:
  cli
  hlt
  jmp halt

section .bss
RESB 8192
stack_space:
