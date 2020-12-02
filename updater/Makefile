PROJECT_NAME = updater

SHELL := /bin/bash

AFLAGS		= -t none
LFLAGS		= -t none
RMFLAGS		= -f
 
CC		= cc65
CA		= ca65
CL		= cl65
RM		= rm

TARGET = r6501q


all: clean $(PROJECT_NAME)_conf2.hex $(PROJECT_NAME)_conf3.hex

$(PROJECT_NAME)_conf2.bin: $(PROJECT_NAME)_conf2.o
	$(CL) $(LFLAGS) -C $(TARGET).cfg -o $(PROJECT_NAME)_conf2.bin $(PROJECT_NAME)_conf2.o

$(PROJECT_NAME)_conf3.bin: $(PROJECT_NAME)_conf3.o
	$(CL) $(LFLAGS) -C $(TARGET).cfg -o $(PROJECT_NAME)_conf3.bin $(PROJECT_NAME)_conf3.o

$(PROJECT_NAME)_conf2.o: $(PROJECT_NAME).a65
	$(CA) $(C2AFLAGS) -D CONF2=1 -o $(PROJECT_NAME)_conf2.o $(PROJECT_NAME).a65

$(PROJECT_NAME)_conf3.o: $(PROJECT_NAME).a65
	$(CA) $(C3AFLAGS) -D CONF3=1 -o $(PROJECT_NAME)_conf3.o $(PROJECT_NAME).a65

$(PROJECT_NAME)_conf2.hex: $(PROJECT_NAME)_conf2.bin
	srec_cat $(PROJECT_NAME)_conf2.bin -binary -offset=0x0200 -output $(PROJECT_NAME)_conf2.hex -Intel -address-length=2
$(PROJECT_NAME)_conf3.hex: $(PROJECT_NAME)_conf3.bin
	srec_cat $(PROJECT_NAME)_conf3.bin -binary -offset=0x0200 -output $(PROJECT_NAME)_conf3.hex -Intel -address-length=2

clean:
	$(RM) $(RMFLAGS) *.o *.bin *.hex
