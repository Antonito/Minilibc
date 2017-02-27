	[BITS 64]

	global accept_client, disconnect_client, client, clients

	%include "client.inc"

	section .text

	extern put, _accept_error


accept_client:
	mov rax, SYSCALL_ACCEPT
	mov rsi, 0
	mov rdx, 0
	syscall
	cmp rax, 0
	jl _accept_error

	cmp r12, MAX_CLIENT
	je _remove_new_client

	push rax
	mov rdi, new_client_msg
	call put
	pop rax
	jmp _accept_client_end

_remove_new_client:
	mov rdi, rax
	mov rax, SYSCALL_CLOSE
	syscall
	xor rax, rax

_accept_client_end:
	ret

	;; Disconnects a client
	;; Input: client struct
disconnect_client:
	;; Disconnect client
	push rdi
	mov rcx, rdi		; save rdi
	mov rax, SYSCALL_CLOSE
	mov rdi, [rcx]
	syscall
	pop rdi
	mov dword [rdi], 0		; Reset socket to 0

	;; Display to the screen
	mov rdi, byebye_client_msg
	call put
	ret

	section .rodata
	new_client_msg db "New client connected !", 0x0A, 0x00
	byebye_client_msg db "Client disconnected !", 0x0A, 0x00

	section	.data

	clients times MAX_CLIENT * client_size db 0
