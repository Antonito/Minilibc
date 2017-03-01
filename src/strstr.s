%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global strstr

strstr:
	xor rdx, rdx
_strstr_haystack_loop_start:
	cmp byte [rdi + rdx], 0
	je _strstr_haystack_loop_end
	cmp [rdi + rdx], rsi
	je _strstr_needle_loop_init
	inc rdx
	jmp _strstr_haystack_loop_start
_strstr_haystack_loop_end:
	xor rax, rax
	ret

_strstr_needle_loop_init:
	xor rcx, rcx
_strstr_needle_loop_start:
	cmp byte [rsi + rcx], 0
	je _strstr_needle_loop_end
	mov r9, [rdx + rcx]
	cmp byte [rdi + r9], 0
	je _strstr_needle_loop_end
	mov r8b, [rdi + r9]
	cmp byte r8b, [rsi, rcx]
	jne _strstr_haystack_loop_end
	inc rcx
	jmp _strstr_needle_loop_start
_strstr_needle_loop_end:
	mov rax, rdi
	add rdi, [rdx + rcx]
	ret
	
%elifidn __OUTPUT_FORMAT__, elf32
		[BITS 32]
		section .text
		global strstr
strstr:
%warning "To code !"
	ret
%else
		%error "Architecture not supported"
%endif
