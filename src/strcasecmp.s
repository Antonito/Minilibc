%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global strcasecmp

strcasecmp:
        xor rcx, rcx 
_strcasecmp_loop:
        mov byte al, [rdi + rcx]
        mov byte ah, [rsi + rcx]
        cmp 0, al
        je _strcasecmp_loop_end
        cmp 0, ah
        je _strcasecmp_loop_end
        or al, 32
        or ah, 32
        cmp al, ah

_strcasecmp_loop_end:

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
