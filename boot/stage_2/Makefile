OUTPUT_DIR = ../../build

all: coreloader

coreloader: 
	fasm bootloader_2.asm stage2.bin
	mv stage2.bin $(OUTPUT_DIR)/stage2.bin

clean:
	rm -rf $(OUTPUT_DIR)/stage2.bin


