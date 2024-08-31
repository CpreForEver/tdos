#include "console.h"
#include "colors.h"
#include "console_font.h"

uint16 __line__ = 0;
uint16 __column__ = 0;

void fill(){
  uint64 fb = bootinfo.fb_ptr;
  for(uint32 ii=0; ii < bootinfo.fb_width; ++ii){
    for(uint32 jj=0; jj < bootinfo.fb_height; ++jj){
      *(uint32*)(fb + ii*4 + jj*bootinfo.fb_scanline_bytes) = TERMINAL_BACKGROUND;
    }
  }

}

