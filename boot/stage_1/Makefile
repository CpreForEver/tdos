OUTPUT_DIR = ../../build

all: bootloader

bootloader: 
	fasm bootloader_1.asm bootloader.bin
	mv bootloader.bin $(OUTPUT_DIR)/bootloader.bin

clean:
	rm -rf $(OUTPUT_DIR)/bootloader.bin


