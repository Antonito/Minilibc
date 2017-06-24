#include <benchmark/benchmark.h>
#include <dlfcn.h>
#include <string.h>
#include <strings.h>

void *file = dlopen("./libasm.so", RTLD_NOW);

char strlen_str[] = "This literal is a test for (mini)libc's strlen"
                    "function.\n";
char strcmp_str[] = "This literal is a test for (mini)libc's strlen"
                    "functi2n.\n";

/*
** Functions
*/
void *(*minilibc_memcpy)(void *, void *,
                         size_t) = (void *(*)(void *, void *,
                                              size_t))dlsym(file, "memcpy");
void *(*minilibc_memmove)(void *, void *,
                          size_t) = (void *(*)(void *, void *,
                                               size_t))dlsym(file, "memmove");
void *(*minilibc_memset)(void *, int,
                         size_t) = (void *(*)(void *, int,
                                              size_t))dlsym(file, "memset");
char *(*minilibc_strchr)(char *, int) = (char *(*)(char *, int))dlsym(file,
                                                                      "strchr");
size_t (*minilibc_strlen)(char *) = (size_t(*)(char *))dlsym(file, "strlen");
int (*minilibc_strcmp)(char *,
                       char *) = (int (*)(char *, char *))dlsym(file, "strcmp");
int (*minilibc_strncmp)(char *,
			char *, int) = (int (*)(char *, char *, int))dlsym(file, "strncmp");
char *(*minilibc_rindex)(char *, int) = (char *(*)(char *, int))dlsym(file, "rindex");

static void BM_libc_memset(benchmark::State &state) {
  char arr[256];

  while (state.KeepRunning())
    memset(arr, 0x54, sizeof(arr));
}

static void BM_minilibc_memset(benchmark::State &state) {
  char arr[256];

  assert(file);
  while (state.KeepRunning())
    minilibc_memset(arr, 0x54, sizeof(arr));
}

static void BM_libc_strlen(benchmark::State &state) {
  while (state.KeepRunning())
    (void)strlen(strlen_str);
}

static void BM_minilibc_strlen(benchmark::State &state) {
  assert(file);
  while (state.KeepRunning())
    minilibc_strlen(strlen_str);
}

static void BM_libc_strcmp(benchmark::State &state) {
  while (state.KeepRunning())
    (void)strcmp(strlen_str, strcmp_str);
}

static void BM_minilibc_strcmp(benchmark::State &state) {
  assert(file);
  while (state.KeepRunning())
    minilibc_strcmp(strlen_str, strcmp_str);
}

static void BM_libc_strchr(benchmark::State &state) {
  while (state.KeepRunning())
    (void)strchr(strlen_str, '\n');
}

static void BM_minilibc_strchr(benchmark::State &state) {
  assert(file);
  while (state.KeepRunning())
    minilibc_strchr(strlen_str, '\n');
}

static void BM_libc_memcpy(benchmark::State &state) {
  char arr[256];
  char arr2[256];

  memset(arr2, 0x90, sizeof(arr2));
  while (state.KeepRunning())
    memcpy(arr, arr2, sizeof(arr2));
}

static void BM_minilibc_memcpy(benchmark::State &state) {
  char arr[256];
  char arr2[256];

  assert(file);
  memset(arr2, 0x90, sizeof(arr2));
  while (state.KeepRunning())
    minilibc_memcpy(arr, arr2, sizeof(arr2));
}

static void BM_libc_memmove_forward(benchmark::State &state) {
  char arr[256];
  char arr2[256];

  memset(arr2, 0x90, sizeof(arr2));
  while (state.KeepRunning())
    memmove(arr, arr2, sizeof(arr2));
}

static void BM_minilibc_memmove_forward(benchmark::State &state) {
  char arr[256];
  char arr2[256];

  assert(file);
  memset(arr2, 0x90, sizeof(arr2));
  while (state.KeepRunning())
    minilibc_memmove(arr, arr2, sizeof(arr2));
}

static void BM_libc_memmove_backward(benchmark::State &state) {
  char arr[256];

  memset(arr, 0x90, sizeof(arr));
  while (state.KeepRunning())
    memmove(arr, arr + 2, sizeof(arr) - 2 * sizeof(arr[0]));
}

static void BM_minilibc_memmove_backward(benchmark::State &state) {
  char arr[256];

  assert(file);
  memset(arr, 0x90, sizeof(arr));
  while (state.KeepRunning())
    minilibc_memmove(arr, arr + 2, sizeof(arr) - 2 * sizeof(arr[0]));
}

static void BM_libc_strncmp(benchmark::State &state) {
  while (state.KeepRunning())
    (void)strncmp(strlen_str, strcmp_str, 23);
}

static void BM_minilibc_strncmp(benchmark::State &state) {
  assert(file);
  while (state.KeepRunning())
    minilibc_strncmp(strlen_str, strcmp_str, 23);
}

static void BM_libc_rindex(benchmark::State &state) {
  while (state.KeepRunning())
    (void)rindex(strlen_str, '\n');
}

static void BM_minilibc_rindex(benchmark::State &state) {
  assert(file);
  while (state.KeepRunning())
    minilibc_rindex(strlen_str, '\n');
}

/*
** LibC benchmarks
*/
BENCHMARK(BM_libc_memcpy);
BENCHMARK(BM_libc_memmove_forward);
BENCHMARK(BM_libc_memmove_backward);
BENCHMARK(BM_libc_memset);
BENCHMARK(BM_libc_strchr);
BENCHMARK(BM_libc_strcmp);
BENCHMARK(BM_libc_strlen);
BENCHMARK(BM_libc_strncmp);
BENCHMARK(BM_libc_rindex);

/*
** MinilibC benchmarks
*/
BENCHMARK(BM_minilibc_memcpy);
BENCHMARK(BM_minilibc_memmove_forward);
BENCHMARK(BM_minilibc_memmove_backward);
BENCHMARK(BM_minilibc_memset);
BENCHMARK(BM_minilibc_strchr);
BENCHMARK(BM_minilibc_strcmp);
BENCHMARK(BM_minilibc_strlen);
BENCHMARK(BM_minilibc_strncmp);
BENCHMARK(BM_minilibc_rindex);

BENCHMARK_MAIN();
