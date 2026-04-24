#pragma once
#include "multiboot.h"

extern uint32_t initial_page_dir[1024];
#define kernel_start 0xC0000000
#define page_flag_present (1 << 0)
#define page_flag_wrote (1 << 1)
void initMemory(uint32_t memHigh, uint32_t physicalAllocStart);
void pmm_init(uint32_t memLow, uint32_t memHigh);
void invalidate(uint32_t vaddr);