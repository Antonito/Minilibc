##
## Makefile for minilibc in asm_minilibc
##
## Made by Antoine Baché
## Login   <antoine.bache@epitech.net>
##
## Started on  Mon Feb 27 11:42:16 2017 Antoine Baché
## Last update Mon Feb 27 11:42:29 2017 Antoine Baché
##

# Makefile dependencies directory
MK_DIR=		./mk/
MK_COMMON_DIR=	./../mk/

include $(MK_COMMON_DIR)colors.mk $(MK_DIR)local_defs.mk $(MK_COMMON_DIR)defs.mk

# Project's files
SRC_DIR=	./src/

SRC_FILES=	main.c		\
		basic.c		\
		medium.c	\
		advanced.c	\
		bonus.c

BONUS_DIR=	../bonus/

SRC=		$(addprefix $(SRC_DIR), $(SRC_FILES))

# Rules
include $(MK_COMMON_DIR)rules.mk
