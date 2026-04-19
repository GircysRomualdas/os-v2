cflags = -m32 -fno-stack-protector -fno-builtin

all: clean kernel boot image

clean:
	rm -rf *.o

kernel:
	gcc $(cflags) -c kernel.c -o kernel.o
	gcc $(cflags) -c vga.c -o vga.o
	gcc $(cflags) -c gdt.c -o gdt.o
	gcc $(cflags) -c util.c -o util.o

boot:
	nasm -f elf32 boot.asm -o boot.o
	nasm -f elf32 gdt.asm -o gdt_asm.o

image:
	ld -m elf_i386 -T linker.ld -o kernel \
		boot.o \
		kernel.o \
		vga.o \
		gdt.o \
		gdt_asm.o \
		util.o
	mv kernel os/boot/kernel
	grub-mkrescue -o os.iso os/
	rm *.o