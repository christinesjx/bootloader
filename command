nasm -f bin boot_sect.asm -o boot_sect.bin

od -t x1 -A n boot_sect.bin

qemu-system-x86_64 -fda boot_sect.bin

