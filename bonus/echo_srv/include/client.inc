%ifndef CLIENT_INC_
%define CLIENT_INC_

%assign SYSCALL_CLOSE	3
%assign SYSCALL_ACCEPT	43

%assign SIZEOF_CLIENT	1

%assign MAX_CLIENT	3

struc client
	.socket	resw	2
	.id	resw	2
	.buff	resb	1024
	.read	resd	1
	.sent	resw	2
endstruc

%endif