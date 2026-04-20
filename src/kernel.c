#include "gdt.h"
#include "interrupts/idt.h"
#include "timer.h"
#include "vga.h"

void kmain(void);

void kmain(void) {
  initGdt();
  print("GDT is done!\r\n");
  initIdt();
  initTimer();

  for (;;)
    ;
}