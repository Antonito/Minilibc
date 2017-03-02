##
## defs.mk for minilibc in School/asm_minilibc
##
## Made by Antoine Baché
## Login   <antoine.bache@epitech.net>
##
## Started on  Mon Feb 27 11:39:45 2017 Antoine Baché
## Last update Thu Mar 02 16:55:44 2017 troncy_l
##

# Commands definitions
RM=		rm -f
ECHO=		echo -ne
RANLIB=		ar rcs
CP=		cp
CHDIR=		cd
IGNORE=		2> /dev/null ||:

INSTALL_DIR=	bin/
INSTALL_PATH=	$(ROOT_DIR)/$(INSTALL_DIR)

BENCH_DIR=	./bench/
TEST_DIR=	./tests/

# Compilation and link definitions
AS=		nasm -O0 -g
CC=		gcc -g
C_VER=		c99
ARCH=		x86_64

ifeq ($(ARCH), x86)
ASFLAGS=	-f elf32
LDFLAGS=	-m32
CFLAGS=		-m32
else ifeq ($(ARCH), x86_64)
ASFLAGS=	-f elf64
LDFLAGS=	-m64
CFLAGS=		-m64
else
$(error "Architecture not supported")
endif

# Debug Infos
ifeq ($(DEBUG), yes)
CFLAGS+=	-g -DDEBUG -fomit-frame-pointer 	\
		-fstack-protector			\
		-Wformat-security			\
		$(LOCAL_DEBUG_FLAGS)
ASFLAGS+=	-g
LDFLAGS+=	-g
else
CFLAGS+=	-DNDEBUG
LDFLAGS+=
endif

CFLAGS+=	$(INC_DIR)				\
		$(LOCAL_COMP_FLAGS)			\
		-std=$(C_VER) 				\
		-W 					\
		-Wall 					\
		-Wextra

LDFLAGS+=	$(LOCAL_LINK_FLAGS)

ASFLAGS+=	$(INC_DIR)

ifeq ($(CC),clang)
CFLAGS+=
LDFLAGS+=
endif

ifeq ($(MODE),test)
LDFLAGS+=
else ifeq ($(MODE),bench)
LDFLAGS+=	-lbenchmark					\
		-lm						\
		-pthread
endif
