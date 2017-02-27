/*
** medium.c for minilibc in /asm_minilibc
**
** Made by Antoine Baché
** Login   <antoine.bache@epitech.net>
**
** Started on  Mon Feb 27 11:44:36 2017 Antoine Baché
** Last update Mon Feb 27 11:44:50 2017 Antoine Baché
*/

#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <stdio.h>
#include <stdint.h>
#include "minilibc_test.h"

void		test_strcasecmp(t_functions * const tests)
{
  int		i;
  int		ret_libc;
  int		ret_minilibc;
  static char	*s1[] = {"Toto", "Tata", "wdsawdsawdsad\tasdad", "nice",
			 "a", "A", "aaaw", "AaAaA\xFF", "\x00",  "a", NULL};
  static char	*s2[] = {"Tata", "Toto", "wdsawdsawdsad\0asdad", "nice",
			 "A", "a", "aaaB", "aaaaa", "\xFF", "z", NULL};

  i = 0;
  while (s1[i])
    {
      ret_libc = (uintptr_t)tests[STRCASECMP].libc(s1[i], s2[i]);
      ret_minilibc = (uintptr_t)tests[STRCASECMP].minilibc(s1[i], s2[i]);
      printf("%s: Libc[%d] MiniLibC[%d]: %s\n", tests[STRCASECMP].name,
	     ret_libc, ret_minilibc, (ret_libc != ret_minilibc) ? KO : OK);
      ++i;
    }
}

void		test_rindex(t_functions * const tests)
{
  int		i;
  static char	locate[] = {'t', 'e', 'r', 'S', '0'};
  char		*ret_libc;
  char		*ret_minilibc;
  const char	**strings;

  i = 0;
  strings = tests[RINDEX].args;
  while (strings[i])
    {
      ret_libc = tests[RINDEX].libc(strings[i], locate[i]);
      ret_minilibc = tests[RINDEX].minilibc(strings[i], locate[i]);
      printf("%s: Libc[%p] MiniLibC[%p]: %s\n", tests[RINDEX].name,
	     ret_libc, ret_minilibc, (ret_libc != ret_minilibc) ? KO : OK);
      ++i;
    }
}

void		test_strncmp(t_functions * const tests)
{
  int		i;
  int		ret_libc;
  int		ret_minilibc;
  static char	*s1[] = {"Toto", "Tata", "wdsawdsawdsad\tasdad", "nice",
			 "a", "A", "aaaw", NULL};
  static char	*s2[] = {"Tata", "Toto", "wdsawdsawdsad\0asdad", "nice",
			 "A", "a", "aaaB", NULL};

  i = 0;
  while (s1[i])
    {
      ret_libc = (uintptr_t)tests[STRNCMP].libc(s1[i], s2[i], strlen(s1[i]));
      ret_minilibc = (uintptr_t)tests[STRNCMP].minilibc(s1[i], s2[i],
							strlen(s1[i]));
      printf("%s: {strlen} Libc[%d] MiniLibC[%d]: %s\n", tests[STRNCMP].name,
	     ret_libc, ret_minilibc, (ret_libc != ret_minilibc) ? KO : OK);
      ret_libc = (uintptr_t)tests[STRNCMP].libc(s1[i], s2[i], 3);
      ret_minilibc = (uintptr_t)tests[STRNCMP].minilibc(s1[i], s2[i], 3);
      printf("%s: {len: 3} Libc[%d] MiniLibC[%d]: %s\n", tests[STRNCMP].name,
	     ret_libc, ret_minilibc, (ret_libc != ret_minilibc) ? KO : OK);
      ++i;
    }
}
