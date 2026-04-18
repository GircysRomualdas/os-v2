all: clean kernel boot image

clean:
	rm -rf *.o

kernel:
	gcc -g -m32 -fno-stack-protector -fno-builtin -c kernel.c -o kernel.o
	gcc -g -m32 -fno-stack-protector -fno-builtin -c vga.c -o vga.o
	gcc -g -m32 -fno-stack-protector -fno-builtin -c gdt.c -o gdt.o

boot:
	nasm -f elf32 boot.asm -o boot.o
	nasm -f elf32 gdt.asm -o gdt_asm.o

image:
	ld -m elf_i386 -T linker.ld -o kernel boot.o kernel.o vga.o gdt.o gdt_asm.o
	mv kernel os/boot/kernel
	grub-mkrescue -o os.iso os/
	rm *.o