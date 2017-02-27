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
%warning "To code !"
	ret
%else
		%error "Architecture not supported"
%endif