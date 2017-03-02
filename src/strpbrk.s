%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global strpbrk

strpbrk:
	xor rdx, rdx		; Set rdx to 0
	cmp byte [rdi], 0
	je _strpbrk_s_loop_end
	cmp byte [rsi], 0
	je _strpbrk_s_loop_end
_strpbrk_s_loop_start:
	cmp byte [rdi + rdx], 0
	je _strpbrk_s_loop_end
	jmp _strpbrk_accept_loop_init
_strpbrk_s_loop_inc:
	inc rdx
	jmp _strpbrk_s_loop_start
_strpbrk_s_loop_end:
	xor rax, rax		; Set return value
	ret

_strpbrk_accept_loop_init:
	xor rcx, rcx		; Set rcx to 0
_strpbrk_accept_loop_start:
	cmp byte [rsi + rcx], 0
	je _strpbrk_s_loop_inc	; increment count (first loop) and continue
	mov byte r8b, [rdi + rdx]
	cmp byte r8b, [rsi + rcx]
	je _strpbrk_accept_loop_end
	inc rcx
	jmp _strpbrk_accept_loop_start
_strpbrk_accept_loop_end:
	mov rax, rdi
	add rax, rdx
	ret
%elifidn __OUTPUT_FORMAT__, elf32
		[BITS 32]
		section .text
		global strpbrk
strpbrk:
%warning "To code !"
	ret
%else
		%error "Architecture not supported"
%endif
