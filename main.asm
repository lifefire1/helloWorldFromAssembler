format ELF64
public _start

section '.data' writable
	new_line equ 0xA
	msg db "hello, world 12345678", new_line,0

section '.text' executable
_start:
	mov rax, msg
	call print_string

	call exit

print_string:
	push rax
	push rbx
	push rcx
	push rdx
	mov rcx, rax
	call length_string
	mov rdx,rax
	mov rax, 4
	mov rbx, 1
	int 0x80
	pop rdx
	pop rcx
	pop rbx
	pop rax
	ret

section '.print_string' executable
length_string:
	push rdx
	xor rdx, rdx
	.next_iter:
		cmp[rax+rdx], byte 0
		je .close
		inc rdx
		jmp .next_iter
	.close:
		mov rax, rdx
		pop rdx
		ret

section '.exit' executable
exit:
	mov rax, 1
	mov rbx, 0
	int 0x80

