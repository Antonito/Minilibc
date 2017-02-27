	[BITS 64]
	section .text
	global strlen

	;; Calculate the length of a strin
	;; size_t strlen(char *)
strlen:
	xor rcx, rcx

_strlen_loop_start:
	cmp byte [rdi + rcx], 0
	je _strlen_end_loop
	add rcx, 1
	jmp _strlen_loop_start
_strlen_end_loop:
	mov rax, rcx
	ret
