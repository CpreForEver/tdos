
all: assm image

assm:
	make -C boot all

image: assm 
	make -C packaging all

objboot: assm
	objdump -Mintel -mi8086 -b binary --adjust-vma=0x600 -D build/bootloader.bin

objstage2: assm
	objdump -Mintel -mi8086 -b binary --adjust-vma=0x600 -D build/stage2.bin
clean: 
	make -C boot clean
	make -C packaging clean
