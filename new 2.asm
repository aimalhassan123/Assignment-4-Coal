section .data
    buffer db 10      ; Buffer to store user input
    count equ 10      ; Number of characters to input
    newline db 10     ; Newline character for formatting

section .bss
    stack resb 10     
    top   resb 1     
section .text
    global _start

_start:
    ; Input Loop
    mov ecx, count     
input_loop:
    mov ah, 1          ; Function code for character input
    int 21h            
    mov [buffer], al   ; Store the input character

    ; Push the character onto the stack
    mov eax, [buffer]
    mov ebx, stack
    mov ecx, [top]
    mov [ebx + ecx], al
    inc byte [top]

    loop input_loop    

   
    mov ecx, count     
output_loop:
    
    dec byte [top]
    mov ebx, stack
    mov al, [ebx + byte [top]]

    ; Print the character
    mov ah, 2          
    int 21h           

    loop output_loop   

    
    mov dl, newline     
    mov ah, 2          
    int 21h          

    
    mov ah, 4Ch        
    xor al, al         
    int 21h            
