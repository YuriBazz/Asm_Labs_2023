.486
.model flat, stdcall

.data 
 a_i dd -1, 0
 len equ 2
 xs dd -1, 0, 1, -3, 2
 len_ equ 5

.data? 
 max dd ?
.code
 Find_Max:
 ; Find_Max :: esi, eax -> eax
 ; просто ищет максимум в массиве
    push ebx; счетчик 
    push ecx; контейнер
    mov ebx, 0
    mov ecx, 80000000H

    Cycle_:
        cmp ebx, eax
        jg Stop_
       
       
        cmp ecx, [esi + 4*ebx]
        jg Skip

        mov ecx, [esi + 4 * ebx]
    
        Skip:
        inc ebx
        jmp Cycle_
    Stop_:
    mov eax, ecx
    pop ecx
    pop ebx
    ret
 Fx:
 ; Fx :: esi, eax, ebx -> ebx
 ; ebx - сначала x*, потом f(x*)
    push ecx
    mov edx, 0
    mov ecx, eax
    mov eax, 0 ; сумму копим тут
    Cycle1: 
        cmp edx, ecx
        jg Stop1
        
        push edx
        imul ebx
        pop edx
        add eax, [esi + 4*edx]
        inc edx
        jmp Cycle1
    Stop1:
    mov ebx, eax
    pop ecx
    ret
 main:
    mov ecx, len_ - 1
    mov esi, offset a_i
    mov edi, offset xs
    mov edx, 0
    
    Cycle:
        cmp edx, ecx
        jg Next_Step
        
        mov eax, len - 1
        mov ebx, [edi + 4*edx]
        push edx ; как понял, все влезет в eax
        call Fx
        pop edx ; поэтому нам не интересно, что там было в edx после применения Fx
        mov [edi + 4* edx], ebx
        inc edx
        jmp Cycle

    Next_Step:
    mov eax, len_- 1
    mov esi, offset xs
    call Find_Max
    mov max, eax
    ret
 end main
        



        
