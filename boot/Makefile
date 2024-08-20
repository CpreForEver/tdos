
all: bootloader coreloader

bootloader: 
	make -C stage_1 all

coreloader: 
	make -C stage_2 all

clean:
	make -C stage_1 clean
	make -C stage_2 clean


