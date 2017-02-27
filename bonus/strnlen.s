%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global strnlen

strnlen:
	xor rcx, rcx		; Set rcx to 0
_strnlen_loop_start:
	cmp rcx, rsi
	jge _strnlen_loop_end
	cmp byte [rdi + rcx], 0
	je _strnlen_loop_end
	inc rcx
	jmp _strnlen_loop_start
_strnlen_loop_end:
	mov rax, rcx		; Set return value
	ret

%elifidn __OUTPUT_FORMAT__, elf32
		[BITS 32]
		section .text
		global strnlen
strnlen:
	push ebp		; Save stack frame
	mov ebp, esp
	mov eax, [ebp + 8]	; Get first argument
	mov ecx, [ebp + 12]
	xor edx, edx
_strnlen_loop_start:
	cmp edx, ecx
	je _strnlen_loop_end
	cmp byte [eax + edx], 0
	je _strnlen_loop_end
	inc edx
	jmp _strnlen_loop_start
_strnlen_loop_end:
	mov eax, edx
	pop ebp			; Restore stack frame
	ret
%else
		%error "Architecture not supported"
%endif