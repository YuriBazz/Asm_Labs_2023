.486
.model flat, stdcall
 INCLUDE stdio.inc
 INCLUDELIB msvcrt.lib

.data
 cesar_alphabet db "ABCDEFGHIJKLMNOPQRSTUVWXYZ ", 0
 cesar_lenght dd 27
 question db "Write 0 for encrypt, 1 for decrypt: ", 0
 number_format db "%hu", 0
 z_string db 1000 dup (0)
 starting_string_message db "Write your z-string: ", 0
 ending_message_encrypt db "Encrypted string is: [%s]", 13,10, 0
 ending_message_decrypt db "Decrypted string is: [%s]", 13,10,0
 starting_number_message db "Write shift_ number: ", 0
 error_message db "That's bad.", 0

.data?
 shift_ dw ?
 pointer_ dw ?
 saver_db db ?
 saver_dd dd ? 
.code
Find_Letter_In_Alphabet:
    push ebp
    mov ebp, esp

    ; [ebp + 8]адрес  искомой буквы
    ; [ebp + 12] адрес контейнера
    ; [ebp + 16] адрес алфавита

    pusha

    mov esi, [ebp+ 16]
    mov edi, [ebp + 8]
    mov edx, 0
    mov al, [edi]
    mov ecx, [ebp + 12]
    Find:
        cmp al, [esi + edx]
        je Found

        inc edx
        jmp Find

    Found:
    mov [ecx], edx

    popa
    pop ebp
    ret


main:

    pusha

    push offset starting_string_message
    call printf
    add esp, 4

    popa

    pusha

    push offset z_string
    call gets
    add esp, 4
    
    popa

    pusha

    push offset starting_number_message
    call printf
    add esp, 4

    popa

    pusha

    push offset shift_
    push offset number_format
    call scanf
    add esp, 8

    popa


    pusha

    push offset question
    call printf
    add esp, 4
    
    popa

    pusha

    push offset pointer_
    push offset number_format
    call scanf
    add esp, 8

    popa
    
    cmp pointer_, 0
    je Encrypt

    cmp pointer_, 1
    je Decrypt

    pusha

    push offset error_message
    call printf
    add esp, 4

    popa

    jmp FINISH

    Encrypt:
        mov eax, 0; счетчик строки
        mov ebx,0; хранилище
        mov edx, 0; счетчик алфавита

        Encrypt_Cycle:
            mov edx, 0
            cmp z_string[eax], 0
            je Encrypt_Finish

            mov bl , z_string[eax]
            mov saver_db, bl
     

            push offset cesar_alphabet
            push offset saver_dd
            push offset saver_db
            call Find_Letter_In_Alphabet
            add esp, 12

            movzx edx, shift_
            add saver_dd, edx

            Encrypt_Save:
            cmp saver_dd, 27
            jb Encrypt_Next_Step

            sub saver_dd, 27
            jmp Encrypt_Save

            Encrypt_Next_Step:

            mov edx, saver_dd
            mov bl, cesar_alphabet[edx]
            mov z_string[eax], bl

            inc eax
            jmp Encrypt_Cycle

        
    Decrypt:
        mov eax, 0; счетчик строки
        mov ebx,0; хранилище
        mov edx, 0; счетчик алфавита


        Decrypt_Cycle:
            mov edx, 0
            cmp z_string[eax], 0
            je Decrypt_Finish

            mov bl , z_string[eax]
            mov saver_db, bl
            

            push offset cesar_alphabet
            push offset saver_dd
            push offset saver_db
            call Find_Letter_In_Alphabet
            add esp, 12

            movzx edx, shift_
            sub saver_dd, edx

            Decrypt_Save:
            cmp saver_dd, -1
            jg Decrypt_Next_Step

            add saver_dd, 27
            jmp Decrypt_Save

            Decrypt_Next_Step:

            mov edx, saver_dd
            mov bl, cesar_alphabet[edx]
            mov z_string[eax], bl

            inc eax
            jmp Decrypt_Cycle

    Encrypt_Finish:
    pusha
    push offset z_string
    push offset ending_message_encrypt
    call printf
    add esp, 8
    popa
    jmp FINISH
    Decrypt_Finish:
    pusha
    push offset z_string
    push offset ending_message_decrypt
    call printf
    add esp, 8
    popa

    FINISH:
    ret
    end main
