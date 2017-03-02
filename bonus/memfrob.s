%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global memfrob

memfrob:
	xor rcx, rcx		; Set rcx to 0
_memfrob_loop_start:
	cmp rcx, rsi		; Did we reach the end ?
	je _memfrob_loop_end
	xor byte [rdi + rcx], 42 ; Set current byte to desired value
	inc rcx
	jmp _memfrob_loop_start	; Loop
_memfrob_loop_end:
	mov rax, rdi		; We return a pointer to the array
	ret

%elifidn __OUTPUT_FORMAT__, elf32
		[BITS 32]
		section .text
		global memfrob
memfrob:
	push ebp
	mov ebp, esp
	mov eax, [ebp + 8]
	mov ebx, [ebp + 12]
	xor edx, edx

_memfrob_loop_start:
	cmp edx, ebx
	je _memfrob_loop_end
	xor byte [eax + edx], 42
	inc edx
	jmp _memfrob_loop_start

_memfrob_loop_end:
	pop ebp
	ret
%else
		%error "Architecture not supported"
%endif