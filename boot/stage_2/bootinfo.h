
#pragma once

#include "types.h"

/* bootloader types */
#define BOOTLOADER_BIOS 0
#define BOOTLOADER_UEFI 1

/* framebuffer pixel formats, only 32 bits supported */
#define PIXELFORMAT_ARGB 0
#define PIXELFORMAT_RGBA 1
#define PIXELFORMAT_ABGR 2
#define PIXELFORMAT_BGRA 3

/* memory map types */
#define MMAP_USED 0        /* don't use. Reserved or unknown regions */
#define MMAP_FREE 1        /* usable memory */
#define MMAP_ACPI 2        /* acpi memory, volatile and non-volatile as well */
#define MMAP_RECLAIMABLE 3 /* memory mapped IO region */
#define MMAP_BOOTINFO 4    /* memory used by the bootinfo struct */
#define MMAP_FRAMEBUFFER 5 /* memory used by the framebuffer */
#define MMAP_KERNEL_MODULE 6 /* kernel module */
#define MMAP_PAGING 7 /* kernel module */

/* mmap entry, type is stored in least significant byte of ptr
 * but all map entries should be page aligned (1 << 12)
 * so the least significant 12bits are empty anyway
 */
typedef struct __attribute((packed)){
  uint64 ptr;
  uint64 size;
} mmap_entry;

typedef struct __attribute((packed)) {
  uint8 magic[4];        /* magic bytes are 'FLCN' */
  uint32 size;           /* total size of the struct */
  uint8 bootloader_type; /* bootloader type (BIOS|UEFI) */
  uint8 unused0[3];
  uint64 fb_ptr; /* framebuffer pointer and dimensions */
  uint32 fb_width;
  uint32 fb_height;
  uint32 fb_scanline_bytes; /* number of bytes in scanline */
  uint8 fb_pixelformat;     /* pixel format */
  uint8 unused1[31];
  uint64 acpi_ptr;
  uint8 unused2[24];
  mmap_entry mmap; /* physical memory map */
} boot_info;

extern boot_info bootinfo;

