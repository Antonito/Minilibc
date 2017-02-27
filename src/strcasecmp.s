%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global strcasecmp

strcasecmp:
	xor rcx, rcx			; Set rcx to 0
	xor rax, rax
_strcasecmp_start_loop:
	mov byte al, [rdi + rcx]	; Get current byte of s1
	mov byte ah, [rsi + rcx]	; Get current byte of s2
	cmp byte al, ah
	je _strcasecmp_keep_looping 	; Match, let's keep looping

	;; Are they both alpha ?
	cmp byte al, 0x41	; < 'A'
	jl _strcasecmp_end_loop
	cmp byte ah, 0x41
	jl _strcasecmp_end_loop

	cmp byte al, 0x7A	; > 'z'
	jg _strcasecmp_end_loop
	cmp byte ah, 0x7A
	jg _strcasecmp_end_loop

	cmp byte al, 0x5A	; <= 'Z'
	jle _strcasecmp_check_sup_Z_ah
	cmp byte al, 0x61	; < 'a'
	jl _strcasecmp_end_loop

_strcasecmp_check_sup_Z_ah:
	cmp byte ah, 0x51	; <= 'Z'
	jle _strcasecmp_next_checks
	cmp byte ah, 0x61	; < 'a'
	jl _strcasecmp_end_loop


_strcasecmp_next_checks:
	cmp byte al, ah
	jl _strcasecmp_ah_to_uppercase

	;; Upper case
	cmp byte al, 0x61	; < 'a'
	jl _strcasecmp_end_loop
	cmp byte al, 0x7A	; > 'z'
	jg _strcasecmp_end_loop

	;; Is ah upper ?
	cmp byte ah, 0x41	; < 'A'
	jl _strcasecmp_end_loop
	cmp byte ah, 0x5A	; > 'Z'
	jg _strcasecmp_end_loop

	sub al, 0x20
	cmp byte ah, al
	jne _strcasecmp_end_loop
	jmp _strcasecmp_keep_looping

_strcasecmp_ah_to_uppercase:
	cmp byte ah, 0x61	; < 'a'
	jl _strcasecmp_end_loop
	cmp byte ah, 0x7A	; > 'z'
	jg _strcasecmp_end_loop

	;; Is al upper ?
	cmp byte al, 0x41	; < 'A'
	jl _strcasecmp_end_loop
	cmp byte al, 0x5A	; > 'Z'
	jg _strcasecmp_end_loop

	sub ah, 0x20
	cmp byte ah, al
	jne _strcasecmp_end_loop

_strcasecmp_keep_looping:
	cmp al, 0
	je _strcasecmp_end_loop		; End of the string
	inc rcx
	jmp _strcasecmp_start_loop
_strcasecmp_end_loop:			; Behaves like Libc's strcasecmp
	cmp al, 0
	jle _strcasecmp_unsigned
_strcasecmp_end_loop_check_sign2:
	cmp ah, 0
	jg _strcasecmp_signed
_strcasecmp_unsigned:
	xor rcx, rcx
	movzx rcx, al
	mov al, ah
	xor ah, ah
	sub rcx, rax
	mov rax, rcx
	ret
_strcasecmp_signed:
	sub byte al, ah
	movsx rax, al
	ret

%elifidn __OUTPUT_FORMAT__, elf32
		[BITS 32]
		section .text
		global strcasecmp
strcasecmp:
%warning "To code !"
	ret
%else
		%error "Architecture not supported"
%endif