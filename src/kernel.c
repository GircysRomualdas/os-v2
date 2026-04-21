#include "gdt/gdt.h"
#include "interrupts/idt.h"
#include "keyboard.h"
#include "memory.h"
#include "multiboot.h"
#include "timer.h"
#include "vga.h"

void kmain(uint32_t magic, struct multiboot_info *bootInfo);

void kmain(uint32_t magic, struct multiboot_info *bootInfo) {
  initGdt();
  print("GDT is done!\r\n");
  initIdt();
  initTimer();
  initKeyboard();
  initMemory(bootInfo);

  for (;;)
    ;
}