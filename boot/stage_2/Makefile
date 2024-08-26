OUTPUT_DIR = ../../build
ENTRYPOINT_OBJ = main.o
C_SRC_FILES = $(wildcard *.c)
ASM_SRC_FILES = $(wildcard *.asm)
C_OBJ_FILES = $(notdir $(patsubst %.c, %.o, $(C_SRC_FILES)))
ASM_OBJ_FILES = $(filter-out bootloader_2.o, $(notdir $(patsubst %.asm, %.o, $(ASM_SRC_FILES))))

INC = -I../../src/include

all: stage2.bin

stage2.bin: start.bin main.elf
	@llvm-objcopy -j .text -j .data -j .rodata -j .bss -O binary $(OUTPUT_DIR)/main.elf $(OUTPUT_DIR)/main.bin
	@cat $(OUTPUT_DIR)/start.bin $(OUTPUT_DIR)/main.bin > $(OUTPUT_DIR)/stage2.bin


start.bin:
	fasm bootloader_2.asm start.bin
	mv start.bin $(OUTPUT_DIR)/start.bin


main.elf: $(C_OBJ_FILES) $(ASM_OBJ_FILES) font.o
	@ld -melf_i386 -T linker.ld -nostdlib -o $@ $^
	@mv main.elf $(OUTPUT_DIR)/main.elf

font.o:
	@llvm-objcopy -O elf32-i386 -I binary ../../fonts/font.ttf font.o

%.o: %.c
	@clang -O3 -ggdb -m32 -march=i386 -ffreestanding -masm=intel -mno-sse -Wall -Wextra $(INC) -c $<

clean:
	rm -rf $(OUTPUT_DIR)/stage2.bin
	rm -rf $(OUTPUT_DIR)/start.bin
	rm -rf $(OUTPUT_DIR)/font.o
	rm -rf $(OUTPUT_DIR)/main.elf
	rm -rf *.o

