%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global strstr

strstr:
	mov rdx, -1			; set haystck counter to 0
	cmp byte [rsi], 0
	je _strstr_return_haystack
	cmp byte [rdi], 0
	je _strstr_haystack_loop_end
_strstr_haystack_loop_start:
        inc rdx
	mov byte al, [rdi + rdx]	; get haystack char into al
	cmp al, 0			; if we reach the end
	je _strstr_haystack_loop_end	; the end, we did not find needle
	cmp byte al, [rsi]		; if haystack[i] == needle[0]
	je _strstr_needle_loop_init
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
        push ebp
        mov ebp, esp
        mov edi, [ebp + 8]
        mov esi, [ebp + 12]
	mov edx, -1			; set haystck counter to 0
	cmp byte [esi], 0
	je _strstr_return_haystack
	cmp byte [edi], 0
	je _strstr_haystack_loop_end
_strstr_haystack_loop_start:
        inc edx
	mov byte al, [edi + edx]	; get haystack char into al
	cmp al, 0			; if we reach the end
	je _strstr_haystack_loop_end	; the end, we did not find needle
	cmp byte al, [esi]		; if haystack[i] == needle[0]
	je _strstr_needle_loop_init
	jmp _strstr_haystack_loop_start
_strstr_haystack_loop_end:
	xor eax, eax			; return haystack
        pop ebp
	ret

_strstr_return_haystack:
	mov eax, edi
        pop ebp
	ret

_strstr_needle_loop_init:
	xor ecx, ecx			; set needle counter to 0
_strstr_needle_loop_start:
	mov byte ah, [esi + ecx]	; get needle char into r9b
	cmp ah, 0x0			; check if we reach "needle" end
	je _strstr_needle_loop_end
	add edx, ecx
	mov al, [edi + edx]	; actual char of "haystack"
        sub edx, ecx
	cmp al, 0			; check if we reach "haystack" end
	je _strstr_needle_loop_end
	cmp al, ah
	jne _strstr_haystack_loop_start
	inc ecx
	jmp _strstr_needle_loop_start
_strstr_needle_loop_end:
	mov eax, edi
	add eax, edx
        pop ebp
	ret
%else
		%error "Architecture not supported"
%endif
