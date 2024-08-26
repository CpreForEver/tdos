#include <stdio.h>
#include <unistd.h>
#define SECTOR_SIZE 1024
#define BUFFER_SIZE 512

typedef unsigned short u16;
typedef unsigned char u8;

int main(int argc, char**argv)
{
	if(argc < 3){
		printf("Usage %s disk.img bootloader.bin\n", argv[0]);
		return -1;
	}

	FILE* fptr = fopen(argv[1], "rb");
	u16 magic = 0xDEC0;
	u16 buffer[BUFFER_SIZE];

	u16 sector = 0;
	u16 block = 0;

	while(1)
	{
		fread(buffer, sizeof(buffer[0]), BUFFER_SIZE , fptr);
		block = 0;
		int found = 0;
		for(int ii=0; ii < BUFFER_SIZE; ++ii){
			
			u16 value = buffer[ii];
			if(value == magic){
				block = ii;
				found = 1;
				break;
			}
		}
		if(found == 1) break;
		sector++;
		if(feof(fptr)) break;
	}
	fclose(fptr);

	u16 sector_update = sector + block;
	printf("Found Magic in sector: %d, block: %d\n", sector, block);
	printf("Updating boot sector with: %x\n", sector_update);

	u16 location;
	fptr = fopen(argv[2], "rb");
	fseek(fptr, sizeof(buffer[0]) * 256, SEEK_SET);
	fread(&location, sizeof(buffer[0]), 1, fptr);

	fclose(fptr);
	location = location & 0xff;
	printf("Locaiton found: %x\n", location);

	fptr = fopen(argv[1], "rb+");
	fseek(fptr, 0, SEEK_SET);
	fseek(fptr, location, SEEK_SET);
	fwrite(&sector_update, sizeof(u16), sizeof(u16), fptr);

	fclose(fptr);

}
