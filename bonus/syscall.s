%ifidn __OUTPUT_FORMAT__, elf64
	[BITS 64]
	section .text
;; Define a syscall
%macro  set_syscall 2
	global %2

%2:
	mov rax, %1
	syscall
	ret
%endmacro
set_syscall 0, read
set_syscall 1, write
set_syscall 2, open
set_syscall 3, close
set_syscall 4, stat
set_syscall 5, fstat
set_syscall 6, lstat
set_syscall 7, poll
set_syscall 8, lseek
set_syscall 9, mmap
set_syscall 10, mprotect
set_syscall 11, munmap
set_syscall 12, brk
set_syscall 13, rt_sigaction
set_syscall 14, rt_sigprocmask
set_syscall 15, rt_sigreturn
set_syscall 16, ioctl
set_syscall 17, pread64
set_syscall 18, pwrite64
set_syscall 19, readv
set_syscall 20, writev
set_syscall 21, access
set_syscall 22, pipe
set_syscall 23, select
set_syscall 24, sched_yield
set_syscall 25, mremap
set_syscall 26, msync
set_syscall 27, mincore
set_syscall 28, madvise
set_syscall 29, shmget
set_syscall 30, shmat
set_syscall 31, shmctl
set_syscall 32, dup
set_syscall 33, dup2
set_syscall 34, pause
set_syscall 35, nanosleep
set_syscall 36, getitimer
set_syscall 37, alarm
set_syscall 38, setitimer
set_syscall 39, getpid
set_syscall 40, sendfile
set_syscall 41, socket
set_syscall 42, connect
set_syscall 43, accept
set_syscall 44, sendto
set_syscall 45, recvfrom
set_syscall 46, sendmsg
set_syscall 47, recvmsg
set_syscall 48, shutdown
set_syscall 49, bind
set_syscall 50, listen
set_syscall 51, getsockname
set_syscall 52, getpeername
set_syscall 53, socketpair
set_syscall 54, setsockopt
set_syscall 55, getsockopt
set_syscall 56, clone
set_syscall 57, fork
set_syscall 58, vfork
set_syscall 59, execve
set_syscall 60, exit
set_syscall 61, wait4
set_syscall 62, kill
set_syscall 63, uname
set_syscall 64, semget
set_syscall 65, semop
set_syscall 66, semctl
set_syscall 67, shmdt
set_syscall 68, msgget
set_syscall 69, msgsnd
set_syscall 70, msgrcv
set_syscall 71, msgctl
set_syscall 72, fcntl
set_syscall 73, flock
set_syscall 74, fsync
set_syscall 75, fdatasync
set_syscall 76, truncate
set_syscall 77, ftruncate
set_syscall 78, getdents
set_syscall 79, getcwd
set_syscall 80, chdir
set_syscall 81, fchdir
set_syscall 82, rename
set_syscall 83, mkdir
set_syscall 84, rmdir
set_syscall 85, creat
set_syscall 86, link
set_syscall 87, unlink
set_syscall 88, symlink
set_syscall 89, readlink
set_syscall 90, chmod
set_syscall 91, fchmod
set_syscall 92, chown
set_syscall 93, fchown
set_syscall 94, lchown
set_syscall 95, umask
set_syscall 96, gettimeofday
set_syscall 97, getrlimit
set_syscall 98, getrusage
set_syscall 99, sysinfo
;set_syscall 100, times
set_syscall 101, ptrace
set_syscall 102, getuid
set_syscall 103, syslog
set_syscall 104, getgid
set_syscall 105, setuid
set_syscall 106, setgid
set_syscall 107, geteuid
set_syscall 108, getegid
set_syscall 109, setpgid
set_syscall 110, getppid
set_syscall 111, getpgrp
set_syscall 112, setsid
set_syscall 113, setreuid
set_syscall 114, setregid
set_syscall 115, getgroups
set_syscall 116, setgroups
set_syscall 117, setresuid
set_syscall 118, getresuid
set_syscall 119, setresgid
set_syscall 120, getresgid
set_syscall 121, getpgid
set_syscall 122, setfsuid
set_syscall 123, setfsgid
set_syscall 124, getsid
set_syscall 125, capget
set_syscall 126, capset
set_syscall 127, rt_sigpending
set_syscall 128, rt_sigtimedwait
set_syscall 129, rt_sigqueueinfo
set_syscall 130, rt_sigsuspend
set_syscall 131, sigaltstack
set_syscall 132, utime
set_syscall 133, mknod
set_syscall 134, uselib
set_syscall 135, personality
set_syscall 136, ustat
set_syscall 137, statfs
set_syscall 138, fstatfs
set_syscall 139, sysfs
set_syscall 140, getpriority
set_syscall 141, setpriority
set_syscall 142, sched_setparam
set_syscall 143, sched_getparam
set_syscall 144, sched_setscheduler
set_syscall 145, sched_getscheduler
set_syscall 146, sched_get_priority_max
set_syscall 147, sched_get_priority_min
set_syscall 148, sched_rr_get_interval
set_syscall 149, mlock
set_syscall 150, munlock
set_syscall 151, mlockall
set_syscall 152, munlockall
set_syscall 153, vhangup
set_syscall 154, modify_ldt
set_syscall 155, pivot_root
set_syscall 156, _sysctl
set_syscall 157, prctl
set_syscall 158, arch_prctl
set_syscall 159, adjtimex
set_syscall 160, setrlimit
set_syscall 161, chroot
set_syscall 162, sync
set_syscall 163, acct
set_syscall 164, settimeofday
set_syscall 165, mount
set_syscall 166, umount2
set_syscall 167, swapon
set_syscall 168, swapoff
set_syscall 169, reboot
set_syscall 170, sethostname
set_syscall 171, setdomainname
set_syscall 172, iopl
set_syscall 173, ioperm
set_syscall 174, create_module
set_syscall 175, init_module
set_syscall 176, delete_module
set_syscall 177, get_kernel_syms
set_syscall 178, query_module
set_syscall 179, quotactl
set_syscall 180, nfsservctl
set_syscall 181, getpmsg
set_syscall 182, putpmsg
set_syscall 183, afs_syscall
set_syscall 184, tuxcall
set_syscall 185, security
set_syscall 186, gettid
set_syscall 187, readahead
set_syscall 188, setxattr
set_syscall 189, lsetxattr
set_syscall 190, fsetxattr
set_syscall 191, getxattr
set_syscall 192, lgetxattr
set_syscall 193, fgetxattr
set_syscall 194, listxattr
set_syscall 195, llistxattr
set_syscall 196, flistxattr
set_syscall 197, removexattr
set_syscall 198, lremovexattr
set_syscall 199, fremovexattr
set_syscall 200, tkill
set_syscall 201, time
set_syscall 202, futex
set_syscall 203, sched_setaffinity
set_syscall 204, sched_getaffinity
set_syscall 205, set_thread_area
set_syscall 206, io_setup
set_syscall 207, io_destroy
set_syscall 208, io_getevents
set_syscall 209, io_submit
set_syscall 210, io_cancel
set_syscall 211, get_thread_area
set_syscall 212, lookup_dcookie
set_syscall 213, epoll_create
set_syscall 214, epoll_ctl_old
set_syscall 215, epoll_wait_old
set_syscall 216, remap_file_pages
set_syscall 217, getdents64
set_syscall 218, set_tid_address
set_syscall 219, restart_syscall
set_syscall 220, semtimedop
set_syscall 221, fadvise64
set_syscall 222, timer_create
set_syscall 223, timer_settime
set_syscall 224, timer_gettime
set_syscall 225, timer_getoverrun
set_syscall 226, timer_delete
set_syscall 227, clock_settime
set_syscall 228, clock_gettime
set_syscall 229, clock_getres
set_syscall 230, clock_nanosleep
set_syscall 231, exit_group
set_syscall 232, epoll_wait
set_syscall 233, epoll_ctl
set_syscall 234, tgkill
set_syscall 235, utimes
set_syscall 236, vserver
set_syscall 237, mbind
set_syscall 238, set_mempolicy
set_syscall 239, get_mempolicy
set_syscall 240, mq_open
set_syscall 241, mq_unlink
set_syscall 242, mq_timedsend
set_syscall 243, mq_timedreceive
set_syscall 244, mq_notify
set_syscall 245, mq_getsetattr
set_syscall 246, kexec_load
set_syscall 247, waitid
set_syscall 248, add_key
set_syscall 249, request_key
set_syscall 250, keyctl
set_syscall 251, ioprio_set
set_syscall 252, ioprio_get
set_syscall 253, inotify_init
set_syscall 254, inotify_add_watch
set_syscall 255, inotify_rm_watch
set_syscall 256, migrate_pages
set_syscall 257, openat
set_syscall 258, mkdirat
set_syscall 259, mknodat
set_syscall 260, fchownat
set_syscall 261, futimesat
set_syscall 262, newfstatat
set_syscall 263, unlinkat
set_syscall 264, renameat
set_syscall 265, linkat
set_syscall 266, symlinkat
set_syscall 267, readlinkat
set_syscall 268, fchmodat
set_syscall 269, faccessat
set_syscall 270, pselect6
set_syscall 271, ppoll
set_syscall 272, unshare
set_syscall 273, set_robust_list
set_syscall 274, get_robust_list
set_syscall 275, splice
set_syscall 276, tee
set_syscall 277, sync_file_range
set_syscall 278, vmsplice
set_syscall 279, move_pages
set_syscall 280, utimensat
set_syscall 281, epoll_pwait
set_syscall 282, signalfd
set_syscall 283, timerfd_create
set_syscall 284, eventfd
set_syscall 285, fallocate
set_syscall 286, timerfd_settime
set_syscall 287, timerfd_gettime
set_syscall 288, accept4
set_syscall 289, signalfd4
set_syscall 290, eventfd2
set_syscall 291, epoll_create1
set_syscall 292, dup3
set_syscall 293, pipe2
set_syscall 294, inotify_init1
set_syscall 295, preadv
set_syscall 296, pwritev
set_syscall 297, rt_tgsigqueueinfo
set_syscall 298, perf_event_open
set_syscall 299, recvmmsg
set_syscall 300, fanotify_init
set_syscall 301, fanotify_mark
set_syscall 302, prlimit64
set_syscall 303, name_to_handle_at
set_syscall 304, open_by_handle_at
set_syscall 305, clock_adjtime
set_syscall 306, syncfs
set_syscall 307, sendmmsg
set_syscall 308, setns
set_syscall 309, getcpu
set_syscall 310, process_vm_readv
set_syscall 311, process_vm_writev
set_syscall 312, kcmp
set_syscall 313, finit_module
set_syscall 314, sched_setattr
set_syscall 315, sched_getattr
set_syscall 316, renameat2
set_syscall 317, seccomp
set_syscall 318, getrandom
set_syscall 319, memfd_create
set_syscall 320, kexec_file_load
set_syscall 321, bpf
set_syscall 322, execveat
set_syscall 323, userfaultfd
set_syscall 324, membarrier
set_syscall 325, mlock2
set_syscall 326, copy_file_range
set_syscall 327, preadv2
set_syscall 328, pwritev2
%elifidn __OUTPUT_FORMAT__, elf32
	[BITS 32]
	section .text
