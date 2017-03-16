%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global strncmp

strncmp:
	xor rcx, rcx			; Set rcx to 0
	xor rax, rax
_strncmp_start_loop:
	cmp rcx, rdx
	je _strncmp_end_loop
	mov byte al, [rdi + rcx]	; Get current byte of s1
	mov byte ah, [rsi + rcx]	; Get current byte of s2
	cmp byte al, ah
	jne _strncmp_end_loop		; Mismatch !
	cmp al, 0
	je _strncmp_end_loop		; End of the string
	inc rcx
	jmp _strncmp_start_loop
_strncmp_end_loop:			; Behaves like Libc's strncmp
	cmp al, 0
	jle _strncmp_unsigned
_strncmp_end_loop_check_sign2:
	cmp ah, 0
	jg _strncmp_signed
_strncmp_unsigned:
	xor rcx, rcx
	movzx rcx, al
	mov al, ah
	xor ah, ah
	sub rcx, rax
	mov rax, rcx
	ret
_strncmp_signed:
	sub byte al, ah
	movsx rax, al
	ret

%elifidn __OUTPUT_FORMAT__, elf32
		[BITS 32]
		section .text
		global strncmp
strncmp:
        push ebp
        mov ebp, esp
        mov edi, [ebp + 8]
        mov esi, [ebp + 12]
        mov edx, [ebp + 16]
	xor ecx, ecx			; Set rcx to 0
	xor eax, eax
_strncmp_start_loop:
        cmp ecx, edx
        je _strncmp_end_loop
	mov byte al, [edi + ecx]	; Get current byte of s1
	mov byte ah, [esi + ecx]	; Get current byte of s2
	cmp byte al, ah
	jne _strncmp_end_loop		; Mismatch !
	cmp al, 0
	je _strncmp_end_loop		; End of the string
	inc ecx
	jmp _strncmp_start_loop
_strncmp_end_loop:			; Behaves like Libc's strcmp
	cmp al, 0
	jle _strncmp_unsigned
_strncmp_end_loop_check_sign2:
	cmp ah, 0
	jg _strncmp_signed
_strncmp_unsigned:
	xor ecx, ecx
	movzx ecx, al
	mov al, ah
	xor ah, ah
	sub ecx, eax
	mov eax, ecx
        jmp _strncmp_before_end
_strncmp_signed:
	sub byte al, ah
	movsx eax, al
_strncmp_before_end:
        cmp eax, 0
        jl _strncmp_lower
        jg _strncmp_greater
        jmp _strncmp_final_end
_strncmp_lower:
        mov eax, -1
        jmp _strncmp_final_end
_strncmp_greater:
        mov eax, 1
_strncmp_final_end:
        pop ebp
        ret
%else
		%error "Architecture not supported"
%endif
