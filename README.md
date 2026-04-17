# OS-v2

## Requirements

- nasm
- qemu-system-i386

## Build

```bash
gcc -m32 -fno-stack-protector -fno-builtin -c kernel.c -o kernel.o
nasm -f elf32 boot.asm -o boot.o
ld -m elf_i386 -T linker.ld -o kernel boot.o kernel.o
mv kernel os/boot/kernel
grub-mkrescue -o os.iso os/
```

## Run

```bash
./run.sh
```
