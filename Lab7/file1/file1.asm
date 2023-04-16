.486
.model flat, stdcall

.data 
 list dd 3,1,6,0, 0
 len dd 4
 number dd 5
 index dd 2

.code 
 Function:
 ; Принимает индекс, число, длину массива, адрес массива. Изменяет массив
    push ebp
    mov ebp, esp
    pusha

    ; [ebp+8]  - адрес массива
    ; [ebp+12] - длина массива 
    ; [ebp+16] - число
    ; [ebp+20] - индекс

    mov esi, [ebp + 8]
    mov ecx, [ebp + 12]
    mov edx, [ebp + 16]
    mov ebx, [ebp + 20]

    dec ecx
    Cycle:
        cmp ecx, ebx
        je Next_Step

        mov eax, [esi + 4 * ecx]
        mov [esi + 4 * ecx + 4], eax

        dec ecx
        jmp Cycle
    
    Next_Step:
        mov eax, [esi + 4 * ecx]
        mov [esi + 4 * ecx + 4], eax
        mov [esi + 4 * ecx], edx

        dec ecx
            
    popa
    pop ebp
    ret

 main:
    push index
    push number
    push len
    push offset list

    call Function
    ret
 end main





    