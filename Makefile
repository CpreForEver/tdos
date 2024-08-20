
all: assm image

assm:
	make -C boot all

image: assm 
	make -C packaging all


clean: 
	make -C boot clean
	make -C packaging clean
