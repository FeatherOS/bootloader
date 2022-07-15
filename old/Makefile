build:
	nasm -f bin boot.asm -o ../bootloader.bin
run:
	nasm -f bin boot.asm -o ../bootloader.bin
	qemu-system-x86_64 -drive format=raw,file=../bootloader.bin,if=floppy, -m 128M