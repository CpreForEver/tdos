#!/bin/bash

rm build/tdos.bin
nasm -f bin assm/bootloader_1.asm -o build/tdos.bin
qemu-system-x86_64 -drive format=raw,file=build/tdos.bin
