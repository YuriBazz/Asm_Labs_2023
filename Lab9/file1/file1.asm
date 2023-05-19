.486
.model flat, stdcall
 INCLUDE stdio.inc
 INCLUDELIB msvcrt.lib


.data
 starting_message db "Write two numbers separating them with space:" ,  0
 input_format db "%d%d", 0
 ending_message db "GCD of your numbers is: %d", 0

.data? 
 number1 dd ?
 number2 dd ?
 gcd dd ?

.code
GCD_Function:
    push ebp
    mov ebp, esp
    pusha

    ; [ebp+8] - number1
    ; [ebp+12] - number2
    ; [ebp+16] -gcd

    mov ebx, [ebp + 8]
    mov ecx, [ebp + 12]
    mov esi, [ebp + 16]

    Cycle:
        cmp ecx, 0
        je Finish

        mov eax, ebx
        mov edx, 0
        cdq
        idiv ecx
        mov ebx, ecx
        mov ecx, edx
        jmp Cycle
    
    Finish:
    mov eax, ebx
    cmp eax, 0
    jl Negative

    mov [esi], eax
    jmp Skip

    Negative:
    mov ebx, -1
    imul ebx
    mov [esi], eax

    Skip:
    popa
    pop ebp
    ret

main:
    
    push offset starting_message
    call printf
    add esp, 4

    push offset number2
    push offset number1
    push offset input_format
    call scanf
    add esp, 12

    push offset gcd
    push number2
    push number1
    call GCD_Function
    add esp, 12

    push  gcd
    push offset ending_message
    call printf
    add esp, 8
    ret
end main