; copyright
; file: bootloader_1.asm
; description: init point for tdos bootloader
USE16
ORG 0x600

; NOTE:For BOCHS
; To set a breakpoint, make sure bochs has debugging enabled
; and use xchg bx, bx
; Use x /320h 0x1000
; debug at 0x674
; debug at 0x682


; helpful macros
INCLUDE '../inc/macros.mac'

DAP_PACKET EQU 0800h		; 800 ensures we are above our 512 bytes

VIRTUAL AT DAP_PACKET
	DAP_PACKET.SIZE		DW	0
	DAP_PACKET.COUNT	DW	0 	
	DAP_PACKET.OFFS		DW	0
	DAP_PACKET.SEGM		DW	0
	DAP_PACKET.SECT0	DW	0
	DAP_PACKET.SECT1	DW	0
	DAP_PACKET.SECT2	DW	0
	DAP_PACKET.SECT3	DW	0
END VIRTUAL
START:
	; relocate to a safer location
	CLI			; clear interrupts
	CLD
	MOV AX, 600h		; establish our stack
	MOV SP, AX		; stack pointer
	MOV BP, AX		; base pointer
	MOV SI, 7C00h
	MOV DI, AX		; we can do this because the stack moves
				; in two directions
	MOV CX, 256		; copy our 512 bytes to our new location
	REP MOVSW
	JMP 0:MAIN		; jump with the ORG in mind

MAIN:
	; set up the function stack
	XOR AX, AX
	XOR BX, BX
	XOR CX, CX


	PRINT COPYRIGHT
	PRINT START_BOOT_MSG

	; Locate the 2nd stage bootloader and launch
.CHECK_DISK:
	MOV SI, TEST_EXT
	MOV AH, 41h
	MOV DL, 80h
	MOV BX, 055AAh
	INT 13h
	JC PANIC

	MOV WORD [DAP_PACKET.SIZE],	16	
	MOV CX,				[STAGE_2_LEN]
	MOV WORD [DAP_PACKET.COUNT],	CX
	MOV CX,				[INITSEG]
	MOV WORD [DAP_PACKET.SEGM],	0x0
	MOV WORD [DAP_PACKET.OFFS],	CX
	MOV CX,				[STAGE_2_LOC]
	MOV WORD [DAP_PACKET.SECT0],	CX
	MOV WORD [DAP_PACKET.SECT1],	0x0
	MOV WORD [DAP_PACKET.SECT2],	0x0
	MOV WORD [DAP_PACKET.SECT3],	0x0

.READ_EXT:
	MOV SI, DAP_PACKET
	MOV AH, 42h
	INT 13h
	JC .BAD_READ

	MOV DX, WORD [MAGIC]
	MOV SI, [INITSEG] 
	MOV AX, WORD [SI]
	CMP DX, AX
	JNE .BAD_MAGIC
	MOV AX, [INITSEG]
	ADD AX, 4		; jump 4 to get past the magic words
	JMP AX

.BAD_READ:
	MOV SI, READ_EXT
	JMP PANIC

.BAD_MAGIC:
	MOV SI, MAGIC_EXT
	JMP PANIC

FOREVER:
	JMP FOREVER		; end of line


; include functions
INCLUDE '../inc/printer.inc'

PANIC:
	PRINT PANIC_PREFIX
	PRINT SI
	PRINT NL
	XOR AX, AX
	INT 16h			; wait for keyboard interrupt
	JMP FAR 0FFFFh:0

; variables
STAGE_2_LEN:	DW 36			; this is the size of the main.elf file in Kb
STAGE_2_LOC:	DW 0xC0DE	;
				
MAGIC:		DB 0C0h, 0DEh	; 0xC0DE
INITSEG:	DW 1000h	; modifying this means modifying out stage 2

; constants
COPYRIGHT DB "Copyright 2024", 0x0D, 0x0A, 0x0
START_BOOT_MSG DB "TDOS Bootload v0.1", 0x0D, 0x0A, 0x0
NL DB 0x0D, 0x0A, 0x0
PANIC_PREFIX DB "BOOT PANIC: ", 0x0

TEST_EXT	DB "-1",	0x0 
READ_EXT	DB "-2",	0x0
MAGIC_EXT	DB "-3",	0x0

TIMES 510-($-$$) DB 0
DW 0xAA55
DW STAGE_2_LOC
