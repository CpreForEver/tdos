
all: assm image

assm:
	make -C boot all

image: assm 
	make -C packaging all

objboot: assm
	objdump -Mintel -mi8086 -b binary --adjust-vma=0x600 -D build/bootloader.bin

objstart: assm
	objdump -Mintel -mi8086 -b binary --adjust-vma=0x1000 -D build/start.bin

objelf: assm
	objdump -Mintel -mi8086 -b binary --adjust-vma=0x1000 -D build/main.elf


clean: 
	make -C boot clean
	make -C packaging clean
