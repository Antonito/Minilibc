##
## local_defs.mk for minilibc in Code/School/asm_minilibc
##
## Made by Antoine Baché
## Login   <antoine.bache@epitech.net>
##
## Started on  Mon Feb 27 11:38:02 2017 Antoine Baché
## Last update Mon Feb 27 11:38:12 2017 Antoine Baché
##

NAME=			./bin/minilibc_bench
INC_DIR=
DEBUG=			no
MODE=			bench

LOCAL_COMP_FLAGS=	-I./include/

LOCAL_LINK_FLAGS=	-ldl		\
			-lstdc++

LOCAL_DEBUG_FLAGS=
