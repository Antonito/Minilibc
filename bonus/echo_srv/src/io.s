	[BITS 64]

	%include "client.inc"

	section .text

	global io_read, io_write

	extern put, disconnect_client

io_read:
	cmp byte [rdi + client.sent], 0
	je _io_write_end
	mov byte [rdi + client.sent], 0

	push rdi
	lea rsi, [rdi + client.buff]
	mov rdi, [rdi]
	mov rax, 0
	mov rdx, 1024
	syscall
	pop rdi
	mov [rdi + client.read], rax
	cmp rax, 0
	jne _io_read_end

	;; Disonnect
	dec r12
	call disconnect_client
	mov rax, 1
	ret

_io_read_end:
	xor rax, rax
	ret

io_write:
	cmp byte [rdi + client.sent], 1
	je _io_write_end
	mov byte [rdi + client.sent], 1
	mov rcx, rdi
	mov rax, 1
	mov rdi, [rdi]
	lea rsi, [rcx + client.buff]
	mov dword edx, [rcx + client.read]
	syscall
_io_write_end:
	ret

	section .data

	debug_write db "Ready to write !", 0x0A, 0x00
	debug_read db "Ready to read !", 0x0A, 0x00
	_welcome_msg db "Welcome.", 0x0A, 0x00
