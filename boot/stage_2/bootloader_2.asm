; copyright
; file: bootloader_1.asm
; description: init point for tdos bootloader
USE16
ORG 0x9200

; helpful macros
INCLUDE '../inc/macros.mac'


MAGIC: DW 0xC0DE, 0x51A1

