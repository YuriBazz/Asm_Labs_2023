.486
.model flat, stdcall

.data
 len equ 500
.data?
 list dd len dup (?)

.code
 Summ_Of_Divisors:
 ;Summ_Of_Divisors :: eax -> eax
    push edx; опять же все произведения входят в регистр eax
    push ebx
    mov ebx, eax; тут храним число
    push ecx
    mov edx, 2
    mov ecx, 1 ; тут копим сумму делителей
    ; если делители не превосходят корня числа, то квадраты - не превосходят самого числа
    
    Cycle_:
        mov eax, edx
        push edx
        mul eax
        pop edx
        cmp eax, ebx
        jge Stop_

        mov eax, ebx
        push ebx
        mov ebx, edx
        mov edx, 0
        div ebx
        cmp edx, 0
        jne Not_Divisor

        add ecx, ebx
        add ecx, eax
        
        Not_Divisor:
        mov edx, ebx
        pop ebx
        inc edx
        jmp Cycle_
    Stop_:
    mov eax, ecx
    pop edx
    pop ebx
    pop ecx
    ret

 main:
    mov edx, 0
    mov ecx, 2
    Cycle:
    cmp ecx, 100000
    je Finish
  
    mov eax, ecx
    call Summ_Of_Divisors
    mov ebx, eax
  
    call Summ_Of_Divisors
  
    cmp eax, ecx 
    je Check
  
    inc ecx
    jmp Cycle
    Check:
    cmp ecx, ebx
    jb Saver
    inc ecx
    jmp Cycle
 Saver:
    mov list[4*edx], ecx
    inc edx
    mov list[4*edx], ebx
    inc edx
    inc ecx
    jmp Cycle

    Finish:
  ret
    end main