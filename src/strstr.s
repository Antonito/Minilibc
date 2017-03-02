%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global strstr

strstr:
	xor rdx, rdx			; set haystck counter to 0
	cmp byte [rsi], 0
	je _strstr_return_haystack
	cmp byte [rdi], 0
	je _strstr_haystack_loop_end
_strstr_haystack_loop_start:
	mov byte al, [rdi + rdx]	; get haystack char into al
	cmp al, 0			; if we reach the end
	je _strstr_haystack_loop_end	; the end, we did not find needle
	cmp byte al, [rsi]		; if haystack[i] == needle[0]
	je _strstr_needle_loop_init
	inc rdx				; inc haystack counter
	jmp _strstr_haystack_loop_start
_strstr_haystack_loop_end:
	xor rax, rax			; return haystack
	ret

_strstr_return_haystack:
	mov rax, rdi
	ret

_strstr_needle_loop_init:
	xor rcx, rcx			; set needle counter to 0
_strstr_needle_loop_start:
	mov byte r9b, [rsi + rcx]	; get needle char into r9b
	cmp r9b, 0x0			; check if we reach "needle" end
	je _strstr_needle_loop_end
	mov r10, rdx
	add r10, rcx
	mov byte r8b, [rdi + r10]	; actual char of "haystack"
	cmp r8b, 0			; check if we reach "haystack" end
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
