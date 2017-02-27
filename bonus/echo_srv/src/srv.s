	;; Syscalls
	%assign SYSCALL_READ	0
	%assign SYSCALL_WRITE	1
	%assign SYSCALL_CLOSE	3

	%include "client.inc"
	%include "select.inc"

	section .text
	global _check_numeric, sin

	;; Tools
	extern __end, strlen, put, atoi, create_socket, accept_client, disconnect_client
	extern clients, io_read, io_write

	extern fd_cpy, fd_zero, fd_set, fd_isset

	;; Errors
	extern _invalid_arguments, bind_socket
	extern _accept_error, _read_error, _select_error


_check_numeric:
	cmp byte [rdi + rcx], 0
	je _check_numeric_passed
	cmp byte [rdi + rcx], 0x30
	jl _invalid_arguments
	cmp byte [rdi + rcx], 0x39
	jg _invalid_arguments
	inc rcx
	jmp _check_numeric
_check_numeric_passed:
	cmp rcx, 0
	je _invalid_arguments		; Check empty parameter
	;; Turn port to number
	call atoi

	;; Change endianness
	mov bl, al
	mov al, ah
	mov ah, bl

	;; Store result to struct
	mov word [sin + sockaddr_in.sin_port], ax

	;; Write port msg
	mov rdi, display_port
	call put

	;; Write port number
	mov rdi, [rsp + 16]
	call put

	;; Write \n
	mov rax, SYSCALL_WRITE
	mov rdi, 1
	mov rsi, backslash_n
	mov rdx, 1
	syscall

	;; Create socket
	call create_socket
	mov [sock], eax			; Save socket

	mov rdi, rax
	call bind_socket

	;; Loop
	;; r12 -> count of clients, preserved even if function call
	;; r13 -> maxFD
	xor r12, r12
_server_loop:
	;; Clear readfds
	mov rdi, readfds
	call fd_zero

	;; Add server's socket to readfds
	mov rdi, [sock]
	mov r13, [sock]
	mov rsi, readfds
	call fd_set

	;; Add each clients
	xor r14, r14
_server_loop_readfds_loop:
	cmp r14, MAX_CLIENT			; Iterate through each client
	je _server_loop_readfds_loop_end

	;; Check if client's socket is greater
	mov rax, client_size
	mov rdx, r14
	mul rdx
	cmp r13, [clients + eax]
	jg _not_maxsock
	mov r13, [clients + eax]
_not_maxsock:
	cmp byte [clients + eax], 0
	jle _do_not_add_sock
	mov rdi, [clients + eax]
	mov rsi, readfds
	call fd_set
_do_not_add_sock:
	inc r14

	jmp _server_loop_readfds_loop
_server_loop_readfds_loop_end:

	;; Set writefds
	mov rdi, writefds
	mov rsi, readfds
	call fd_cpy

	;; Set exceptfds
	mov rdi, exceptfds
	mov rsi, readfds
	call fd_cpy

	;; Set timeout
	mov byte [timeout], 10		; 10 seconds timeout
	mov byte [timeout + 8], 0

	inc r13				; maxfd + 1

	;; Call select
	mov rdi, r13
	mov rsi, readfds
	mov rdx, writefds
	mov r10, exceptfds
	mov qword r8, timeout
	mov rax, SYSCALL_SELECT
	syscall

	cmp rax, 0
	;; Check for error
	jge _no_error_select
	jmp _select_error
_no_error_select:
	jne _no_timeout_select
	;; We time'd out, looping back
	jmp _server_loop

_no_timeout_select:
	;; Check for new connection
	mov rdi, [sock]
	mov rsi, readfds
	call fd_isset
	cmp rax, 0
	je _no_new_client

	;; We have a new client to add
	mov rdi, [sock]
	call accept_client
	cmp rax, 0		; Check any "error"
	je _no_new_client

	;; Find available client
	mov rcx, rax		; Save socket
	xor r15, r15
_add_client_loop:
	mov rax, client_size
	mov rdx, r12
	mul rdx
	cmp dword [clients + eax], 0
	je _add_client_loop_end
	inc r15
	jmp _add_client_loop
_add_client_loop_end:
	mov [clients + eax], rcx
	inc r12			; Increment connected clients counter

_no_new_client:
	xor r14, r14

_io_loop:
	cmp r14, MAX_CLIENT	; Did we check all the players ?
	je _io_loop_end

	mov rax, client_size
	mov rdx, r14
	mul rdx
	cmp dword [clients + eax], 0
	je _io_loop_next

	;; Check read event
	mov rdi, [clients + eax]
	mov rsi, readfds
	call fd_isset
	je _io_check_write

	mov rax, client_size
	mov rdx, r14
	mul rdx
	lea rdi, [clients + eax]
	call io_read
	cmp rax, 0
	jne _io_loop_next	; A client was disconnected, r12 updated

	;; Check write event
_io_check_write:
	mov rax, client_size
	mov rdx, r14
	mul rdx
	mov rdi, [clients + eax]
	mov rsi, writefds
	call fd_isset
	cmp rax, 0
	je _io_check_except

	mov rax, client_size
	mov rdx, r14
	mul rdx
	lea rdi, [clients + eax]
	call io_write

	;; Check except event
_io_check_except:
	mov rax, client_size
	mov rdx, r14
	mul rdx
	mov rdi, [clients + eax]
	mov rsi, exceptfds
	call fd_isset

	cmp rax, 0
	je _io_loop_next
	;; TODO: Call io_except func here

_io_loop_next:
	inc r14
	jmp _io_loop

_io_loop_end:
	jmp _server_loop

	xor rdi, rdi
	jmp __end

	;;;;;;;;;;;;;;;;;;;;;
	;;   Struct def    ;;
	;;;;;;;;;;;;;;;;;;;;;
	struc sockaddr_in
		.sin_family	resw 1
		.sin_port	resw 1
		.sin_addr	resd 1
		.sin_zero	resb 8
	endstruc

	;;;;;;;;;;;;;;;;;;;;;
	;; READ-ONLY data  ;;
	;;;;;;;;;;;;;;;;;;;;;
	section .rodata

	backslash_n db 0x0A
	debug_str db "Debug !", 0x0A, 0x00
	display_port db "Starting server on port ", 0x00

	;;;;;;;;;;;;;;;;;;;;;
	;;       DATA      ;;
	;;;;;;;;;;;;;;;;;;;;;
	section .data
	sin istruc sockaddr_in
	        at sockaddr_in.sin_family, dw 2            ; AF_INET
        	at sockaddr_in.sin_port, dw 0x3930        ; port 12345
        	at sockaddr_in.sin_addr, dd 0             ; localhost
		at sockaddr_in.sin_zero, dd 0, 0
	iend

	timeout istruc timeval
		at timeval.tv_sec, 	dd 0, 0
		at timeval.tv_usec,	dd 0, 0
	iend

	readfds istruc s_fd_set
		at s_fd_set.fd,		TIMES FD_SET_SIZE dq 0
	iend

	writefds istruc s_fd_set
		at s_fd_set.fd,		TIMES FD_SET_SIZE dq 0
	iend

	exceptfds istruc s_fd_set
		at s_fd_set.fd,		TIMES FD_SET_SIZE dq 0
	iend

	;;;;;;;;;;;;;;;;;;;;;
	;;       BSS       ;;
	;;;;;;;;;;;;;;;;;;;;;
	section .bss
	sock		resw 2
