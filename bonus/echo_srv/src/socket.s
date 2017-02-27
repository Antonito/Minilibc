	[BITS 64]
	section .text
	global create_socket, bind_socket

	%include "client.inc"

	extern _socket_create_error, _setsockopt_error
	extern _bind_error, _listen_error, sin

	%assign AF_INET		2
	%assign SOCK_STREAM	1
	%assign SOL_SOCKET	1
	%assign SO_REUSEADDR	2

	%assign SYSCALL_SOCKET		41
	%assign SYSCALL_SETSOCKOPT	54

	;; Create a TCP socket
	;; Returns a socket
create_socket:
	mov rax, SYSCALL_SOCKET
	mov rdi, AF_INET
	mov rsi, SOCK_STREAM
	mov rdx, 0
	syscall
	cmp rax, 0
	jl _socket_create_error

	mov r12, rax			; Save socket

	;; Allows us to reuse socket before the kernel resets it
	mov rax, SYSCALL_SETSOCKOPT
	mov rdi, r12			; socket
	mov rsi, SOL_SOCKET		; level
	mov rdx, SO_REUSEADDR		; option name
	mov byte [opt_value], 1		; *opt_value = 1
	mov r10, opt_value		; &int i = 1
	mov r8, 4			; sizeof(int)
	syscall
	cmp rax, 0
	jl _setsockopt_error

	;; Returns the socket
	mov rax, r12
	ret

	;; Binds a socket and starts listening
bind_socket:
	;; Bind
	mov rax, 49			; bind()
	mov rsi, sin
	mov rdx, 24			; sockaddr_in_len
	syscall
	cmp rax, 0
	jl _bind_error

	;; Listen
	mov rax, 50			; listen()
	mov rsi, MAX_CLIENT		; Backlog
	syscall
	cmp rax, 0
	jl _listen_error
	ret

	section .bss
	opt_value		resw 2
