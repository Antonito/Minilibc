/*
** advanced.c for minilibc in School/asm_minilibc
**
** Made by Antoine Baché
** Login   <antoine.bache@epitech.net>
**
** Started on  Mon Feb 27 11:42:39 2017 Antoine Baché
** Last update Thu Mar 16 21:04:17 2017 Antoine Baché
*/

#include <stdio.h>
#include "minilibc_test.h"

void		test_strstr(t_functions * const tests)
{
  char		*haystack[] = {"Bonjour cacao j'aime les ...", "Toto",
			       "Ceci est un test", "\0", "\0", "Salutsalutsalutsalut",
			       "z", "", "toto", "Hello darling...", NULL};
  char		*needle[] = {"cacao", "asd", "\0", "a", "\0", "z",
			     "Salutsalutsalutsalut", "\1", "toto", "darling", NULL};
  char		*res;
  char		*real_res;
  int		i;

  i = 0;
  while (needle[i] || haystack[i])
    {
      if (setjmp(jbuf) == 0)
	{
	  res = tests[STRSTR].minilibc(haystack[i], needle[i]);
	  real_res = strstr(haystack[i], needle[i]);
	  printf("%s: Libc[%s] MiniLibC[%s] %s\n",
		 tests[STRSTR].name, real_res, res,
		 (res != real_res) ? KO : OK);
	}
      ++i;
    }
}

void		test_strpbrk(t_functions * const tests)
{
  char		*s[] = {"0123456789ABCDEF", "AAB", "a", "\0", NULL};
  char		*reject[] = {"F5", "C", "\0", "\0", NULL};
  char		*res;
  char		*real_res;
  int		i;

  i = 0;
  while (s[i])
    {
      if (setjmp(jbuf) == 0)
	{
	  res = tests[STRPBRK].minilibc(s[i], reject[i]);
	  real_res = strpbrk(s[i], reject[i]);
	  printf("%s: Libc[%s] MiniLibC[%s] %s\n",
		 tests[STRPBRK].name, real_res, res,
		 (res != real_res) ? KO : OK);
	}
      ++i;
    }
}

void		test_strcspn(t_functions * const tests)
{
  char		*s[] = {"0123456789ABCDEF", "ASDW", "a", "\0", NULL};
  char		*reject[] = {"45", "Q", "\0", "\0", NULL};
  size_t	res;
  size_t	real_res;
  int		i;

  i = 0;
  while (s[i])
    {
      if (setjmp(jbuf) == 0)
	{
	  res = (uintptr_t)tests[STRCSPN].minilibc(s[i], reject[i]);
	  real_res = strcspn(s[i], reject[i]);
	  printf("%s: Libc[%lu] MiniLibC[%lu] %s\n", tests[STRCSPN].name,
		 real_res, res, (res != real_res) ? KO : OK);
	}
      ++i;
    }
}
