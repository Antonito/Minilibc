%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global strstr

strstr:
	xor rdx, rdx
_strstr_haystack_loop_start:
	mov byte al, [rdi + rdx]
	cmp al, 0
	je _strstr_haystack_loop_end
	cmp al, sil
	je _strstr_needle_loop_init
	inc rdx
	jmp _strstr_haystack_loop_start
_strstr_haystack_loop_end:
	xor rax, rax
	ret

_strstr_needle_loop_init:
	xor rcx, rcx
_strstr_needle_loop_start:
	mov byte r9b, [rsi + rcx]
	cmp r9b, 0x0			;check if we reach "needle" end
	je _strstr_needle_loop_end
	mov r10, [rdx + rcx]
	mov r11, [rdi + r10]		;actual char of "haystack"
	mov byte r8b, [r11]
	cmp r8b, 0			;check if we reach "haystack" end
	je _strstr_needle_loop_end
	cmp r8b, r9b
	jne _strstr_haystack_loop_start
	inc rcx
	jmp _strstr_needle_loop_start
_strstr_needle_loop_end:
	mov rax, rdi
	add rax, rdx
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
