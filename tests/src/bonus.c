/*
** bonus.c for minilibc in asm_minilibc
**
** Made by Antoine Baché
** Login   <antoine.bache@epitech.net>
**
** Started on  Mon Feb 27 11:43:34 2017 Antoine Baché
** Last update Thu Mar  2 20:58:44 2017 Antoine Baché
*/

#define _GNU_SOURCE
#include <string.h>
#include <stdio.h>
#include <stdint.h>
#include "minilibc_test.h"

void		test_rawmemchr(t_functions * const tests)
{
  char		arr[256];
  uintptr_t	ret_libc;
  uintptr_t	ret_minilibc;

  arr[200] = 0x23;
  if (setjmp(jbuf) == 0)
    {
      ret_libc = (uintptr_t)tests[RAWMEMCHR].libc(arr, 0x23);
      ret_minilibc = (uintptr_t)tests[RAWMEMCHR].minilibc(arr, 0x23);
      printf("%s: Libc[%lu] MiniLibC[%lu]: %s\n", tests[RAWMEMCHR].name,
	     ret_libc, ret_minilibc, (ret_libc != ret_minilibc) ? KO : OK);
    }
}

void		test_memchr(t_functions * const tests)
{
  char		arr[256];
  uintptr_t	ret_libc;
  uintptr_t	ret_minilibc;

  memset(arr, 0x00, sizeof(arr));
  if (setjmp(jbuf) == 0)
    {
      ret_libc = (uintptr_t)tests[MEMCHR].libc(arr, 0x23, sizeof(arr));
      ret_minilibc = (uintptr_t)tests[MEMCHR].minilibc(arr, 0x23, sizeof(arr));
      printf("%s: Libc[%lu] MiniLibC[%lu]: %s\n", tests[MEMCHR].name,
	     ret_libc, ret_minilibc, (ret_libc != ret_minilibc) ? KO : OK);
      arr[200] = 0x23;
      ret_libc = (uintptr_t)tests[MEMCHR].libc(arr, 0x23, sizeof(arr));
      ret_minilibc = (uintptr_t)tests[MEMCHR].minilibc(arr, 0x23, sizeof(arr));
      printf("%s: Libc[%lu] MiniLibC[%lu]: %s\n", tests[MEMCHR].name,
	     ret_libc, ret_minilibc, (ret_libc != ret_minilibc) ? KO : OK);
    }
}

/*
** Il faudrait comparer 4 a 4 pour etre 100% compliant
*/
void		test_memcmp(t_functions * const tests)
{
  char		arr[256];
  char		arr2[512];
  int		ret_libc;
  int		ret_minilibc;

  memset(arr, 0xFF, sizeof(arr));
  memset(arr2, 0xFF, sizeof(arr2));
  if (setjmp(jbuf) == 0)
    {
      ret_libc = (uintptr_t)tests[MEMCMP].libc(arr, arr2, sizeof(arr));
      ret_minilibc = (uintptr_t)tests[MEMCMP].minilibc(arr, arr2, sizeof(arr));
      printf("%s: Libc[%d] MiniLibC[%d]: %s\n", tests[MEMCMP].name,
	     ret_libc, ret_minilibc, (ret_libc != ret_minilibc) ? KO : OK);
      arr[255] = 0xAB;
      ret_libc = (uintptr_t)tests[MEMCMP].libc(arr, arr2, sizeof(arr));
      ret_minilibc = (uintptr_t)tests[MEMCMP].minilibc(arr, arr2, sizeof(arr));
      printf("%s:  Libc[%d] MiniLibC[%d]: %s\n", tests[MEMCMP].name,
	     ret_libc, ret_minilibc, (ret_libc != ret_minilibc) ? KO : OK);
      arr[3] = 0;
      ret_libc = (uintptr_t)tests[MEMCMP].libc(arr, arr2, sizeof(arr));
      ret_minilibc = (uintptr_t)tests[MEMCMP].minilibc(arr, arr2, sizeof(arr));
      printf("%s: Libc[%d] MiniLibC[%d]: %s\n", tests[MEMCMP].name,
	     ret_libc , ret_minilibc, (ret_libc != ret_minilibc) ? KO : OK);
    }
}

void		test_strnlen(t_functions * const tests)
{
  int		i;
  size_t	ret_libc;
  size_t	ret_minilibc;

  i = 0;
  while (((void **)(tests[STRLEN].args))[i])
    {
      ret_libc =
	(size_t)tests[STRNLEN].libc(((void **)(tests[STRNLEN].args))[i], 100);
      ret_minilibc =
	(size_t)tests[STRNLEN].minilibc(((void **)(tests[STRNLEN].args))[i], 100);
      printf("%s: {100} Libc[%lu] MiniLibC[%lu]: %s\n", tests[STRNLEN].name,
	     ret_libc, ret_minilibc, (ret_libc != ret_minilibc) ? KO : OK);
      ret_libc =
	(size_t)tests[STRNLEN].libc(((void **)(tests[STRNLEN].args))[i], 5);
      ret_minilibc =
	(size_t)tests[STRNLEN].minilibc(((void **)(tests[STRNLEN].args))[i], 5);
      printf("%s: {Len: 5} Libc[%lu] MiniLibC[%lu]: %s\n", tests[STRNLEN].name,
	     ret_libc, ret_minilibc, (ret_libc != ret_minilibc) ? KO : OK);
      ++i;
    }
}

void		test_write(t_functions * const tests)
{
  const char	str[] = "Tototatatiti\n";

  tests[WRITE].minilibc(1, str, strlen(str));
  tests[WRITE].minilibc(1, "\n", 1);
  tests[WRITE].minilibc(1, str, 5);
  tests[WRITE].minilibc(1, "\n", 1);
}

void		test_sleep(t_functions * const tests)
{
  printf("sleep: Waiting 1sec [libc]\n");
  tests[SLEEP].libc(1);
  if (setjmp(jbuf) == 0)
    {
      printf("sleep: Waiting 1sec [minilibc]\n");
      tests[SLEEP].minilibc(1);
    }
  printf("sleep: Done\n");
}

void		test_exit(t_functions * const tests)
{
  printf("Should exit");
  tests[EXIT].minilibc(9);
  printf("Ce message ne devrait pas apparaitre.\n");
}

void		test_memfrob(t_functions * const tests)
{
  char		buff[256];
  char		buff2[256];

  if (setjmp(jbuf) == 0)
    {
      memset(buff, 0x72, sizeof(buff));
      memset(buff2, 0x72, sizeof(buff2));
      memfrob(buff, sizeof(buff));
      tests[MEMFROB].minilibc(buff2, sizeof(buff2));
      printf("%s: %s\n", tests[MEMFROB].name,
	     (!memcmp(buff, buff2, sizeof(buff))) ? OK : KO);
    }
}
