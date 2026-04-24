#include "memory.h"
#include "multiboot.h"
#include "stdlib/stdio.h"
#include "util.h"

static uint32_t pageFrameMin;
static uint32_t pageFrameMax;
static uint32_t totalAlloc;

#define num_page_dirs 256
#define num_page_frames (0x100000000 / 0x1000 / 8)
uint8_t physicalMemoryBitmap[num_page_frames / 8];

static uint32_t pageDirs[num_page_dirs][1024] __attribute__((aligned(4096)));
static uint8_t pageDirUsed[num_page_dirs];

void pmm_init(uint32_t memLow, uint32_t memHigh) {
  pageFrameMin = CEIL_DIV(memLow, 0x1000);
  pageFrameMax = memHigh / 0x1000;
  totalAlloc = 0;

  memset(physicalMemoryBitmap, 0, sizeof(physicalMemoryBitmap));
}

void initMemory(uint32_t memHigh, uint32_t physicalAllocStart) {
  initial_page_dir[0] = 0;
  invalidate(0);
  initial_page_dir[1023] = ((uint32_t)initial_page_dir - kernel_start) |
                           page_flag_present | page_flag_wrote;
  invalidate(0xFFFFF000);
  pmm_init(physicalAllocStart, memHigh);

  memset(pageDirs, 0, 0x1000 * num_page_dirs);
  memset(pageDirUsed, 0, num_page_dirs);
}

void invalidate(uint32_t vaddr) { asm volatile("invlpg %0" ::"m"(vaddr)); }