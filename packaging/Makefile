image: 
	dd if=/dev/zero of=disk.img bs=1048576 count=10
	printf "g\nn p\n1\n2048\n+8M\nt\n1\nw\n" | sudo fdisk disk.img
	sudo losetup -D
	sudo losetup -o 1048576 -f disk.img
	sudo mkfs.vfat -F 16 -v -n "EFI System" /dev/loop0
	mkdir img
	sudo mount -t vfat,fat=16 /dev/loop0 img
	sudo mkdir -p img/BIOS/BOOT
	sudo cp ../build/stage2.bin img/BIOS/BOOT/STAGE2.BIN
	sudo filefrag -e img/BIOS/BOOT/STAGE2.BIN > ../build/stage_2_offset
	sudo umount img
	rmdir img
	sudo losetup -D
	
	dd conv=notrunc if=../build/bootloader.bin of=disk.img bs=1 count=447
	mv disk.img ../build/disk.img

all: image

clean:
	rm -rf ../build/disk.img
