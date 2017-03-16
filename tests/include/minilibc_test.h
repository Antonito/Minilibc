/*
** minilibc_test.h for minilibc in /asm_minilibc
**
** Made by Antoine Baché
** Login   <antoine.bache@epitech.net>
**
** Started on  Mon Feb 27 11:41:27 2017 Antoine Baché
** Last update Thu Mar 16 15:24:37 2017 troncy_l
*/

#ifndef MINILIBC_TEST_H_
#define MINILIBC_TEST_H_

#define _GNU_SOURCE
#include <setjmp.h>
#include <string.h>
#include "debug.h"
#include "minilibc.h"

#define OK	GREEN_BOLD_INTENS"OK"CLEAR
#define KO	RED_BOLD_INTENS"KO"CLEAR

extern jmp_buf	jbuf;

typedef enum	e_func_list
  {
    MEMCPY	= 0,
    MEMMOVE,
    MEMSET,
    STRCHR,
    STRCMP,
    STRLEN,
    STRNCMP,
    RINDEX,
    STRCASECMP,
    STRSTR,
    STRPBRK,
    STRCSPN,
    MEMCHR,
    MEMCMP,
    STRNLEN,
    WRITE,
    MEMFROB,
    EXIT,
    RAWMEMCHR,
    LAST_FUNC
  }		t_func_list;

typedef struct	s_functions
{
  const char	*name;
  void		*(*libc)();
  void		*(*minilibc)();
  void		*args;
}		t_functions;

/*
** Tests
*/
void		test_memmove(t_functions *);
void		test_memcpy(t_functions *);
void		test_memset(t_functions *);
void		test_strlen(t_functions *);
void		test_strcmp(t_functions *);
void		test_strncmp(t_functions *);
void		test_rindex(t_functions *);
void		test_strcasecmp(t_functions *);
void		test_strstr(t_functions *);
void		test_strpbrk(t_functions *);
void		test_strcspn(t_functions *);

/*
** Bonus
*/
void		test_memchr(t_functions *);
void		test_memcmp(t_functions *);
void		test_strnlen(t_functions *);
void		test_write(t_functions *);
void		test_sleep(t_functions *);
void		test_memfrob(t_functions *);
void		test_rawmemchr(t_functions *);
void		test_exit(t_functions *);

#endif /* ! MINILIBC_TEST_H_ */
