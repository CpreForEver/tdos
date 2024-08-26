#include "console.h"

void fill(){
	uint64 fb = bootinfo.fb_ptr;
	for(uint32 ii=0; ii < bootinfo.fb_width; ++ii){
		for(uint32 jj=0; jj < bootinfo.fb_height; ++jj){
			*(uint32*)(fb + ii*4 + jj*bootinfo.fb_scanline_bytes) = 0xffffff;
		}
	}
}

// test function for now
void print_char(int16 x, int16 y, char c){
	//print_ttf_char(x, y, c);
	//
	
}
