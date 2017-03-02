/*
** main.c for minilibc in asm_minilibc
**
** Made by Antoine Baché
** Login   <antoine.bache@epitech.net>
**
** Started on  Mon Feb 27 11:44:12 2017 Antoine Baché
** Last update Thu Mar  2 21:00:32 2017 Antoine Baché
*/

#define _GNU_SOURCE
#include <dlfcn.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <unistd.h>
#include <strings.h>
#include <signal.h>
#include "minilibc_test.h"

jmp_buf			jbuf;

static char		*strings[] =
  {
    "Toto",
    "Heeeeeeeyyyy"
    "",
    "AWesom1234567ytrfsd\n",
    "Awe\0Some\0",
    "0123456789ABCDEF\0GHIJKL",
    NULL
  };

static t_functions	tests[] =
  {
    {NULL, (void *(*)())memcpy, NULL, NULL},
    {NULL, (void *(*)())memmove, NULL, NULL},
    {NULL, (void *(*)())memset, NULL, NULL},
    {NULL, (void *(*)())strchr, NULL, NULL},
    {NULL, (void *(*)())strcmp, NULL, NULL},
    {NULL, (void *(*)())strlen, NULL, strings},
    {NULL, (void *(*)())strncmp, NULL, NULL},
    {NULL, (void *(*)())rindex, NULL, strings},
    {NULL, (void *(*)())strcasecmp, NULL, NULL},
    {NULL, (void *(*)())strstr, NULL, NULL},
    {NULL, (void *(*)())strpbrk, NULL, NULL},
    {NULL, (void *(*)())strcspn, NULL, NULL},
    {NULL, (void *(*)())memchr, NULL, NULL},
    {NULL, (void *(*)())memcmp, NULL, NULL},
    {NULL, (void *(*)())strnlen, NULL, strings},
    {NULL, (void *(*)())write, NULL, NULL},
    {NULL, (void *(*)())sleep, NULL, NULL},
    {NULL, (void *(*)())memfrob, NULL, NULL},
    {NULL, (void *(*)())exit, NULL, NULL},
    {NULL, (void *(*)())rawmemchr, NULL, NULL},
    {NULL, NULL, NULL, NULL}
  };

void		test_strchr()
{
  int		i;
  static char	locate[] = {'t', 'e', 'r', 'S', '0'};
  char		*ret_libc;
  char		*ret_minilibc;

  i = 0;
  while (strings[i])
    {
      if (setjmp(jbuf) == 0)
	{
	  ret_libc = tests[STRCHR].libc(strings[i], locate[i]);
	  ret_minilibc = tests[STRCHR].minilibc(strings[i], locate[i]);
	  printf("%s: Libc[%p] MiniLibC[%p]: %s\n", tests[STRCHR].name,
		 ret_libc, ret_minilibc, (ret_libc != ret_minilibc) ? KO : OK);
	}
      ++i;
    }
}

int			load_symbols(void * const file)
{
  size_t		i;
  static const char	*symbols[] =
    {"memcpy", "memmove", "memset", "strchr", "strcmp", "strlen",
     "strncmp", "rindex", "strcasecmp", "strstr", "strpbrk", "strcspn",
     "memchr", "memcmp", "strnlen", "write", "sleep", "memfrob",
     "exit", "rawmemchr",
     NULL};

  i = 0;
  while (i < LAST_FUNC)
    {
      tests[i].name = symbols[i];
      tests[i].minilibc = dlsym(file, symbols[i]);
      if (!tests[i].minilibc)
	{
	  return (EXIT_FAILURE);
	}
      ++i;
    }
  return (EXIT_SUCCESS);
}

void		sigsev_handler(int sig)
{
  (void)sig;
  printf(RED"Segfault !\n"CLEAR);
  signal(SIGSEGV, sigsev_handler);
  longjmp(jbuf, 1);
}

int			main(int ac, char **av, char **env)
{
  void			*file;

  (void)ac;
  (void)av;
  (void)env;
  signal(SIGSEGV, sigsev_handler);
  file = dlopen("./libasm.so", RTLD_NOW);
  if (!file || load_symbols(file))
    {
      write(2, "Error: Cannot load library\n", 28);
      return (EXIT_FAILURE);
    }
  test_strlen(tests);
  test_memset(tests);
  test_strcmp(tests);
  test_memcpy(tests);
  test_strchr();
  test_memmove(tests);
  test_strncmp(tests);
  test_rindex(tests);
  test_strcasecmp(tests);
  test_strstr(tests);
  test_strpbrk(tests);
  test_strcspn(tests);
  test_memchr(tests);
  test_memcmp(tests);
  test_strnlen(tests);
  test_write(tests);
  test_sleep(tests);
  test_memfrob(tests);
  test_rawmemchr(tests);
  test_exit(tests);
  return (EXIT_SUCCESS);
}
