	[BITS 64]
	section .text
	global _invalid_arguments, _socket_create_error, _bind_error, _select_error
	global _listen_error, _accept_error, _read_error, _setsockopt_error

	extern put, __end

;; Invalid argument provided
_invalid_arguments:
	mov rdi, [rsp + 8]
	call put
	mov rdi, invalid_arg_msg
	jmp _print_error

_socket_create_error:
	mov rdi, socket_error_msg
	jmp _print_error

_setsockopt_error:
	mov rdi, setsockopt_error_msg
	jmp _print_error

_bind_error:
	mov rdi, bind_error_msg
	jmp _print_error

_listen_error:
	mov rdi, listen_error_msg
	jmp _print_error

_accept_error:
	mov rdi, accept_error_msg
	jmp _print_error

_read_error:
	mov rdi, read_error_msg
	jmp _print_error

_select_error:
	mov rdi, select_error_msg
	jmp _print_error


	;; General error display
_print_error:
	call put
	mov rdi, 2
	jmp __end

	section .rodata

	invalid_arg_msg db " port", 0x0A, 0x00
	socket_error_msg db "Cannot create socket", 0x0A, 0x00
	setsockopt_error_msg db "Cannot set socket", 0x0A, 0x00
	bind_error_msg db "Cannot bind", 0x0A, 0x00
	listen_error_msg db "Cannot listen", 0x0A, 0x00
	accept_error_msg db "Cannot accept new client. Stopping server", 0x0A, 0x00
	read_error_msg db "Error while reading.", 0x0A, 0x00
	select_error_msg db "An error occured with select(). Stopping server.", 0x0A, 0x00
