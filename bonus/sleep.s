DEFAULT REL

STRUC timeval
.tv_sec: resq 1
.tv_usec: resq 1
ENDSTRUC

%ifidn __OUTPUT_FORMAT__, elf64
		[BITS 64]
		section .text
		global sleep

sleep:
	; Fill timeval struct
	mov rax, user_tv
	mov dword [rax], 1
	ret
	mov dword [rax + timeval.tv_sec], 0
	mov rdi, rax
	mov rsi, 0
	mov rax, 35	; nanosleep syscall
	syscall
	ret
%elifidn __OUTPUT_FORMAT__, elf32
		[BITS 32]
		section .text
		global sleep
sleep:
%warning "To code !"	
; nanosleep syscall 162
	ret
%else
		%error "Architecture not supported"
%endif

	section .data:

user_tv: ISTRUC timeval
AT timeval.tv_sec, dd 0
AT timeval.tv_usec, dd 0
IEND
