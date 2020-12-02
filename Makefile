SHELL		:= /bin/bash

AFLAGS		= -t none
LFLAGS		= -t none
RMFLAGS		= -f

CC		= cc65
CA		= ca65
CL		= cl65
RM		= rm

CFG		= gw-r65x1qsbc-1.cfg
ROMFS_CFG	= gw-r65x1qsbc-1_romfs.cfg

.PHONY: clean all updater

all: updater romfs_conf2.bin romfs_conf3.bin




bootloader_loader.bin: bootloader_loader.o
	$(CL) $(LFLAGS) -C $(CFG) -o bootloader_loader.bin bootloader_loader.o

loader.bin: bootloader.o
	$(CL) $(LFLAGS) -C $(CFG) -o loader.bin bootloader.o

bootloader.o: romfs_bootloader.a65
	$(CA) $(AFLAGS) -l romfs_bootloader.lst -o bootloader.o romfs_bootloader.a65

bootloader_loader.o: loader.bin romfs_bootloader_loader.a65
	$(CA) $(AFLAGS) -l romfs_bootloader_loader.lst -o bootloader_loader.o romfs_bootloader_loader.a65



romfs_conf2.bin: romfs_conf2.o
	$(CL) $(LFLAGS) -C $(ROMFS_CFG) -o romfs_conf2.bin romfs_conf2.o

romfs_conf2_no_bootloader.bin: romfs_conf2_no_bootloader.o
	$(CL) $(LFLAGS) -C $(ROMFS_CFG) -o romfs_conf2_no_bootloader.bin romfs_conf2_no_bootloader.o

romfs_conf2.o: bootloader_loader.bin forth_loader
	$(CA) $(AFLAGS) -D INC_BOOTLOADER=1 -D CONF2=1 -o romfs_conf2.o romfs.a65

romfs_conf2_no_bootloader.o: forth_loader
	$(CA) $(AFLAGS) -D CONF2=1 -o romfs_conf2_no_bootloader.o romfs.a65



romfs_conf3.bin: romfs_conf3.o
	$(CL) $(LFLAGS) -C $(ROMFS_CFG) -o romfs_conf3.bin romfs_conf3.o

romfs_conf3_no_bootloader.bin: romfs_conf3_no_bootloader.o
	$(CL) $(LFLAGS) -C $(ROMFS_CFG) -o romfs_conf3_no_bootloader.bin romfs_conf3_no_bootloader.o

romfs_conf3.o: bootloader_loader.bin forth_loader
	$(CA) $(AFLAGS) -D INC_BOOTLOADER=1 -D CONF3=1 -o romfs_conf3.o romfs.a65

romfs_conf3_no_bootloader.o: forth_loader
	$(CA) $(AFLAGS) -D CONF3=1 -o romfs_conf3_no_bootloader.o romfs.a65



clean:
	$(RM) $(RMFLAGS) *.o *.bin *.hex *.lst
	+$(MAKE) -C forth_loader clean
	+$(MAKE) -C updater clean

distclean: clean


.PHONY: forth_loader
forth_loader:
	$(MAKE) -C forth_loader

updater: romfs_conf2_no_bootloader.bin romfs_conf3_no_bootloader.bin bootloader_loader.bin
	+$(MAKE) -C updater
	cp updater/updater_conf2.hex updater_conf2.hex
	cp updater/updater_conf3.hex updater_conf3.hex
