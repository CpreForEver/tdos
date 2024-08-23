; copyright
; file: bootloader_1.asm
; description: init point for tdos bootloader
USE16
ORG 0x1000

; helpful macros
INCLUDE '../inc/macros.mac'


DB 0C0h, 0DEh	; 0xC0DE

START: 
	CLI
	CLD
	MOV AX, 600h
	MOV SP, AX
	MOV BP, AX

FINISH:
	jmp FINISH

