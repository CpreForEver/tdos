
bootloader:
	make -C assm all

disk:
	make -C packaging image

all: bootloader disk

clean: 
	make -C assm clean
	make -C packaging clean
