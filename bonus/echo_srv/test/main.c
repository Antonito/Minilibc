#include <sys/select.h>
#include <string.h>
#include <stdio.h>

#define	howmany(x, y)	(((x)+((y)-1))/(y))

void	fd_zero(fd_set *);
void	_fd_set(int, fd_set *);
void	fd_cpy(fd_set *, fd_set *);
int	fd_isset(int, fd_set *);

void	print_fd_set(fd_set *fd)
{
  size_t	i;
  unsigned char	*tmp;

  i = 0;
  tmp = (unsigned char *)fd;
  while (i < sizeof(fd_set))
    {
      if (!(i % 16))
	printf("\n");
      printf("%.2x ", tmp[i]);
      ++i;
    }
  printf("\n");
}

int	main()
{
  fd_set	readfds;
  fd_set	cmp;
  fd_set	non_init;

  FD_ZERO(&readfds);
  fd_zero(&cmp);

  printf("Sizeof -> %ld\n", sizeof(fd_mask));
  printf("FD-> %d | NFD -> %d\n", FD_SETSIZE, NFDBITS);
  printf("FD_SET_SIZE -> %d\n", howmany(FD_SETSIZE, NFDBITS));

  printf("Cmp: %d\n", memcmp(&readfds, &cmp, sizeof(fd_set)));
  print_fd_set(&readfds);
  print_fd_set(&cmp);


  memset(&non_init, 0x45, sizeof(fd_set));
  fd_cpy(&cmp, &non_init);
  printf("Cmp: %d\n", memcmp(&non_init, &cmp, sizeof(fd_set)));
  print_fd_set(&non_init);
  print_fd_set(&cmp);

  FD_ZERO(&readfds);
  fd_zero(&cmp);
  asm volatile("nop; nop;");
  FD_SET(67, &readfds);
  FD_SET(670, &readfds);
  FD_SET(12, &readfds);
  FD_SET(4, &readfds);
  asm volatile("nop; nop;");
  _fd_set(67, &cmp);
  _fd_set(670, &cmp);
  _fd_set(12, &cmp);
  _fd_set(4, &cmp);

  printf("Cmp: %d\n", memcmp(&readfds, &cmp, sizeof(fd_set)));
  print_fd_set(&readfds);
  print_fd_set(&cmp);

  printf("Cmp: REAL: %d Mine: %d\n", FD_ISSET(67, &readfds),
	 fd_isset(67, &readfds));
  printf("Cmp: REAL: %d Mine: %d\n", FD_ISSET(5, &readfds),
	 fd_isset(5, &readfds));

  return (0);
}
