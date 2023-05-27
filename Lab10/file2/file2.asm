.486
.model flat, stdcall

 INCLUDE stdio.inc
 INCLUDELIB msvcrt.lib

.data
 first_message db "Write the first float number: ", 0
 second_message db "Write the second float number: ", 0
 long_float_format db "%lf", 0
 max_format db "The maximum is: %lf", 13, 10, 0
 min_format db "The minimum is: %lf", 13, 10, 0
.data?
 long_float_1 dq ?
 long_float_2 dq ?
 min dq ?
 max dq ?

.code
 main:
    pusha
    push offset first_message
    call printf
    add esp, 4
    popa

    pusha
    push offset long_float_1
    push offset long_float_format
    call scanf
    add esp, 8
    popa

    pusha
    push offset first_message
    call printf
    add esp, 4
    popa

    pusha
    push offset long_float_2
    push offset long_float_format
    call scanf
    add esp, 8
    popa 

    finit
    fld long_float_2
    fld long_float_1
    fcom
    fstsw ax
    sahf

    ja Jump

    fstp min
    fstp max
    jmp Skip

    Jump:
    fstp max
    fstp min

    Skip:

    pusha
    push dword ptr [min+4]
    push dword ptr [min]
    push offset min_format
    call printf
    add esp, 12
    popa

    pusha 
    push dword ptr [max+4]
    push dword ptr [max]
    push offset max_format
    call printf
    add esp, 12
    popa

    ret
 end main



    