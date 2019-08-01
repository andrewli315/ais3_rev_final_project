BUILD_DIR=./build
LIB=-I include/ 
CFLAGS=-fno-builtin -fno-stack-protector -O2 -m32
all:img
img:asm
	dd if=$(BUILD_DIR)/mbr.bin of=hd60M.img count=1 bs=512 conv=notrunc
	dd if=$(BUILD_DIR)/loader.bin of=hd60M.img bs=512 count=8 seek=1 conv=notrunc 
	dd if=$(BUILD_DIR)/kernel.bin of=hd60M.img bs=512 count=200 seek=9 conv=notrunc	
	dd if=$(BUILD_DIR)/kernel2.bin of=hd60M.img bs=512 count=200 seek=209 conv=notrunc	
asm:
	nasm -I include/ -o $(BUILD_DIR)/mbr.bin mbr.S
	nasm -I include/ -f elf32 -o $(BUILD_DIR)/print.o lib/print.S
	gcc  -I lib/ -m32 -c -o $(BUILD_DIR)/main.o kernel/main.c
	gcc  -I lib/ -m32 -c -o $(BUILD_DIR)/main2.o kernel2/main.c
	ld -m elf_i386  $(BUILD_DIR)/main.o $(BUILD_DIR)/print.o -Ttext 0xc0005000 -o $(BUILD_DIR)/main.bin
	ld -m elf_i386  $(BUILD_DIR)/main2.o $(BUILD_DIR)/print.o -Ttext 0xc0005000 -o $(BUILD_DIR)/main2.bin
	objcopy -O binary $(BUILD_DIR)/main.bin $(BUILD_DIR)/kernel.bin
	objcopy -O binary $(BUILD_DIR)/main2.bin $(BUILD_DIR)/kernel2.bin
	python3 digital_signing.py
	nasm -f elf32 -I include/ -o $(BUILD_DIR)/loader.elf loader.S
	gcc $(CFLAGS) -c safensound.c
	ld -m elf_i386 -Ttext 0x600 $(BUILD_DIR)/loader.elf safensound.o -o $(BUILD_DIR)/loader.tmp
	objcopy -O binary $(BUILD_DIR)/loader.tmp $(BUILD_DIR)/loader.bin
clean:
	rm $(BUILD_DIR)/*.*
