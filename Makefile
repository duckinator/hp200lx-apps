OUTPUT := /run/media/puppy/LEXAR\ MEDIA/

WATCOM := ${HOME}/software/openwatcom/

CC := wcl
CFLAGS := -0 -bcl=dos -i=${HOME}/software/openwatcom/h
#			-Wall -Wextra -Werror \
#			-std=c99

all: bin/hworld

bin:
	mkdir -p bin

bin/hworld: bin
	env WATCOM=${WATCOM} ${CC} ${CFLAGS} -fe=bin/hworld hworld/main.c

clean:
	rm -rf bin

.PHONY: clean
