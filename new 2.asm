section .data
    buffer db 10      ; Buffer to store user input
    count equ 10      ; Number of characters to input
    newline db 10     ; Newline character for formatting

section .bss
    stack resb 10     ; Stack to store characters in reverse order
    top   resb 1      ; Top of the stack

section .text
    global _start

_start:
    ; Input Loop
    mov ecx, count     ; Initialize loop counter
input_loop:
    mov ah, 1          ; Function code for character input
    int 21h            ; BIOS interrupt for input
    mov [buffer], al   ; Store the input character

    ; Push the character onto the stack
    mov eax, [buffer]
    mov ebx, stack
    mov ecx, [top]
    mov [ebx + ecx], al
    inc byte [top]

    loop input_loop    ; Repeat until 10 characters are input

    ; Output Loop (Print characters in reverse order)
    mov ecx, count     ; Initialize loop counter
output_loop:
    ; Pop character from the stack
    dec byte [top]
    mov ebx, stack
    mov al, [ebx + byte [top]]

    ; Print the character
    mov ah, 2          ; Function code for character output
    int 21h            ; BIOS interrupt for output

    loop output_loop   ; Repeat until all characters are printed

    ; Print newline character
    mov dl, newline     ; Newline character
    mov ah, 2          ; Function code for character output
    int 21h            ; BIOS interrupt for output

    ; Exit the program
    mov ah, 4Ch        ; Function code for program termination
    xor al, al         ; Exit code 0
    int 21h            ; BIOS interrupt for program termination