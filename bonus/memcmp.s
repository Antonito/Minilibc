%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global memcmp

memcmp:
	xor rcx, rcx		; Set rcx to 0
	xor rax, rax
_memcmp_loop_start:
	cmp rcx, rdx		; Did we reach the end ?
	je _memcmp_loop_end_success
	mov al, [rsi + rcx]
	cmp [rdi + rcx], al
	jne _memcmp_loop_end_diff
	inc rcx
	jmp _memcmp_loop_start	; Loop
_memcmp_loop_end_diff:
	sub al, [rdi + rcx]
	not rax
	inc rax
	ret
_memcmp_loop_end_success:
	xor al, al
	ret

%elifidn __OUTPUT_FORMAT__, elf32
		[BITS 32]
		section .text
		global memcmp
memcmp:
	push ebp
	mov ebp, esp
	mov eax, [ebp + 8]
	mov ebx, [ebp + 12]
	mov ecx, [ebp + 16]
	xor edx, edx

_memcmp_loop_start:
	cmp edx, ecx
	je _memcmp_loop_end_success
	mov byte bl, [eax + edx]
	cmp byte [ebx + edx], bl
	jne _memcmp_loop_end_diff
	inc edx
	jmp _memcmp_loop_start

_memcmp_loop_end_diff:
	mov eax, [eax + edx]
	sub al, bl
	jmp _memcmp_end
_memcmp_loop_end_success:
	xor eax, eax
_memcmp_end:
        cmp eax, 0
        jl _memcmp_lower
        jg _memcmp_greater
        jmp _memcmp_final_end
_memcmp_lower:
        mov eax, -1
        jmp _memcmp_final_end
_memcmp_greater:
        mov eax, 1
_memcmp_final_end:
        pop ebp
        ret
%else
		%error "Architecture not supported"
%endif
