gcc = /usr/opt/cross/bin/i686-elf-gcc
ld = /usr/opt/cross/bin/i686-elf-ld
cflags = -ffreestanding -std=gnu17 -Wall -Wextra -g -O2

all: clean kernel boot image

clean:
	rm -rf *.o

kernel:
	$(gcc) $(cflags) -c src/kernel.c -o kernel.o
	$(gcc) $(cflags) -c src/vga.c -o vga.o
	$(gcc) $(cflags) -c src/gdt.c -o gdt.o
	$(gcc) $(cflags) -c src/util.c -o util.o
	$(gcc) $(cflags) -c src/interrupts/idt.c -o idt.o
	$(gcc) $(cflags) -c src/timer.c -o timer.o
	$(gcc) $(cflags) -c src/stdlib/stdio.c -o stdio.o

boot:
	nasm -f elf32 src/boot.asm -o boot.o
	nasm -f elf32 src/gdt.asm -o gdt_asm.o
	nasm -f elf32 src/interrupts/idt.asm -o idt_asm.o

image:
	$(ld) -m elf_i386 -T linker.ld -o kernel \
		boot.o \
		kernel.o \
		vga.o \
		gdt.o \
		gdt_asm.o \
		util.o \
		idt.o \
		idt_asm.o \
		timer.o \
		stdio.o
	mv kernel os/boot/kernel
	grub-mkrescue -o os.iso os/
	rm *.o