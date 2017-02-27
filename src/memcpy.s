%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global memcpy

memcpy:
	xor rcx, rcx		; Set rcx to 0
_memcpy_loop_start:
	cmp rcx, rdx		; Did we reach the end ?
	je _memcpy_loop_end
	mov byte al, [rsi + rcx]
	mov byte [rdi + rcx], al ; Set current byte to desired value
	inc rcx
	jmp _memcpy_loop_start	; Loop
_memcpy_loop_end:
	mov rax, rdi		; We return a pointer to the array
	ret

%elifidn __OUTPUT_FORMAT__, elf32
		[BITS 32]
		section .text
		global memcpy
memcpy:
	push ebp
	mov ebp, esp
	mov eax, [esp + 8]
	mov ecx, [esp + 12]
	mov edx, [esp + 16]
	xor ebx, ebx

_memcpy_loop_start:
	cmp ebx, edx
	je _memcpy_loop_end
	push edx
	mov byte dl, [ecx + ebx]
	mov byte [eax + ebx], dl
	pop edx
	inc ebx
	jmp _memcpy_loop_start

_memcpy_loop_end:
	pop ebp
	ret

%else
		%error "Architecture not supported"
%endif