%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global strcmp

strcmp:
	xor rcx, rcx			; Set rcx to 0
	xor rax, rax
_strcmp_start_loop:
	mov byte al, [rdi + rcx]	; Get current byte of s1
	mov byte ah, [rsi + rcx]	; Get current byte of s2
	cmp byte al, ah
	jne _strcmp_end_loop		; Mismatch !
	cmp al, 0
	je _strcmp_end_loop		; End of the string
	inc rcx
	jmp _strcmp_start_loop
_strcmp_end_loop:			; Behaves like Libc's strcmp
	cmp al, 0
	jle _strcmp_unsigned
_strcmp_end_loop_check_sign2:
	cmp ah, 0
	jg _strcmp_signed
_strcmp_unsigned:
	xor rcx, rcx
	movzx rcx, al
	mov al, ah
	xor ah, ah
	sub rcx, rax
	mov rax, rcx
	ret
_strcmp_signed:
	sub byte al, ah
	movsx rax, al
	ret

%elifidn __OUTPUT_FORMAT__, elf32
		[BITS 32]
		section .text
		global strcmp
strcmp:
        push ebp
        mov ebp, esp
        mov edi, [ebp + 8]
        mov esi, [ebp + 12]
	xor ecx, ecx			; Set rcx to 0
	xor eax, eax
_strcmp_start_loop:
	mov byte al, [edi + ecx]	; Get current byte of s1
	mov byte ah, [esi + ecx]	; Get current byte of s2
	cmp byte al, ah
	jne _strcmp_end_loop		; Mismatch !
	cmp al, 0
	je _strcmp_end_loop		; End of the string
	inc ecx
	jmp _strcmp_start_loop
_strcmp_end_loop:			; Behaves like Libc's strcmp
	cmp al, 0
	jle _strcmp_unsigned
_strcmp_end_loop_check_sign2:
	cmp ah, 0
	jg _strcmp_signed
_strcmp_unsigned:
	xor ecx, ecx
	movzx ecx, al
	mov al, ah
	xor ah, ah
	sub ecx, eax
	mov eax, ecx
        jmp _strcmp_before_end
_strcmp_signed:
	sub byte al, ah
	movsx eax, al
_strcmp_before_end:
        cmp eax, 0
        jl _strcmp_lower
        jg _strcmp_greater
        jmp _strcmp_final_end
_strcmp_lower:
        mov eax, -1
        jmp _strcmp_final_end
_strcmp_greater:
        mov eax, 1
_strcmp_final_end:
        pop ebp
        ret
%else
		%error "Architecture not supported"
%endif
