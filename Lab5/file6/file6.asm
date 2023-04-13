.486
.model flat, stdcall
; В задаче не написано, но предположу, что в строке только строчные буквы
.data 
 string db "cdeab", 0

.data?
 len dd ?
 new_string db 100 dup (?)
 index_of_min dd ?

.code
 main:
   mov ecx, 0
    loop_start: 
        cmp string[ecx], 0
        je loop_stop
        inc ecx
        jmp loop_start
    loop_stop:

    mov len, ecx
    dec len

    mov ecx, 0
    mov edx, 0
    mov al, 123
    Find_Min:
        cmp string[ecx], 0
        je Found_Min

        cmp string[ecx], al
        ja Shortcut

        mov edx, ecx
        mov al, string[ecx]

        Shortcut:
            inc ecx
            jmp Find_Min
    
    Found_Min:

    mov index_of_min, edx
    
    

    mov ecx, 0
    Cycle:
        cmp string[edx], 0
        jz Next_Step

        mov al, string[edx]
        mov new_string[ecx], al
        inc ecx
        inc edx
        jmp Cycle

    Next_Step:
    mov edx, 0
    mov eax, 0

    Another_Cycle:
        cmp eax, index_of_min
        jz Finish
        
        mov dl, string[eax]
        mov new_string[ecx], dl
        inc eax
        inc ecx
        jmp Another_Cycle

    Finish:
    mov new_string[ecx], 0
    ret
 end main