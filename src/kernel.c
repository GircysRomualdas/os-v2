#include "gdt/gdt.h"
#include "interrupts/idt.h"
#include "keyboard.h"
#include "kmalloc.h"
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

  uint32_t mod1 = *(uint32_t *)(bootInfo->mods_addr + 4);
  uint32_t physicalAllocStart = (mod1 + 0xFFF) & ~0xFFF;
  initMemory(bootInfo->mem_upper * 1024, physicalAllocStart);
  kmallocInit(0x1000);
  print("Memory allocation done!");

  for (;;)
    ;
}