# ROMFS for Glitch Works R65X1Q SBC

This repository contains source files and utilities for using ROMFS on the [Glitch Works R65X1Q SBC](https://www.tindie.com/products/21523/). ROMFS is a simple file system intended for use with EPROMs, EEPROMs, and other nonvolatile memory.

### Updating ROMFS

There are two different updaters available. `updater/updater_conf2.hex` contains RSC-FORTH configuration 2 and will work on an R65X1Q SBC without a Glitchbus 32K memory expansion board. `updater/updater_conf3.hex` contains RSC-FORTH configuration 3 and requires a Glitchbus 32K memory expansion board.

Load the desired updater hex file using the eWoz ROM monitor -- this will take two to three minutes at 4800 bps. Once the hex load has finished with a success message, execute the loader by typing:

`200R`

at the eWoz prompt. The updater will prompt you to enable EEPROM writes via DIP switch and wait. **DO NOT ATTEMPT TO INTERRUPT THE UPDATE ONCE IT BEGINS!** This program rewrites the system EEPROM and will prompt for a reset when it is ready. Interrupting the update will probably corrupt your system EEPROM.

### Default ROMFS Configuration

The ROMFS directory in the default 32K system image is as follows:

```
Record #    Contents
-------------------------------------------------------------------------------
0           eWoz 1.2 for Glitch Works R65X1Q SBC, running from RAM
1           Tiny BASIC for Glitch Works R65X1Q SBC
2           Rockwell RSC-FORTH v1.7 for R65X1Q SBC bootloader
3           Memory Tester for R65X1Q SBC
4           R65X1Q SBC ROMFS Bootloader
5           RSC-FORTH 1.7 Conf 2 Kernel
6           RSC-FORTH 1.7 Conf 2 Dev. Env.
```

Setting the `PA0` - `PA3` switches to the record number specified in the above table will load and boot the specified ROMFS record. Note that records number 5 and 6 are not directly bootable and must be loaded by record number 2, the RSC-FORTH bootloader.
