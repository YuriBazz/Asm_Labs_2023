.486
.model flat, stdcall


.data 
 list dw 2, 4, 1, 10, 12, 18
 len dd 6
 number dw 5

.data?
 list1 dw 10 dup (?)
 list2 dw 10 dup (?)

.code 
 Function:
    ;Принимает адресс массива чисел, длину этого массива, число из условия, адреса корнтейнеров. 
    ;Записывает в контейнеры, сохраняет количество занятых ячеек в каждом контейнере в регистрах eax для 1го, ebx для 2го

    ;[ebp+22] - адрес массива
    ;[ebp+18] - длина массива 
    ;[ebp+16] - число
    ;[ebp+12] - адрес первого контейнера
    ;[ebp+8] - адрес второго контейнера 
    
    push ebp
    mov ebp, esp
    push ecx
    push edx
    push esi
    push edi

    mov esi, [ebp + 22]
    mov eax, 0
    mov ebx, 0
    mov ecx, 0

    Cycle:
        cmp ecx, [ebp + 18]
        je Finish

        mov dx, [esi + 2 * ecx]
        cmp dx, [ebp + 16] 
        jl Lower

        Greater_or_equal:
        mov edi, [ebp + 8]
        mov [edi + 2 * ebx], dx

        inc ebx
        inc ecx
        jmp Cycle

        Lower:
        mov edi, [ebp + 12]
        mov [edi + 2 * eax], dx

        inc eax
        inc ecx
        jmp Cycle

    Finish:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebp
    ret

 main:
    push offset list
    push len
    push number
    push offset list1
    push offset list2
    call Function
    ret
 end main