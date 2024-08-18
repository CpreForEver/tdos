; copyright
; file: bootloader_1.asm
; description: init point for tdos bootloader
USE16
ORG 0x7C00

; helpful macros
INCLUDE 'inc/macros.mac'

dap_packet EQU 0x7E00
VIRTUAL AT lba_packet
	dap_packet.size        : dw         ?
	dap_packet.count       : dw         ?
	dap_packet.offset      : dw         ?
	dap_packet.segment     : dw         ?
	dap_packet.sector0     : dw         ?
	dap_packet.sector1     : dw         ?
	dap_packet.sector2     : dw         ?
	dap_packet.sector3     : dw         ?
END VIRTUAL

START:
	XOR AX, AX
	MOV ES, AX
	MOV DS, AX

	CALL CLEAR_SCREEN

	PRINT COPYRIGHT
	PRINT START_BOOT_MSG

	MOV SI, START_PROMPT
	CALL PRINT_STRING

	; start the jump to the bios boot loader

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
INCLUDE 'inc/common.inc'

TIMES 510-($-$$) DB 0
DW 0xAA55
