OUTDIR ?= /run/media/*/LEXAR\ MEDIA/

# If PROJECT_ROOT isn't define, define it as $PWD.
PROJECT_ROOT ?= ${PWD}

# Always use the toolchain we downloaded.
WATCOM ?= ${PROJECT_ROOT}/tools/openwatcom/
PATH := ${WATCOM}/binl:${PATH}
ENV := env "PATH=${PATH}" "WATCOM=${WATCOM}"

# Typical Makefile-for-C-programs configuration.
CC := wcl
CFLAGS := -0 -bcl=dos -i=${HOME}/software/openwatcom/h
#			-Wall -Wextra -Werror \
#			-std=c99

all: bin/hworld.exe bin/cgatest.exe

copy:
	cp bin/* ${OUTDIR}

bin:
	mkdir -p bin

bin/%.exe: tools bin
	${ENV} ${CC} ${CFLAGS} -fe=bin/$* src/$*/*.c

clean:
	rm -rf bin *.o

# Toolchain stuff.

update-tools:
	rm -rf tools
	$(MAKE) tools

tools:
	(mkdir -p ${WATCOM}; cd ${WATCOM}; $(MAKE) -f ${PROJECT_ROOT}/Makefile _install-watcom PROJECT_ROOT=${PROJECT_ROOT})

_install-watcom:
	# Download the installer, which is conveniently also a ZIP file.
	wget https://github.com/open-watcom/open-watcom-v2/releases/download/Current-build/open-watcom-2_0-c-linux-x64
	# Extract it.
	unzip open-watcom-2_0-c-linux-x64
	# Make all the ELF executables actually be executable.
	file ${WATCOM}/*/* | grep ELF | cut -d ':' -f 1 | xargs chmod +x

.PHONY: clean update-tools _install-watcom
