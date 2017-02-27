/*
** minilibc.h for minilibc in Documents/Code/School/asm_minilibc
**
** Made by Antoine Baché
** Login   <antoinebache@epitech.net>
**
** Started on  Mon Feb 27 11:39:05 2017 Antoine Baché
** Last update Mon Feb 27 11:39:14 2017 Antoine Baché
*/

#ifndef	MINILIBC_H_
# define MINILIBC_H_

# include <stdint.h>

# if INTPTR_MAX == INT64_MAX
typedef unsigned long int	size_t;
typedef signed long int		ssize_t;
# elif INTPTR_MAX == INT32_MAX
typedef unsigned int	size_t;
typedef signed int		ssize_t;
# else
#  error Architecture not supported
# endif

/*
** String.h
*/
void		*memcpy(void *, const void *, size_t);
void		*memmove(void *, const void *, size_t);
void		*memset(void *, int, size_t);
size_t		strcspn(const char *, const char *);
size_t		strlen(const char *);
int		strcmp(const char *, const char *);
int		strncmp(const char *, const char *, size_t);
char		*strpbrk(const char *, const char *);
char		*strstr(const char *, const char *);
char		*strchr(const char *, int);
int		strcasecmp(const char *, const char *);
char		*rindex(const char *, int);

/*
** Bonus
*/
size_t		strnlen(const char *, size_t);
int		memcmp(const void *, const void *, size_t);
void		*memchr(const void *, int, size_t);
void		*rawmemchr(const void *, int);

/*
** Syscalls
*/

ssize_t		write(int, const void *, size_t);
void		exit(int);

#endif /* !MINILIBC_H_ */
