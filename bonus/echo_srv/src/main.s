	[BITS 64]

	%assign SYSCALL_EXIT	60

	section .text

	global _start, __end
	extern _check_numeric, _invalid_arguments

	;; Entry
_start:
	cmp byte [rsp], 2		; Check number of arguments
	jne _invalid_arguments

	mov rdi, [rsp + 16]
	jmp _check_numeric

__end:
	;; Exit
	mov rax, SYSCALL_EXIT
	syscall
