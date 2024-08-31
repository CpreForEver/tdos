#pragma once

#include "types.h"
#include "bootinfo.h"
#include <stdarg.h>

extern uint16 __line__;
extern uint16 __column__;

#define MAX_STRING_SIZE 256

void fill();
void printf(const char* format, ...);

