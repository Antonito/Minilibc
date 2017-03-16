%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global memmove

memmove:
	cmp rdx, 0
	je _memmove_loop_end
	cmp rdi, rsi
	jl _memmove_cpy_forward	; dest < src

_memmove_cpy_backward:
	mov rcx, rdx
	dec rcx			; Last elem of array
_memmove_backward_loop_start:
	cmp rcx, 0
	je _memmove_last_one	; We reached the end.
	mov byte al, [rsi + rcx]
	mov byte [rdi + rcx], al
	dec rcx
	jmp _memmove_backward_loop_start
_memmove_last_one:
	mov byte al, [rsi + rcx]
	mov byte [rdi + rcx], al
	jmp _memmove_loop_end

_memmove_cpy_forward:
	xor rcx, rcx		; Set rcx to 0
_memmove_forward_loop_start:
	cmp rcx, rdx		; Did we reach the end ?
	je _memmove_loop_end
	mov byte al, [rsi + rcx]
	mov byte [rdi + rcx], al ; Set current byte to desired value
	inc rcx
	jmp _memmove_forward_loop_start	; Loop

_memmove_loop_end:
	mov rax, rdi		; We return a pointer to the array
	ret

%elifidn __OUTPUT_FORMAT__, elf32
		[BITS 32]
		section .text
		global memmove
memmove:
        push ebp
        mov ebp, esp
        mov edi, [ebp + 8]
        mov esi, [ebp + 12]
        mov edx, [ebp + 16]
	cmp edx, 0
	je _memmove_loop_end
	cmp edi, esi
	jl _memmove_cpy_forward	; dest < src

_memmove_cpy_backward:
	mov ecx, edx
	dec ecx			; Last elem of array
_memmove_backward_loop_start:
	cmp ecx, 0
	je _memmove_last_one	; We reached the end.
	mov byte al, [esi + ecx]
	mov byte [edi + ecx], al
	dec ecx
	jmp _memmove_backward_loop_start
_memmove_last_one:
	mov byte al, [esi + ecx]
	mov byte [edi + ecx], al
	jmp _memmove_loop_end

_memmove_cpy_forward:
	xor ecx, ecx		; Set rcx to 0
_memmove_forward_loop_start:
	cmp ecx, edx		; Did we reach the end ?
	je _memmove_loop_end
	mov byte al, [esi + ecx]
	mov byte [edi + ecx], al ; Set current byte to desired value
	inc ecx
	jmp _memmove_forward_loop_start	; Loop

_memmove_loop_end:
	mov eax, edi		; We return a pointer to the array
        pop ebp
	ret
%else
		%error "Architecture not supported"
%endif
