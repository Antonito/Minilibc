	[BITS 64]

	section .text

	%include "select.inc"

	global fd_cpy, fd_zero, fd_set, _fd_set, fd_isset

	;; Copy a s_fd_set
	;; rdi -> dest
	;; rsi -> src
fd_cpy:
	xor rcx, rcx
_fd_cpy_loop:
	cmp rcx, FD_SET_SIZE
	je _fd_cpy_loop_end
	mov rax, [rsi + rcx * 8]
	mov qword [rdi + rcx * 8], rax
	inc rcx
	jmp _fd_cpy_loop
_fd_cpy_loop_end:
	ret

	;; FD_ZERO() macro of select
fd_zero:
	xor rcx, rcx
_fd_zero_loop:
	cmp rcx, FD_SET_SIZE
	je _fd_zero_loop_end
	mov qword [rdi + rcx * 8], 0x0
	inc rcx
	jmp _fd_zero_loop
_fd_zero_loop_end:
	ret

	;; FD_SET() macro of select
	;; rdi -> fd
	;; rsi -> s_fd_set
_fd_set:
fd_set:
	mov rcx, rdi
	shr rdi, 6
	and rcx, 63

	mov rax, 1
	shl rax, cl
	or [rsi + 8 * rdi], rax
	ret

	;; FD_ISSET() macro of select
	;; rdi -> fd
	;; rsi -> set
fd_isset:
	mov rcx, rdi
	shr rdi, 6		; Index

	and rcx, 63		; Modulo

	mov rbx, 1
	shl rbx, cl		; Mask

	mov rax, [rsi + 8 * rdi]

	and rax, rbx
	test rax, rax
	jz _fd_isset_none
	mov rax, 1
	ret
_fd_isset_none:
	xor rax, rax
	ret
