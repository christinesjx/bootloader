; boot sect at address 0x7c00
; in 16 bit real mode

[org 0x7c00]


mov bx, HELLO			; print hello message
call print_string


mov [BOOT], dl

mov bp, 0x8000          
mov sp, bp             

mov bx, 0x9000          
mov dh, 2		
mov dl, [BOOT]

call  disk_load

mov dx, [0x9000]     
call  print_string         
			

jmp $

%include "disk_load.asm"


HELLO:
	db 'Welcome to my OS', 0

print_string:
    pusha
    mov ah, 0x0e

loop:
    mov al, [bx]
    int 0x10
    add bx, 1
    cmp al, 0
    jne loop
    popa
    ret


; Global  variables
BOOT: db 0

; Bootsector  padding all zero
times  510-($-$$) db 0
dw 0xaa55


;go beyond 512 byte
;see if the second sector is loaded
times  256 dw '!'

