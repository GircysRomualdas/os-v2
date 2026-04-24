# OS-v2

32-bit x86 operating system

## Requirements

- Bochs

```bash
cd ~/Downloads
tar -xvf bochs-2.8.tar.gz
sudo apt-get update
sudo apt-get install bochs bochs-x
```

Update `bochsrc`: set `romimage` and `vgaromimage` to your local Bochs BIOS paths.

```bash
sudo apt-get update
sudo apt-get install \
  nasm \
  qemu-system-x86 \
  bison \
  flex \
  libgmp3-dev \
  libmpc-dev \
  libmpfr-dev \
  texinfo \
  grub-pc-bin \
  xorriso
```

### Cross Compiler Setup

#### Set environment variables

```bash
export PREFIX="/usr/opt/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"
```

#### Build binutils

```bash
cd ~/Downloads/
git clone git://sourceware.org/git/binutils-gdb.git
mkdir build-binutils
cd build-binutils

../binutils-gdb/configure \
  --target=$TARGET \
  --prefix="$PREFIX" \
  --with-sysroot \
  --disable-nls \
  --disable-werror

make
sudo make install
```

#### Build GCC

```bash
cd ~/Downloads/
git clone https://gcc.gnu.org/git/gcc.git
mkdir build-gcc
cd build-gcc

../gcc/configure \
  --target=$TARGET \
  --prefix="$PREFIX" \
  --disable-nls \
  --enable-languages=c,c++ \
  --without-headers

make all-gcc
make all-target-libgcc
sudo make install-gcc
sudo make install-target-libgcc
```

## Build

```bash
make
```

## Run

```bash
./run.sh
```
