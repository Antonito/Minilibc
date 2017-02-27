	[BITS 64]
	section .text
	global atoi

	;; Takes a string as parameter and converts it to a number (Beware Endianness)
atoi:
	xor rcx, rcx
	xor rax, rax
_atoi_loop:
	xor rbx, rbx
	mov bl, [rdi + rcx]
	inc rcx

	cmp bl, 0x30
	jb _atoi_end_loop	; < '0' ?
	cmp bl, 0x39
	ja _atoi_end_loop	; > '9' ?

	sub bl, 0x30		; -= '0'
	imul rax, 10		; Multiply rax by 10
	add rax, rbx
	jmp _atoi_loop
_atoi_end_loop:
	ret
