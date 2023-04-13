.486
.model flat, stdcall

.data
 len equ 3
 pow db 0, 2, 4
 a dd 3
 sum dd 0

.code
 ; Pow_Function :: eax, bl -> eax
 ; eax -> основание степени
 ; bl -> показатель степени
 ; eax -> результат

 Pow_Function:
    push ecx ;(хранилище для основания степени)
    mov ecx, eax
    mov eax, 1

    Cycle1:
        cmp bl, 0
        je Stop_Function
        imul ecx
        dec bl
        jmp Cycle1
    

    Stop_Function:
    pop ecx

    ret
 main:
    mov esi, offset pow
    mov ecx, 0


    Cycle:
        cmp ecx, len
        jz Finish

        mov eax, a
        mov bl, [esi + ecx]
        call Pow_Function
        add sum, eax
        inc ecx
        jmp Cycle
    
    Finish:
    ret
 end main


