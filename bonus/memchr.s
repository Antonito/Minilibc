%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global memchr

memchr:
	xor rcx, rcx		; Set rcx to 0
	xor rax, rax
_memchr_loop_start:
	cmp rcx, rdx		; Did we reach the end ?
	je _memchr_not_found
	cmp [rdi + rcx], rsi
	je _memchr_found
	inc rcx
	jmp _memchr_loop_start	; Loop
_memchr_found:
	mov rax, rdi
	add rax, rcx
_memchr_not_found:
	ret

%elifidn __OUTPUT_FORMAT__, elf32
		[BITS 32]
		section .text
		global memchr
memchr:
%warning "To code !"
	ret
%else
		%error "Architecture not supported"
%endif