; copyright
; file: bootloader_1.asm
; description: init point for tdos bootloader
USE16
ORG 0x7C00

; helpful macros
INCLUDE '../inc/macros.mac'

MAGIC = 0x51A1C0DE
INITSEG = 0x9200

DAP_PACKET EQU 0x7E00
VIRTUAL AT DAP_PACKET
	DAP_PACKET.SIZE:	DB	?
	DAP_PACKET.RES:		DB	0x0
	DAP_PACKET.COUNT:	DW	?
	DAP_PACKET.SEG:		DW	?
	DAP_PACKET.SECT0:	DW	?
	DAP_PACKET.SECT1:	DW	?
	DAP_PACKET.SECT2:	DW	?
	DAP_PACKET.SECT3:	DW	?
END VIRTUAL

MAIN:
	; set up the function stack
	XOR AX, AX
	MOV ES, AX
	MOV DS, AX
	XOR BX, BX

	; Clear the screen and print the initial bootloader messages
	CALL CLEAR_SCREEN

	PRINT COPYRIGHT
	PRINT START_BOOT_MSG

	; Locate the 2nd stage bootloader and launch
.CHECK_DISK:
	MOV SI, TEST_EXT
	MOV AH, 0x41
	MOV DL, 0x80
	MOV BX, 0x55AA
	INT 0x13
	JC PANIC

	MOV WORD [DAP_PACKET.SEG], 0x80
.READ_EXT:
	MOV WORD [DAP_PACKET.SIZE], 0x10
	MOV WORD [DAP_PACKET.COUNT], 0x60
	MOV WORD [DAP_PACKET.SECT0], 0x0
	MOV WORD [DAP_PACKET.SECT1], 0x2
	MOV WORD [DAP_PACKET.SECT2], 0x0
	MOV WORD [DAP_PACKET.SECT3], 0x0

	MOV SI, DAP_PACKET
	MOV AH, 0x42
	INT 0x13
	JC .BAD_READ

	MOV SI, SEARCH
	MOV DX, [MAGIC]
	CMP DX, DI
	JNE .LOOP
	JMP 0:0xFFFF

.LOOP:
	ADD WORD [DAP_PACKET.SEG],0x1 
	MOV BX, 0x90
	CMP BX, WORD [DAP_PACKET.SEG]
	JA  .NOT_FOUND
	JMP .READ_EXT

.BAD_READ:
	MOV SI, READ_EXT
	JMP PANIC

.NOT_FOUND:
	MOV SI, NOTFOUND
	JMP PANIC


	; The bootload is moved to a normalized location in memory at 0x
	; this will give 200 bytes to the stack for any possible expansion.
	; We then copy the 2nd stage bootloader up to 0x120200 (200 bytes for
	; the stack) and launch the 2nd stage bootloader at that location.

	; Can we actually use the memory location 0x10000? This is just
	; something I chose based on the LILO bootloader source code hoping
	; this was safe enough to do in the bochs emulator and on a PC.

	; Move the first stage bootloader to a location in memory and jump
	CLD
	CLI
	MOV AX, BX		; load the current location
	MOV SI, AX
	MOV AX, INITSEG		; set the location that I want to jump too
	MOV DI, AX
	MOV CX, 256		; copy 256 words to that location
	CLD
	REP MOVSW

	; do a long jmp to that location
	JMP 0:0xffff



	JMP $		; end of line

CLEAR_SCREEN:
	MOV AH, 0x06
	XOR AL, AL
	XOR CX, CX
	MOV DX, 0x184F
	MOV BH, 0x0F
	INT 0x10
	
	RET

; include functions
INCLUDE '../inc/printer.inc'

PANIC:
	PRINT PANIC_PREFIX
	PRINT SI
	PRINT NL
	XOR AX, AX
	INT 0x16
	JMP FAR 0xFFFF:0

COPYRIGHT DB "Copyright 2024", 0x0D, 0x0A, 0x0
START_BOOT_MSG DB "TDOS Bootload v0.1", 0x0D, 0x0A, 0x0
NL DB 0x0D, 0x0A, 0x0
PANIC_PREFIX DB "BOOT PANIC: ", 0x0

TEST_EXT DB "-1", 0x0 
READ_EXT DB "-2", 0x0
SEARCH   DB "-3", 0x0
NOTFOUND DB "-4", 0x0

TIMES 510-($-$$) DB 0
DW 0xAA55
