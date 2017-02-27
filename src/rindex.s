%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global rindex

rindex:
	xor rcx, rcx		; Set rcx to 0
_rindex_loop_start:
	mov byte al, [rdi + rcx]
	cmp al, 0
	je _rindex_search_loop
	inc rcx
	jmp _rindex_loop_start
	;; We are now at the end of the string
_rindex_search_loop:
	mov byte al, [rdi + rcx]
	cmp al, sil
	je _rindex_found
	cmp rcx, 0
	je _rindex_not_found
	dec rcx
	jmp _rindex_search_loop
_rindex_found:
	mov rax, rdi
	add rax, rcx
	jmp _rindex_leave
_rindex_not_found:
	xor rax, rax
_rindex_leave:
	ret

%elifidn __OUTPUT_FORMAT__, elf32
		[BITS 32]
		section .text
		global rindex
rindex:
	push ebp
	mov ebp, esp
	mov eax, [ebp + 8]
	mov ecx, [ebp + 12]
	xor edx, edx

_rindex_loop_start:
	cmp byte [eax + edx], 0
	je _rindex_search_loop
	inc edx
	jmp _rindex_loop_start

_rindex_search_loop:
	cmp byte [eax + edx], cl
	je _rindex_found
	cmp edx, 0
	je _rindex_not_found
	dec edx
	jmp _rindex_search_loop

_rindex_found:
	add eax, edx
	jmp _rindex_leave
_rindex_not_found:
	xor eax, eax
_rindex_leave:
	pop ebp
	ret
%else
		%error "Architecture not supported"
%endif