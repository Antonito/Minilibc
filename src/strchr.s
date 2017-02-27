%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global strchr

strchr:
	xor rcx, rcx		; Set rcx to 0
_strchr_loop_start:
	mov al, [rdi + rcx]
	cmp al, sil
	je _strchr_loop_end_found
	cmp al, 0
	je _strchr_loop_end_not_found
	inc rcx
	jmp _strchr_loop_start
_strchr_loop_end_not_found:
	xor rax, rax		; Set to nullptr
	jmp _strchr_ret
_strchr_loop_end_found:
	mov rax, rdi		; Get pointer to arg
	add rax, rcx		; Move to offset
	jmp _strchr_ret
_strchr_ret:
	ret
%elifidn __OUTPUT_FORMAT__, elf32
		[BITS 32]
		section .text
		global strchr
strchr:
	push ebp
	mov ebp, esp
	mov eax, [ebp + 8]
	mov ebx, [ebp + 12]
	xor ecx, ecx

_strchr_loop_start:
	cmp byte [eax + ecx], bl
	je _strchr_loop_end_found
	cmp byte [eax + ecx], 0
	je _strchr_loop_end_not_found
	inc ecx
	jmp _strchr_loop_start

_strchr_loop_end_not_found:
	xor eax, eax
	jmp _strchr_ret
_strchr_loop_end_found:
	add eax, ecx
_strchr_ret:
	pop ebp
	ret
%else
		%error "Architecture not supported"
%endif