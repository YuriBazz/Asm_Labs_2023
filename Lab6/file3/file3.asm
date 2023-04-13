.486
.model flat, stdcall


.data
 list dw 12, 34, 34, 12
 len equ 4

.data?
 new_list dw 10 dup(?)

.code
 Palindrome:
 ; Palindrom :: eax, esi, ebx -> eax
 ; Данные поступают в процедуру, как написано в описании практики, кроме ebx - индекс начала
 ;  В конце: (eax = 1 <=> palindrome), (eax = 0 <=> not palindrome)
    push ecx ; контейнер  
    Cycle: 
        cmp ebx, eax
        jge Good_Finish

        mov cx, [esi + 2 * ebx]
        cmp cx, [esi + 2 * eax]
        jne Bad_Finish
 
        inc ebx
        dec eax
        jmp Cycle

        Bad_Finish:
            mov eax, 0
            jmp Skip
        Good_Finish:
            mov eax, 1
        
        Skip: 
            pop ecx
        ret
 main:
    mov edx, 0 ; разница между началом и концом искомого подмассива
    mov esi, offset list
    mov eax, len - 1; текущая длина
    
    mov ebx, 0
    mov ecx, 0; Начало искомого палиндрома
    Cycle_:
        cmp eax, 0 
        jl Next_Step

        push ecx
        mov ecx, eax
        push edx
        mov edx, ebx
        call Palindrome
        mov ebx, edx
        pop edx

        cmp eax, 1
        jne Not_Palindrome
        mov eax, ecx
        
        sub ecx, ebx
        cmp ecx, edx
        jl Not_Max_Length
        mov edx, ecx
        pop ecx
        mov ecx, ebx
        jmp Shortcut

        Not_Palindrome:
        mov eax, ecx
        Not_Max_Length:
        pop ecx

        Shortcut:
        inc ebx
        cmp ebx, eax
        jle Cycle_

        mov ebx, 0
        dec eax
        jmp Cycle_

    Next_Step:
        mov eax, 0
        mov ebx, 0
        mov edi, offset new_list
        Mini_Cycle:
            cmp ebx, edx
            jg Finish

            mov ax, [esi + 2 * ecx]
            mov [edi + 2*ebx], ax
            inc ebx
            inc ecx
            jmp Mini_Cycle
    Finish:
    ret
 end main