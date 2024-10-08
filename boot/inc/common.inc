; Colors
COLOR_GREEN		equ 02h
COLOR_CYAN		equ 03h
COLOR_RED		equ 04h

; LBA Packet information Direct Access Packet

; Global Variables
MMAP_USED		equ 0
MMAP_FREE		equ 1
MMAP_ACPI		equ 2
MMAP_RECLAIM		equ 3

; Boot Information
BOOTINFO_MAGIC		equ 'FLCN'
BOOTLOADER_BIOS		equ 0
BOOTLOADER_UEFI		equ 1
MAX_BOOTINFO_SZ		equ 4096

VIRTUAL AT BOOTINFO
	BOOTINFO.MAGIC		DD	0
	BOOTINFO.SIZE		DD	0
	BOOTINFO.BOOTLOADER	DB	0
	BOOTINFO.UNUSED0	DB	0, 0, 0
	BOOTINFO.FB_PTR		DQ	0
	BOOTINFO.FB_WIDTH	DD	0
	BOOTINFO.FB_HEIGHT	DD	0
	BOOTINFO.FB_SCANLINE	DD	0
	BOOTINFO.FB_PIXFORMAT	DB	0
	BOOTINFO.UNUSED1	DB	31 DUP 0

	BOOTINFO.ACPI_PTR	DQ	0
	BOOTINFO.UNUSED2	DB	24 DUP 0

	BOOTINFO.MMAP:
END VIRTUAL

; ----------------- GRAPHICS ------------------
VBE_SUPPORTED				equ 1
VBE_COLOR				equ 8
VBE_GRAPHICS				equ 16
VBE_LINEAR_FB				equ 128

VBE_DIRECT_COLOR			equ 6

VBE_MODE_ATTRIB_OFFSET 			equ 0
VBE_MODE_MEMORY_MODEL_OFFSET		equ 1Bh
VBE_MODE_BPP_OFFSET			equ 19h
VBE_MODE_WIDTH_OFFSET			equ 12h
VBE_MODE_HEIGHT_OFFSET			equ 14h
VBE_MODE_SCANLINE_OFFSET		equ 10h
VBE_MODE_FB_PHYSADDR_OFFSET		equ 28h
VBE_MODE_BLUE_FIELD_SIZE_OFFSET		equ 24h

VBE_FB_ARGB				equ 0
VBE_FB_RGBA				equ 1
VBE_FB_ABGR				equ 2
VBE_FB_BGRA				equ 3
