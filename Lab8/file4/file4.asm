.486
.model flat, stdcall

.data
 array dd -10, 12, -101, 32, 14, -75, -6, 12, 32,5,6,1,4,3,7,5,2
 len equ 17


.code

 Array_remaker:
 ; Разбиение массива относительно выбранного элемента при помощи
 ; двух индексов, идущих с начала и с конца

 ; [ebp+16] - индекс конца массива 
 ; [ebp+12] - индекс начала массива
 ; [ebp+8] - адресс массива

    push ebp
    mov ebp, esp

    pusha
    
    mov eax, [ebp + 12]
    mov ebx, [ebp + 16]
    mov esi, [ebp + 8]


    cmp eax, ebx
    jge Remaker_Finish

    mov edx, [esi + 4 * eax]

    Remaker_Cycle:
        Start_Cycle:
            cmp [esi + 4 * eax], edx
            jge End_Cycle

            inc eax
            jmp Start_Cycle

        End_Cycle:
            cmp [esi + 4 * ebx], edx
            jle Remaker_Next_Step

            dec ebx
            jmp End_Cycle

        Remaker_Next_Step:
        cmp eax, ebx
        jge Remaker_Substep
        mov ecx, [esi + 4 * eax]
        cmp ecx, [esi + 4 * ebx]
        je Remaker_Substep
        push ecx
        mov ecx, [esi + 4 * ebx]
        mov [esi + 4 * eax], ecx
        pop ecx
        mov [esi + 4 * ebx], ecx
        jmp Remaker_Cycle

    Remaker_Substep:
    cmp eax, ebx
    jg Skip

    inc eax

    Skip:
    dec ebx
    

    ; для правого
    push [ebp + 16]
    push eax
    push esi
    call Array_remaker
    add esp, 12

    ;для левого
    push ebx
    push [ebp + 12]
    push esi
    call Array_remaker
    add esp, 12

   Remaker_Finish:

    popa

    pop ebp

    ret

 Quick_Sort:
 ; [ebp+8] - адресс массива
 ; [ebp+12] - длинна массива 

    push ebp
    mov ebp, esp
    pusha

    mov esi, [ebp + 8]
    mov ebx, [ebp + 12]
    dec ebx
    mov eax, 0
    push ebx
    push eax
    push esi
    call Array_remaker
    add esp, 12

    popa
    pop ebp
    ret

 main:
    push len
    push offset array
    call Quick_Sort
    add esp, 8


    ret
    end main
        

