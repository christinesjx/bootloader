;
;	Most disk BIOS calls use the following parameter scheme:
;	    AH = function request number
;	    AL = number of sectors  (1-128 dec.)
;	    CH = cylinder number  (0-1023 dec.)
;	    CL = sector number	(1-17 dec.)
;	    DH = head number  (0-15 dec.)
;	    DL = drive number (0=A:, 1=2nd floppy, 80h=drive 0, 81h=drive 1)
;	    DL = drive number (0=A:, 1=2nd floppy, 80h=C:, 81h=D:)
;		 Note that some programming references use (0-3) as the
;		 drive number which represents diskettes only.
;	    ES:BX = address of user buffer
;

disk_load:
push dx			; push dx on stack
mov ah, 0x02     	; BIOS  read  sector  function
mov al, dh       	; Read DH  sectors
mov ch, 0x00     	; Select  cylinder 0
mov dh, 0x00     	; Select  head 0
mov cl, 0x02     	; Start  reading  from  second sector
int 0x13          	; INT 13 - Diskette BIOS Services


jc  error    		; Jump if error (i.e.  carry  flag  set)

pop dx            	; pop DX off the stack
cmp dh, al       	
jne  error		; error  message
ret



error :
mov bx, ERROR_MSG
call  print_string
jmp $


ERROR_MSG   db "error!", 0
