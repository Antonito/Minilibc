%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global strcasecmp

strcasecmp:
        xor rcx, rcx		; Set counter to 0

_strcasecmp_loop:
        mov byte al, [rdi + rcx] ; Get s1 character
        mov byte ah, [rsi + rcx] ; Get s2 character

        cmp 0, al		 ; Test null byte
        je _strcasecmp_loop_end
        cmp 0, ah
        je _strcasecmp_loop_end

	or al, 32		; Set to lowercase
        or ah, 32		; Set to lowercase
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
