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

all: clean $(PROJECT_NAME).hex

$(PROJECT_NAME).o: $(PROJECT_NAME).a65
	$(CA) $(AFLAGS) -o $(PROJECT_NAME).o $(PROJECT_NAME).a65
$(PROJECT_NAME).bin: $(PROJECT_NAME).o
	$(CL) $(LFLAGS) -C $(TARGET).cfg -o $(PROJECT_NAME).bin $(PROJECT_NAME).o
$(PROJECT_NAME).hex: $(PROJECT_NAME).bin
	srec_cat $(PROJECT_NAME).bin -binary -offset=0x0200 -output $(PROJECT_NAME).hex -Intel -address-length=2

clean:
	$(RM) $(RMFLAGS) *.o *.bin
