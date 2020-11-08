SHELL		:= /bin/bash

AFLAGS		= -t none
LFLAGS		= -t none
RMFLAGS		= -f

CC		= cc65
CA		= ca65
CL		= cl65
RM		= rm

CFG		= gw-r65x1qsbc-1.cfg
ROMFS_CFG = gw-r65x1qsbc-1_romfs.cfg

all: loader.bin bootloader_loader.bin

romfs.bin: romfs.o
	$(CL) $(LFLAGS) -C $(ROMFS_CFG) -o romfs.bin romfs.o

copy: romfs.bin loader.bin
	cp romfs.bin ../6502Node/romfs.bin
	cp loader.bin ../6502Node/loader.bin

bootloader_loader.bin: romfs_bootloader_loader.o
	$(CL) $(LFLAGS) -C $(CFG) -o bootloader_loader.bin romfs_bootloader_loader.o

loader.bin: romfs_bootloader.o
	$(CL) $(LFLAGS) -C $(CFG) -o loader.bin romfs_bootloader.o





romfs_bootloader.o: romfs_bootloader.a65
	$(CA) $(AFLAGS) -l romfs_bootloader.lst -o romfs_bootloader.o romfs_bootloader.a65

romfs_bootloader_loader.o: loader.bin romfs_bootloader_loader.a65
	$(CA) $(AFLAGS) -l romfs_bootloader_loader.lst -o romfs_bootloader_loader.o romfs_bootloader_loader.a65

romfs.o: bootloader_loader.bin
	$(CA) $(AFLAGS) -o romfs.o romfs.a65

clean:
	$(RM) $(RMFLAGS) *.o *.bin *.hex *.lst

distclean: clean
