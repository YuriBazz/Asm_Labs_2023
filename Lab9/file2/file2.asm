.486
.model flat, stdcall
 INCLUDE stdio.inc
 INCLUDELIB msvcrt.lib

.data
 starting_message db "Write a length: ", 0
 array_message db "Write an element: ", 0
 length_format db "%d", 0
 array_format db "%hd", 0
 output_message db "The element and difference: ", 0
 output_format db "(%hd, %hd)", 13, 10, 0
 useless_message db "Working hard.....", 13, 10, 0

 .data?
 list_ dw 1000 dup (?)
 string_length dd ?
 max_value dw ?
 saver dw ?

.code
Find_Max:
    push ebp
    mov ebp, esp

;   [ebp+8]  - адрес max_value
;   [ebp+12] - длина
;   [ebp+16] - адрес массива
    pusha

    mov esi, [ebp + 16]
    mov edi, [ebp + 8]
    mov eax, 0
    mov ecx, [ebp + 12]
    mov dx, -8000H
    Cycle:
        cmp eax, ecx
        je Finish

        mov bx, [esi + 2*eax]
        cmp dx, bx
        jg Skip

        mov dx, bx

        Skip:
        inc eax
        jmp Cycle

    Finish:
    mov [edi], dx
    popa


    pop ebp
    ret


main:
    pusha
    push offset starting_message
    call printf
    popa
    add esp, 4

    pusha
    push offset string_length
    push offset length_format
    call scanf
    popa
    add esp, 8

    mov esi, offset list_
    mov eax, string_length
    mov ecx, 0


    Read_Array:
        cmp eax, 0
        je Readed

        pusha

        push offset array_message
        call printf
        add esp, 4

        popa    
        pusha

        push esi
        push offset array_format
        call scanf
        add esp, 8

        popa

        add esi, 2
        dec eax
        jmp Read_Array

    Readed:
    pusha
    
    push offset useless_message
    call printf
    add esp, 4
    
    popa

    push offset list_
    push string_length
    push offset max_value
    call Find_Max
    add esp, 12
    
    mov ebx, 0
    mov esi, offset list_

    Write_Array:
        cmp ebx, string_length
        je Final

        pusha

        push offset output_message
        call printf
        add esp, 4

        popa
        
        mov cx, max_value
        mov ax, [esi + 2 * ebx]
        sub ax, cx

        cmp ax, 0
        jg Shortcut
        mov cx, -1
        imul cx

        Shortcut:
        mov saver, ax
        pusha

        push dword ptr saver
        push dword ptr [esi + 2*ebx]
        push offset output_format
        call printf
        add esp, 12

        popa
        inc ebx
        jmp Write_Array

    Final:
    ret
    end main

