# tdos
tdos is a low level operating system currently operating as a 'Live' 
application. It contains a stage 1 bootloader which will launch it into
the active core of the OS.

During the development process, most comments will be retained with in the README
markdown files. 

## Path of least resistance
* [] Finalize the 1st stage bootloader
* [] Jump and start the second stage
* [] Load the core OS

## Elements
* [] Standard print function
* [] Devise plan for other standard libraries
* [] Launch vbash

# TOOLS

## bochs
Installed using debian and compiling the source code for bochs 2.8. Compilation was done using 
'''
_$ .configure --enable_debugger --enable_debugger_gui
_$ sudo make install -j12
'''

See bochsrc.txt for configuration details

NOTE: Still not working, the memory at 0x7c00 is not populated with my bootloader yet and I'm not sure why
