[org 0x0100]
	jmp start
Max:
	mov ax,[bx+si]
	mov dx,[bx+si+2]
	cmp ax,dx
	ja swap
	jmp continue
swap:
	mov dx,[bx+si+2]
	mov [bx+si],dx
	mov [bx+si+2],ax
continue:
	add si,2
	dec cx
	cmp cx,0
	jnz Max
	mov [result+di],ax
	ret
start:
	;;;array 1
	mov di,0
	mov si,0
	mov bx,A1
	mov cx,9
	call Max
	
	;;;addition of result
	mov dx,[Result]
	
	mov ax,0x4c00
	int 0x21
	

A1: dw 43,44,45,57,58,59,91,97,90,14

Result: dw 0