%macro  set_syscall 2
	global %2

%2:
	push ebp
	mov ebp, esp
	mov eax, %1
	mov ebx, [ebp + 8]
	mov ecx, [ebp + 12]
	mov edx, [ebp + 16]
	int 0x80
	pop ebp
	ret
%endmacro

set_syscall 0, restart_syscall
set_syscall 1, exit
set_syscall 2, fork
set_syscall 3, read
set_syscall 4, write
set_syscall 5, open
set_syscall 6, close
set_syscall 7, waitpid
set_syscall 8, creat
set_syscall 9, link
set_syscall 10, unlink
set_syscall 11, execve
set_syscall 12, chdir
set_syscall 13, time
set_syscall 14, mknod
set_syscall 15, chmod
set_syscall 16, lchown
set_syscall 17, break
set_syscall 18, oldstat
set_syscall 19, lseek
set_syscall 20, getpid
set_syscall 21, mount
set_syscall 22, umount
set_syscall 23, setuid
set_syscall 24, getuid
set_syscall 25, stime
set_syscall 26, ptrace
set_syscall 27, alarm
set_syscall 28, oldfstat
set_syscall 29, pause
set_syscall 30, utime
set_syscall 31, stty
set_syscall 32, gtty
set_syscall 33, access
set_syscall 34, nice
set_syscall 35, ftime
set_syscall 36, sync
set_syscall 37, kill
set_syscall 38, rename
set_syscall 39, mkdir
set_syscall 40, rmdir
set_syscall 41, dup
set_syscall 42, pipe
;set_syscall 43, times
set_syscall 44, prof
set_syscall 45, brk
set_syscall 46, setgid
set_syscall 47, getgid
set_syscall 48, signal
set_syscall 49, geteuid
set_syscall 50, getegid
set_syscall 51, acct
set_syscall 52, umount2
;set_syscall 53, lock
set_syscall 54, ioctl
set_syscall 55, fcntl
set_syscall 56, mpx
set_syscall 57, setpgid
set_syscall 58, ulimit
set_syscall 59, oldolduname
set_syscall 60, umask
set_syscall 61, chroot
set_syscall 62, ustat
set_syscall 63, dup2
set_syscall 64, getppid
set_syscall 65, getpgrp
set_syscall 66, setsid
set_syscall 67, sigaction
set_syscall 68, sgetmask
set_syscall 69, ssetmask
set_syscall 70, setreuid
set_syscall 71, setregid
set_syscall 72, sigsuspend
set_syscall 73, sigpending
set_syscall 74, sethostname
set_syscall 75, setrlimit
set_syscall 76, getrlimit
set_syscall 77, getrusage
set_syscall 78, gettimeofday
set_syscall 79, settimeofday
set_syscall 80, getgroups
set_syscall 81, setgroups
set_syscall 82, select
set_syscall 83, symlink
set_syscall 84, oldlstat
set_syscall 85, readlink
set_syscall 86, uselib
set_syscall 87, swapon
set_syscall 88, reboot
set_syscall 89, readdir
set_syscall 90, mmap
set_syscall 91, munmap
set_syscall 92, truncate
set_syscall 93, ftruncate
set_syscall 94, fchmod
set_syscall 95, fchown
set_syscall 96, getpriority
set_syscall 97, setpriority
set_syscall 98, profil
set_syscall 99, statfs
set_syscall 100, fstatfs
set_syscall 101, ioperm
set_syscall 102, socketcall
set_syscall 103, syslog
set_syscall 104, setitimer
set_syscall 105, getitimer
set_syscall 106, stat
set_syscall 107, lstat
set_syscall 108, fstat
set_syscall 109, olduname
set_syscall 110, iopl
set_syscall 111, vhangup
set_syscall 112, idle
set_syscall 113, vm86old
set_syscall 114, wait4
set_syscall 115, swapoff
set_syscall 116, sysinfo
set_syscall 117, ipc
set_syscall 118, fsync
set_syscall 119, sigreturn
set_syscall 120, clone
set_syscall 121, setdomainname
set_syscall 122, uname
set_syscall 123, modify_ldt
set_syscall 124, adjtimex
set_syscall 125, mprotect
set_syscall 126, sigprocmask
set_syscall 127, create_module
set_syscall 128, init_module
set_syscall 129, delete_module
set_syscall 130, get_kernel_syms
set_syscall 131, quotactl
set_syscall 132, getpgid
set_syscall 133, fchdir
set_syscall 134, bdflush
set_syscall 135, sysfs
set_syscall 136, personality
set_syscall 137, afs_syscall
set_syscall 138, setfsuid
set_syscall 139, setfsgid
set_syscall 140, _llseek
set_syscall 141, getdents
set_syscall 142, _newselect
set_syscall 143, flock
set_syscall 144, msync
set_syscall 145, readv
set_syscall 146, writev
set_syscall 147, getsid
set_syscall 148, fdatasync
set_syscall 149, _sysctl
set_syscall 150, mlock
set_syscall 151, munlock
set_syscall 152, mlockall
set_syscall 153, munlockall
set_syscall 154, sched_setparam
set_syscall 155, sched_getparam
set_syscall 156, sched_setscheduler
set_syscall 157, sched_getscheduler
set_syscall 158, sched_yield
set_syscall 159, sched_get_priority_max
set_syscall 160, sched_get_priority_min
set_syscall 161, sched_rr_get_interval
set_syscall 162, nanosleep
set_syscall 163, mremap
set_syscall 164, setresuid
set_syscall 165, getresuid
set_syscall 166, vm86
set_syscall 167, query_module
set_syscall 168, poll
set_syscall 169, nfsservctl
set_syscall 170, setresgid
set_syscall 171, getresgid
set_syscall 172, prctl
set_syscall 173, rt_sigreturn
set_syscall 174, rt_sigaction
set_syscall 175, rt_sigprocmask
set_syscall 176, rt_sigpending
set_syscall 177, rt_sigtimedwait
set_syscall 178, rt_sigqueueinfo
set_syscall 179, rt_sigsuspend
set_syscall 180, pread64
set_syscall 181, pwrite64
set_syscall 182, chown
set_syscall 183, getcwd
set_syscall 184, capget
set_syscall 185, capset
set_syscall 186, sigaltstack
set_syscall 187, sendfile
set_syscall 188, getpmsg
set_syscall 189, putpmsg
set_syscall 190, vfork
set_syscall 191, ugetrlimit
set_syscall 192, mmap2
set_syscall 193, truncate64
set_syscall 194, ftruncate64
set_syscall 195, stat64
set_syscall 196, lstat64
set_syscall 197, fstat64
set_syscall 198, lchown32
set_syscall 199, getuid32
set_syscall 200, getgid32
set_syscall 201, geteuid32
set_syscall 202, getegid32
set_syscall 203, setreuid32
set_syscall 204, setregid32
set_syscall 205, getgroups32
set_syscall 206, setgroups32
set_syscall 207, fchown32
set_syscall 208, setresuid32
set_syscall 209, getresuid32
set_syscall 210, setresgid32
set_syscall 211, getresgid32
set_syscall 212, chown32
set_syscall 213, setuid32
set_syscall 214, setgid32
set_syscall 215, setfsuid32
set_syscall 216, setfsgid32
set_syscall 217, pivot_root
set_syscall 218, mincore
set_syscall 219, madvise
set_syscall 220, getdents64
set_syscall 221, fcntl64
set_syscall 224, gettid
set_syscall 225, readahead
set_syscall 226, setxattr
set_syscall 227, lsetxattr
set_syscall 228, fsetxattr
set_syscall 229, getxattr
set_syscall 230, lgetxattr
set_syscall 231, fgetxattr
set_syscall 232, listxattr
set_syscall 233, llistxattr
set_syscall 234, flistxattr
set_syscall 235, removexattr
set_syscall 236, lremovexattr
set_syscall 237, fremovexattr
set_syscall 238, tkill
set_syscall 239, sendfile64
set_syscall 240, futex
set_syscall 241, sched_setaffinity
set_syscall 242, sched_getaffinity
set_syscall 243, set_thread_area
set_syscall 244, get_thread_area
set_syscall 245, io_setup
set_syscall 246, io_destroy
set_syscall 247, io_getevents
set_syscall 248, io_submit
set_syscall 249, io_cancel
set_syscall 250, fadvise64
set_syscall 252, exit_group
set_syscall 253, lookup_dcookie
set_syscall 254, epoll_create
set_syscall 255, epoll_ctl
set_syscall 256, epoll_wait
set_syscall 257, remap_file_pages
set_syscall 258, set_tid_address
set_syscall 259, timer_create
set_syscall 260, timer_settime
set_syscall 261, timer_gettime
set_syscall 262, timer_getoverrun
set_syscall 263, timer_delete
set_syscall 264, clock_settime
set_syscall 265, clock_gettime
set_syscall 266, clock_getres
set_syscall 267, clock_nanosleep
set_syscall 268, statfs64
set_syscall 269, fstatfs64
set_syscall 270, tgkill
set_syscall 271, utimes
set_syscall 272, fadvise64_64
set_syscall 273, vserver
set_syscall 274, mbind
set_syscall 275, get_mempolicy
set_syscall 276, set_mempolicy
set_syscall 277, mq_open
set_syscall 278, mq_unlink
set_syscall 279, mq_timedsend
set_syscall 280, mq_timedreceive
set_syscall 281, mq_notify
set_syscall 282, mq_getsetattr
set_syscall 283, kexec_load
set_syscall 284, waitid
set_syscall 286, add_key
set_syscall 287, request_key
set_syscall 288, keyctl
set_syscall 289, ioprio_set
set_syscall 290, ioprio_get
set_syscall 291, inotify_init
set_syscall 292, inotify_add_watch
set_syscall 293, inotify_rm_watch
set_syscall 294, migrate_pages
set_syscall 295, openat
set_syscall 296, mkdirat
set_syscall 297, mknodat
set_syscall 298, fchownat
set_syscall 299, futimesat
set_syscall 300, fstatat64
set_syscall 301, unlinkat
set_syscall 302, renameat
set_syscall 303, linkat
set_syscall 304, symlinkat
set_syscall 305, readlinkat
set_syscall 306, fchmodat
set_syscall 307, faccessat
set_syscall 308, pselect6
set_syscall 309, ppoll
set_syscall 310, unshare
set_syscall 311, set_robust_list
set_syscall 312, get_robust_list
set_syscall 313, splice
set_syscall 314, sync_file_range
set_syscall 315, tee
set_syscall 316, vmsplice
set_syscall 317, move_pages
set_syscall 318, getcpu
set_syscall 319, epoll_pwait
set_syscall 320, utimensat
set_syscall 321, signalfd
set_syscall 322, timerfd_create
set_syscall 323, eventfd
set_syscall 324, fallocate
set_syscall 325, timerfd_settime
set_syscall 326, timerfd_gettime
set_syscall 327, signalfd4
set_syscall 328, eventfd2
set_syscall 329, epoll_create1
set_syscall 330, dup3
set_syscall 331, pipe2
set_syscall 332, inotify_init1
set_syscall 333, preadv
set_syscall 334, pwritev
set_syscall 335, rt_tgsigqueueinfo
set_syscall 336, perf_event_open
set_syscall 337, recvmmsg
set_syscall 338, fanotify_init
set_syscall 339, fanotify_mark
set_syscall 340, prlimit64
set_syscall 341, name_to_handle_at
set_syscall 342, open_by_handle_at
set_syscall 343, clock_adjtime
set_syscall 344, syncfs
set_syscall 345, sendmmsg
set_syscall 346, setns
set_syscall 347, process_vm_readv
set_syscall 348, process_vm_writev
set_syscall 349, kcmp
set_syscall 350, finit_module
set_syscall 351, sched_setattr
set_syscall 352, sched_getattr
set_syscall 353, renameat2
set_syscall 354, seccomp
set_syscall 355, getrandom
set_syscall 356, memfd_create
set_syscall 357, bpf
set_syscall 358, execveat
set_syscall 359, socket
set_syscall 360, socketpair
set_syscall 361, bind
set_syscall 362, connect
set_syscall 363, listen
set_syscall 364, accept4
set_syscall 365, getsockopt
set_syscall 366, setsockopt
set_syscall 367, getsockname
set_syscall 368, getpeername
set_syscall 369, sendto
set_syscall 370, sendmsg
set_syscall 371, recvfrom
set_syscall 372, recvmsg
set_syscall 373, shutdown
set_syscall 374, userfaultfd
set_syscall 375, membarrier
set_syscall 376, mlock2
set_syscall 377, copy_file_range
set_syscall 378, preadv2
set_syscall 379, pwritev2
%else
%error "Architecture not supported"
%endif