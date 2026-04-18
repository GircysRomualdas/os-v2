#! /bin/bash
set -e

qemu-system-i386 os.iso

# debug
# qemu-system-i386 -s -S os.iso

# gdb os/boot/kernel
# target remote :1234