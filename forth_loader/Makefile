PROJECT_NAME = RSC-FORTH_LOADER

SHELL := /bin/bash

AFLAGS		= -t none
LFLAGS		= -t none
RMFLAGS		= -f
 
CC		= cc65
CA		= ca65
CL		= cl65
RM		= rm

TARGET = r6501q

all: clean $(PROJECT_NAME).bin

$(PROJECT_NAME).o: $(PROJECT_NAME).a65
	$(CA) $(AFLAGS) -o $(PROJECT_NAME).o $(PROJECT_NAME).a65
$(PROJECT_NAME).bin: $(PROJECT_NAME).o
	$(CL) $(LFLAGS) -C $(TARGET).cfg -o $(PROJECT_NAME).bin $(PROJECT_NAME).o

clean:
	$(RM) $(RMFLAGS) *.o *.bin

copy: all
	cp $(PROJECT_NAME).bin ../r6501q_romfs/binaries/$(PROJECT_NAME).bin

sim: copy
	node ~/Projects/6502Node/6502node.js

papertape: all
	srec_cat enigma.bin -Binary -offset 512 -Output enigma.bin.ser -MOS_Technologies 
