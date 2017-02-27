%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global strlen

strlen:
	xor rcx, rcx		; Set rcx to 0
_strlen_loop_start:
	cmp byte [rdi + rcx], 0
	je _strlen_loop_end
	inc rcx
	jmp _strlen_loop_start
_strlen_loop_end:
	mov rax, rcx		; Set return value
	ret

%elifidn __OUTPUT_FORMAT__, elf32
		[BITS 32]
		section .text
		global strlen
strlen:
	push ebp		; Save stack frame
	mov ebp, esp
	mov eax, [ebp + 8]	; Get first argument
	xor ecx, ecx
_strlen_loop_start:
	cmp byte [eax + ecx], 0
	je _strlen_loop_end
	inc ecx
	jmp _strlen_loop_start
_strlen_loop_end:
	mov eax, ecx
	pop ebp			; Restore stack frame
	ret
%else
		%error "Architecture not supported"
%endif