.486
.model flat, stdcall
 INCLUDE stdio.inc
 INCLUDELIB msvcrt.lib

.data
 starting_message db "Write your z-string: ", 0
 string_format db "%s", 0
 even_format db "'Even' string is: [%s]", 13,10,0
 odd_format db "'Odd' string is: [%s]", 13, 10, 0
 z_string db 1000 dup (0)
 even_string db 1000 dup (0)
 odd_string db 1000 dup (0)
 useless_message db "Working hard.....", 13, 10, 0

.code
main:
    pusha

    push offset starting_message
    call printf
    add esp, 4

    popa

    pusha

    push offset z_string
    call gets
    add esp, 4

    popa

    pusha
    
    push offset useless_message
    call printf
    add esp, 4
    
    popa

    mov edx, 0
    mov ebx, 0
    mov ecx, 0
    mov ah, 0
    mov al, 0; <- гениальное изобретение
    Cycle:
        cmp z_string[edx], 0
        je Finish

        cmp al, 0
        je Even_Case

        Odd_Case:
            mov ah, z_string[edx]
            mov odd_string[ebx], ah
            dec al
            inc edx
            inc ebx
            jmp Cycle

        Even_Case:
            mov ah, z_string[edx]
            mov even_string[ecx], ah
            inc al
            inc edx
            inc ecx
            jmp Cycle

    Finish:
    pusha

    push offset even_string
    push offset even_format
    call printf
    add esp, 8

    popa

    pusha

    push offset odd_string
    push offset odd_format
    call printf
    add esp, 8

    popa


    ret
    end main
