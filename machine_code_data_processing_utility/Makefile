CC = gcc
AS = as
LD = ld
CFLAGS = -Wall -Wextra
ASFLAGS = --64
LDFLAGS = -static

TARGET = machine_code_data_processing_utility

SRCS = main.asm ingester.asm transformer.asm validator.asm reporter.asm
OBJS = $(SRCS:.asm=.o)

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

%.o: %.asm
	$(AS) $(ASFLAGS) -o $@ $<

clean:
	rm -f $(OBJS) $(TARGET)
	rm -f *.txt
