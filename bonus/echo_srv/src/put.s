	[BITS 64]
	section .text
	global put

	extern strlen

	%assign SYSCALL_WRITE	1

	;; void	put(const char * const str)
	;; Displays a string
put:
	mov rax, rdi
	push rdi
	mov rdi, rax
	call strlen
	pop rdi
	mov rdx, rax		; Get string's length
	mov rsi, rdi
	mov rdi, 1
	mov rax, SYSCALL_WRITE
	syscall
	ret
