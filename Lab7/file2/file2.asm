.486
.model flat, stdcall

.data
 list1 dw -5, -3, 0, 2, 10
 list2 dw -7, -6, 0, 10
 len1 dd 5
 len2 dd 4
 list3 dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.code 
 Function:
 ;Принимает адрес первого масива, адрес второго массива, адрес третьего массива, длину первого массива, длину второго массива
 ; Изменяет третий массив
    push ebp
    mov ebp, esp
    pusha

    ; [ebp+8]  - длина второго массива
    ; [ebp+12] - длина первого массива
    ; [ebp+16] - адрес третьего массива
    ; [ebp+20] - адрес второго массива
    ; [ebp+24] - адресс первого массива

    

    mov eax, 0; счетчик первого массива
    mov ebx, 0; счетчик второго массива
    mov ecx, 0; счетчик третьего массива

    Cycle:
        cmp eax, [ebp + 12]
        je First_massive_is_off

        cmp ebx, [ebp + 8]
        je Second_massive_is_off

        mov esi, [ebp + 24]
        mov dx, [esi + 2 * eax]
        mov esi, [ebp + 20]
        cmp dx, [esi + 2 * ebx]
        jle Write_from_dx_and_inc_eax

        mov dx, [esi + 2 * ebx]
        mov esi, [ebp + 16]
        mov [esi + 2 * ecx], dx

        inc ebx
        inc ecx
        jmp Cycle

        Write_from_dx_and_inc_eax:
                mov esi, [ebp + 16]
                mov [esi + 2 * ecx], dx
                inc eax
                inc ecx
                jmp Cycle

        First_massive_is_off:
            mov esi, [ebp + 20]
            cmp ebx, [ebp + 8]
            je Finish

            mov dx, [esi + 2 * ebx]
            mov esi, [ebp + 16]
            mov [esi + 2 * ecx], dx
            inc ebx
            inc ecx
            jmp First_massive_is_off

        Second_massive_is_off:
            mov esi, [ebp + 24]
            cmp eax, [ebp + 12]
            je Finish

            mov dx, [esi + 2 * eax]
            mov esi, [ebp + 16]
            mov [esi + 2 * ecx], dx
            inc eax
            inc ecx
            jmp Second_massive_is_off
        
        Finish:

    

    popa
    pop ebp
    ret

 main:
    push offset list1
    push offset list2
    push offset list3
    push len1
    push len2

    call Function
    ret
 end main