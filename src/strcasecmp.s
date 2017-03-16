%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global strcasecmp

strcasecmp:
        xor rcx, rcx		; Set counter to 0

_strcasecmp_loop:
        mov byte al, [rdi + rcx] ; Get s1 character
        mov byte ah, [rsi + rcx] ; Get s2 character

        cmp byte al, 0		 ; Test null byte
        je _strcasecmp_loop_end
        cmp byte ah, 0
        je _strcasecmp_loop_end

        mov dl, al
        mov dh, ah
        or dl, 32
        or dh, 32
        cmp dl, dh
        jne _strcasecmp_loop_end

_strcasecmp_continue_loop:
        inc rcx
        jmp _strcasecmp_loop

_strcasecmp_loop_end:
        cmp al, 'A'
        jl _strcasecmp_real_end
        cmp al, 'z'
        jg _strcasecmp_real_end
        cmp al, 'a'
        jge _strcasecmp_letter
        cmp al, 'Z'
        jg _strcasecmp_real_end

_strcasecmp_letter:
        cmp ah, 'A'
        jl _strcasecmp_real_end
        cmp ah, 'z'
        jg _strcasecmp_real_end
        cmp ah, 'a'
        jge _strcasecmp_letter_ok
        cmp ah, 'Z'
        jg _strcasecmp_real_end
        
_strcasecmp_letter_ok:
        or al, 32
        or ah, 32
        
_strcasecmp_real_end:
        xor rcx, rcx
        mov ch, al
        mov cl, ah
        xor rax, rax
        mov al, ch
        xor ch, ch
        sub rax, rcx
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
