
/**
* copyright
*/

#include "types.h"

typedef struct __attribute__((packed)){
	uint16 majorVersion;
	uint16 minorVersion;
	uint32 fontRevision[176];
	uint32 magicNumber;
	uint16 flags;
	uint16 uintsPerEm;
	uint64 created;
	uint64 modified;
	int16 xMin;
	int16 yMin;
	int16 xMax;
	int16 yMax;
	uint16 macStyle;
	uint16 lowestRecPPEM;
	int16 fontDirectionHint;
	int16 indexToLocFormat;
	int16 glpyDataFormat;
} header;


typedef struct __attribute__((packed)){
	int16 numberOfContours;
	int16 xMin;
	int16 yMin;
	int16 xMax;
	int16 yMax;
} glyph_header;

extern header _binary_______fonts_font_ttf_start;

