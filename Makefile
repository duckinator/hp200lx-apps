OUTPUT := /run/media/puppy/LEXAR\ MEDIA/

WATCOM := ${HOME}/software/openwatcom/
PATH := "${HOME}/software/openwatcom/binl:${PATH}"
ENV := env "PATH=${PATH}" "WATCOM=${WATCOM}"


CC := wcl
CFLAGS := -0 -bcl=dos -i=${HOME}/software/openwatcom/h
#			-Wall -Wextra -Werror \
#			-std=c99

all: bin/hworld.exe

bin:
	mkdir -p bin

bin/%.exe: bin
	${ENV} ${CC} ${CFLAGS} -fe=bin/$* src/$*/*.c

clean:
	rm -rf bin *.o

.PHONY: clean
