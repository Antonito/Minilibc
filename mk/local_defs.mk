##
## local_defs.mk for minilibc in /asm_minilibc
##
## Made by Antoine Baché
## Login   <antoine.bache@epitech.net>
##
## Started on  Mon Feb 27 11:40:08 2017 Antoine Baché
## Last update Mon Feb 27 11:54:50 2017 Antoine Baché
##

# Definitions for Makefile
NAME=			libasm.so

INC_DIR=		-I./include/

DEBUG=			no

MODE=

LOCAL_COMP_FLAGS=	-fPIC -pipe

LOCAL_LINK_FLAGS=	-fPIC 			\
			-shared			\
			-nodefaultlibs

LOCAL_DEBUG_FLAGS=
