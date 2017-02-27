%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global memset

memset:
	xor rcx, rcx		; Set rcx to 0
_memset_loop_start:
	cmp rcx, rdx		; Did we reach the end ?
	je _memset_loop_end
	mov byte [rdi + rcx], sil ; Set current byte to desired value
	inc rcx
	jmp _memset_loop_start	; Loop
_memset_loop_end:
	mov rax, rdi		; We return a pointer to the array
	ret

%elifidn __OUTPUT_FORMAT__, elf32
		[BITS 32]
		section .text
		global memset
memset:
	push ebp
	mov ebp, esp
	mov eax, [ebp + 8]
	mov ebx, [ebp + 12]
	mov ecx, [ebp + 16]
	xor edx, edx

_memset_loop_start:
	cmp edx, ecx
	je _memset_loop_end
	mov byte [eax + edx], bl
	inc edx
	jmp _memset_loop_start

_memset_loop_end:
	pop ebp
	ret
%else
		%error "Architecture not supported"
%endif