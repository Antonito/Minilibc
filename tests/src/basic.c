/*
** basic.c for minilibc in asm_minilibc
**
** Made by Antoine Baché
** Login   <antoine.bache@epitech.net>
**
** Started on  Mon Feb 27 11:43:08 2017 Antoine Baché
** Last update Thu Mar 16 20:23:22 2017 Antoine Baché
*/

#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <stdio.h>
#include <stdint.h>
#include "minilibc_test.h"

void		test_memmove(t_functions * const tests)
{
  size_t	i;
  char		arr1[256];
  char		arr2[258];

  memset(arr1, 0x54, sizeof(arr1));
  memset(arr2, 0x54, sizeof(arr2));
  arr2[0] = 0x42;
  arr2[257] = 0x42;
  if (setjmp(jbuf) == 0)
    {
      tests[MEMMOVE].minilibc(arr2 + 1, arr1, sizeof(arr1));
      assert(arr2[0] == arr2[257] && arr2[0] == 0x42);
      printf("%s: Backward %s\n", tests[MEMMOVE].name,
	     memcmp(arr1, arr2 + 1, sizeof(arr1)) ? KO : OK);
      i = -1;
      while (++i < sizeof(arr1))
	{
	  if (!(i & 2))
	    arr1[i] = arr2[i] = 0x23;
	  else if (!(i & 3))
	    arr1[i] = arr2[i] = 0x98;
	  else
	    arr1[i] = arr2[i] = 0xFA;
	}
      memmove(arr1, arr1 + 2, sizeof(arr1) - 2);
      tests[MEMMOVE].minilibc(arr2, arr2 + 2, sizeof(arr1) - 2);
      printf("%s: Forward %s\n", tests[MEMMOVE].name,
	     memcmp(arr1, arr2, sizeof(arr1)) ? KO : OK);
      memmove(arr1, arr1, sizeof(arr1));
      tests[MEMMOVE].minilibc(arr2, arr2, sizeof(arr2));
      printf("%s: Same %s\n", tests[MEMMOVE].name,
	     memcmp(arr1, arr2, sizeof(arr1)) ? KO : OK);
      memmove(arr1, "(null)", 0);
      tests[MEMMOVE].minilibc(arr2, "(null)", 0);
      printf("%s: Extra %s\n", tests[MEMMOVE].name,
	     memcmp(arr1, arr2, sizeof(arr1)) ? KO : OK);
    }
  else
    {
      printf("memmove: "KO"\n");
    }
}

void		test_memcpy(t_functions * const tests)
{
  char		arr1[256];
  char		arr2[258];

  memset(arr1, 0x54, sizeof(arr1));
  arr2[0] = 0x42;
  arr2[257] = 0x42;
  if (setjmp(jbuf) == 0)
    {
      tests[MEMCPY].minilibc(arr2 + 1, arr1, sizeof(arr1));
      assert(arr2[0] == arr2[257] && arr2[0] == 0x42);
      printf("%s: %s\n", tests[MEMCPY].name,
	     memcmp(arr1, arr2 + 1, sizeof(arr1)) ? KO : OK);
    }
  else
    {
      printf("memcpy: "KO"\n");
    }
}

void		test_memset(t_functions * const tests)
{
  size_t	i;
  int		garbage[64];
  int		buff[64];

  if (setjmp(jbuf) == 0)
    {
      memset(buff, 0x0, sizeof(buff));
      memset(garbage, 0x54, sizeof(garbage));
      tests[MEMSET].minilibc(buff, 0x54, sizeof(buff));
      printf("memset: %s\n", (!memcmp(garbage, buff, sizeof(buff))) ? OK : KO);
    }
  else
    {
      printf("memset: "KO"\n");
    }
}

void		test_strlen(t_functions * const tests)
{
  int		i;
  size_t	ret_libc;
  size_t	ret_minilibc;

  i = 0;
  while (((void **)(tests[STRLEN].args))[i])
    {
      if (setjmp(jbuf) == 0)
	{
	  ret_libc =
	    (size_t)tests[STRLEN].libc(((void **)(tests[STRLEN].args))[i]);
	  ret_minilibc =
	    (size_t)tests[STRLEN].minilibc(((void **)(tests[STRLEN].args))[i]);
	  printf("%s: Libc[%lu] MiniLibC[%lu]: %s\n", tests[STRLEN].name,
		 ret_libc, ret_minilibc, (ret_libc != ret_minilibc) ? KO : OK);
	}
      ++i;
    }
}

void		test_strcmp(t_functions * const tests)
{
  int		i;
  int		ret_libc;
  int		ret_minilibc;
  static char	*s1[] = {"Toto", "Tata", "wdsawdsawdsad\tasdad", "nice",
			 "a", "A", "\xFF", "\x00", "\x34\x00", NULL};
  static char	*s2[] = {"Tata", "Toto", "wdsawdsawdsad\0asdad", "nice",
			 "A", "a", "\x00", "\xFF", "\x76\x23", NULL};

  i = 0;
  if (setjmp(jbuf) == 0)
    {
      while (s1[i])
	{
	  ret_libc = (uintptr_t)tests[STRCMP].libc(s1[i], s2[i]);
	  ret_minilibc = (uintptr_t)tests[STRCMP].minilibc(s1[i], s2[i]);
	  printf("%s: Libc[%d] MiniLibC[%d]: %s\n", tests[STRCMP].name,
		 ret_libc, ret_minilibc, (ret_libc != ret_minilibc) ? KO : OK);
	  ++i;
	}
    }
  else
    {
      printf("strcmp: "KO"\n");
    }
}
