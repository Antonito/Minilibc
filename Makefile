##
## Makefile for minilibc in Code/School/asm_minilibc
##
## Made by Antoine Baché
## Login   <antoine.bache@epitech.net>
##
## Started on  Mon Feb 27 11:36:46 2017 Antoine Baché
## Last update Mon Feb 27 11:36:59 2017 Antoine Baché
##

# Makefile dependencies directory
MK_DIR=		./mk/

include $(MK_DIR)colors.mk $(MK_DIR)local_defs.mk $(MK_DIR)defs.mk

# Project's files

SRC_DIR=	./src/

SRC_FILES=	memcpy.s	\
		memmove.s	\
		memset.s	\
		rindex.s	\
		strcasecmp.s	\
		strchr.s	\
		strcmp.s	\
		strlen.s	\
		strncmp.s	\
		strstr.s	\
		strpbrk.s	\
		strcspn.s

BONUS_DIR=	./bonus/

BONUS_FILES=	memchr.s	\
		memcmp.s	\
		strnlen.s	\
		sleep.s		\
		syscall.s	\
		rawmemchr.s

SRC=		$(addprefix $(SRC_DIR), $(SRC_FILES))	\
		$(addprefix $(BONUS_DIR), $(BONUS_FILES))

# Rules
include $(MK_DIR)rules.mk
