.486
.model flat, stdcall

.data
 list1 dd 28, -70, 154, 98
 len equ 4


.code
; GCD :: eax, ebx -> eax
; eax - число 1
; ebx - число 2 
; Результат в eax - НОД заданных чисел

 GCD:
    push edx ;(нужен, чтобы хранить остаток и поменять местами два числа)
    cmp eax, 0
    jg First_Number_Is_Positive
    neg eax

    First_Number_Is_Positive:

    cmp ebx, 0
    jg Second_Number_Is_Positive
    neg ebx

    Second_Number_Is_Positive:
    
    cmp eax, ebx
    ja Good_Position

    mov edx, ebx
    mov ebx, eax
    mov eax, edx


    Good_Position:
    

    Cycle1:
        cmp ebx, 0
        jz Found

        mov edx, 0
        div ebx
        mov eax, ebx
        mov ebx, edx
        jmp Cycle1
    Found:

    pop edx
    ret
 main:
    mov esi, offset list1
    mov ecx, 0
    mov eax, 0
    Cycle:
        cmp ecx, len
        ja Finish

        mov ebx, [esi + 4*ecx]
        call GCD
        inc ecx
        jmp Cycle

    Finish:

    ret
 end main

