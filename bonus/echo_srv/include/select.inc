%ifndef SELECT_INC_
%define SELECT_INC_

	%assign SYSCALL_SELECT	23
	%assign LONG_SIZE	8
	%assign NFDBITS		(LONG_SIZE * 8)
	%assign _FD_SET_SIZE	1024
	%assign FD_SET_SIZE	(((_FD_SET_SIZE) + ((NFDBITS) - 1)) / (NFDBITS))

	;; We prefix fd_set with s_ because of the macro FD_SET
	struc s_fd_set
		.fd		resq 2 * FD_SET_SIZE
	endstruc

	struc timeval
		.tv_sec		resd 2
		.tv_usec	resd 2
	endstruc

%endif