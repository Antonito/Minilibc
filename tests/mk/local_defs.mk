##
## local_defs.mk<tests> for minilibc in /asm_minilibc
##
## Made by Antoine Baché
## Login   <antoine.bache@epitech.net>
##
## Started on  Mon Feb 27 11:41:50 2017 Antoine Baché
## Last update Thu Mar 16 15:24:45 2017 troncy_l
##

NAME=			./bin/minilibc_test
INC_DIR=
DEBUG=			yes
MODE=			test

LOCAL_COMP_FLAGS=	-I./include/	\
			-I../include/

LOCAL_LINK_FLAGS=	-ldl

LOCAL_DEBUG_FLAGS=
