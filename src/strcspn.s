%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global strcspn

strcspn:
	xor rdx, rdx		; Set rdx to 0
_strcspn_s_loop_start:
	cmp byte [rdi + rdx], 0
	je _strcspn_s_loop_end
	jmp _strcspn_reject_loop_init
_strcspn_s_loop_inc:
	inc rdx
	jmp _strcspn_s_loop_start
_strcspn_s_loop_end:
	xor rax, rax		; Set return value
	ret

_strcspn_reject_loop_init:
	xor rcx, rcx		; Set rcx to 0
_strcspn_reject_loop_start:
	cmp byte [rsi + rcx], 0
	je _strcspn_s_loop_inc	; increment count (first loop) and continue
	mov r8b, [rdi + rdx]
	cmp byte [rsi + rcx], r8b
	je _strcspn_reject_loop_end
	inc rcx
	jmp _strcspn_reject_loop_start
_strcspn_reject_loop_end:
	mov rax, rdx
	ret
%elifidn __OUTPUT_FORMAT__, elf32
		[BITS 32]
		section .text
		global strcspn
strcspn:
%warning "To code !"
	ret
%else
		%error "Architecture not supported"
%endif
