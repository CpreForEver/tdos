; copyright
; file: bootloader_1.asm
; description: init point for tdos bootloader
USE16
ORG 0x7C00

; helpful macros
INCLUDE 'inc/macros.mac'

BOOTSEG = 0x7C00
INITSEG = 0x9200

MAIN:
	; The bootload is moved to a normalized location in memory at 0x
	; this will give 200 bytes to the stack for any possible expansion.
	; We then copy the 2nd stage bootloader up to 0x120200 (200 bytes for
	; the stack) and launch the 2nd stage bootloader at that location.

	; Can we actually use the memory location 0x10000? This is just
	; something I chose based on the LILO bootloader source code hoping
	; this was safe enough to do in the bochs emulator and on a PC.

	; Move the first stage bootloader to a location in memory and jump
	MOV AX, BOOTSEG        ; load the current location
	MOV DS, AX
	MOV AX, INITSEG	; set the location that I want to jump too
	MOV ES, AX
	MOV CX, 256		; copy 256 words to that location
	XOR SI, SI		; Clear the source index and destination index
	XOR DI, DI
	CLD
	REPNZ MOVSW

	; do a long jmp to that location
	JMP START:INITSEG
START:
	; set up the function stack
	XOR AX, AX
	MOV ES, AX
	MOV DS, AX

	; Clear the screen and print the initial bootloader messages
	CALL CLEAR_SCREEN

	PRINT COPYRIGHT
	PRINT START_BOOT_MSG

	; Locate the 2nd stage bootloader and launch



	JMP $		; end of line

CLEAR_SCREEN:
	MOV AH, 0x6
	XOR AL, AL
	XOR CX, CX
	MOV DX, 0x184F
	MOV BH, 0x0F
	INT 0x10
	
	RET

; include functions
INCLUDE 'inc/printer.inc'

COPYRIGHT DB "Copyright 2024", 0x0D, 0x0A, 0x0
START_BOOT_MSG DB "TDOS Bootload v0.1", 0x0D, 0x0A, 0x0

TIMES 510-($-$$) DB 0
DW 0xAA55
