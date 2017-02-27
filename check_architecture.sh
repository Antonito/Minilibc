#!/bin/sh
## check_architecture.sh for minilibc in Code/School/asm_minilibc
##
## Made by Antoine Baché
## Login   <antoine.bache@epitech.net>
##
## Started on  Mon Feb 27 11:37:18 2017 Antoine Baché
## Last update Mon Feb 27 11:37:34 2017 Antoine Baché
##

if [ "$1" = "" ]
then
    printf "Usage: %s <file>\n" "%$0"
    exit 1
fi

objdump -x "$1" | grep architecture: | cut -d " " -f 2 | cut -d "," -f 1
