%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global rawmemchr

rawmemchr:
	xor rcx, rcx		; Set rcx to 0
_rawmemchr_loop_start:
	cmp [rdi + rcx], sil
	je _rawmemchr_found
	inc rcx
	jmp _rawmemchr_loop_start	; Loop
_rawmemchr_found:
	mov rax, rdi
	add rax, rcx
	ret

%elifidn __OUTPUT_FORMAT__, elf32
		[BITS 32]
		section .text
		global rawmemchr

rawmemchr:
	push ebp
	mov ebp, esp
	mov eax, [ebp + 8]
	mov ebx, [ebp + 12]
	xor ecx, ecx

_rawmemchr_loop_start:
	cmp byte bl, [eax + ecx]
	je _rawmemchr_found
	inc ecx
	jmp _rawmemchr_loop_start

_rawmemchr_found:
	pop ebp
	ret
%else
		%error "Architecture not supported"
%endif