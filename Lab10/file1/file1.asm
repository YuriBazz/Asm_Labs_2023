.486
.model flat, stdcall

 INCLUDE stdio.inc
 INCLUDELIB msvcrt.lib

.data
 starting_message db "Write an integer number:" , 0
 int_format db "%u", 0
 ending_message db "Sum is: %lf", 13, 10,0
 k dq 0.0
 sum dq 0.0
 one dq 1.0

.data?
 n dd ?
 k_ dq ? 

.code
 main:
    pusha
    push offset starting_message
    call printf
    add esp, 4
    popa

    pusha
    push offset n
    push offset int_format
    call scanf
    add esp, 8 
    popa

    finit 

    Cycle:
        cmp n, 0
        je Finish

        fld k
        fadd one
        fstp k
        fld k 
        fmul k
        fstp k_
        fld1
        fdiv k_

        fadd sum
        fstp sum
        dec n
        jmp Cycle
    
    Finish:

    push dword ptr [sum+4]
    push dword ptr [sum]
    push offset ending_message
    call printf
    add esp, 12

    ret
 end main


