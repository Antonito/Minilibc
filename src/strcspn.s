%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global strcspn

strcspn:
%warning "To code !"
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