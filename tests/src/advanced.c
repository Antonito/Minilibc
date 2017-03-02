/*
** advanced.c for minilibc in School/asm_minilibc
**
** Made by Antoine Baché
** Login   <antoine.bache@epitech.net>
**
** Started on  Mon Feb 27 11:42:39 2017 Antoine Baché
** Last update Thu Mar 02 17:22:21 2017 troncy_l
*/

#include "minilibc_test.h"

void		test_strstr(t_functions * const tests)
{
  char		*haystack = "Bonjour cacao j'aime les ...";
  char		*needle = "cacao";
  char		*res;
  char		*real_res;

  res = tests[STRSTR].minilibc(haystack, needle);
  real_res = strstr(haystack, needle);
  printf("%s: Libc[%s] MiniLibC[%s] %s\n", tests[STRSTR].name, real_res, res, (res != real_res) ? KO : OK );
}

void		test_strpbrk(t_functions * const tests)
{
  char		*s = "0123456789ABCDEF";
  char		*reject = "F5";
  char		*res;
  char		*real_res;

  res = tests[STRPBRK].minilibc(s, reject);
  real_res = strpbrk(s, reject);
  printf("%s: Libc[%c] MiniLibC[%c] %s\n", tests[STRPBRK].name, *real_res, *res, (res != real_res) ? KO : OK );
}

void		test_strcspn(t_functions * const tests)
{
  char		*s = "0123456789ABCDEF";
  char		*reject = "45";
  size_t	res;
  size_t	real_res;

  res = tests[STRCSPN].minilibc(s, reject);
  real_res = strcspn(s, reject);
  printf("%s: %s\n", tests[STRCSPN].name, (res != real_res) ? KO : OK );
}
