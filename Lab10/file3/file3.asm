.486
.model flat, stdcall
 INCLUDE stdio.inc
 INCLUDELIB msvcrt.lib

.data
 a_message db "Write the first index : ", 0
 b_message db "Write the second index : ", 0
 c_message db "Write the third index: ", 0
 long_float_format db "%lf", 0
 indexes_format db "%lf, %lf, %lf", 0
 real_format db "x_1 = %lf, x_2 = %lf", 0
 complex_format db "x_1 = %lf + %lf * i, x_2 = %lf + %lf * i",0
 two dq 2.0
 zero dq 0.0
 check dd 0

.data?
 a dq ?
 b dq ?
 c_ dq ?
 D dq ?
 Re_x_1 dq ?
 Re_x_2 dq ?
 Im_x_1 dq ?
 Im_x_2 dq ?
 bin dq ?


.code
 main:
    pusha
    push offset a_message
    call printf
    add esp, 4
    popa

    pusha
    push offset a
    push offset long_float_format
    call scanf
    add esp, 8
    popa

    pusha
    push offset b_message
    call printf
    add esp, 4
    popa

    pusha
    push offset b
    push offset long_float_format
    call scanf
    add esp, 8
    popa

    pusha
    push offset c_message
    call printf
    add esp, 4
    popa

    pusha
    push offset c_
    push offset long_float_format
    call scanf
    add esp, 8
    popa

    finit
    fld b
    fld b
    fmul
    fld a
    fmul two
    fmul two
    fld c_
    fmul
    fsub
    ;в стеке лежит D
    fst D
    fcomp zero
    fstsw ax
    sahf

    jae Skip
    inc check
    Skip:

    fld D
    fabs
    fsqrt
    fstp D

    fld b
    fld a
    fmul two
    fdiv
    fchs
    fst Re_x_1
    fstp Re_x_2

    fld D
    fld a
    fmul two
    fdiv 
    fst Im_x_1
    fchs
    fstp Im_x_2

    cmp check, 1
    je Complex_Numbers

    fld Re_x_1
    fadd Im_x_1
    fstp Re_x_1
    fld Re_x_2
    fadd Im_x_2
    fstp Re_x_2

    pusha
    push dword ptr [Re_x_2+4]
    push dword ptr [Re_x_2]
    push dword ptr [Re_x_1+4]
    push dword ptr [Re_x_1]
    push offset real_format
    call printf
    add esp, 20
    popa

    jmp Skip1

    Complex_Numbers:

    pusha    
    push dword ptr [Im_x_2 + 4]
    push dword ptr [Im_x_2]
    push dword ptr [Re_x_2 + 4]
    push dword ptr [Re_x_2]
    push dword ptr [Im_x_1 + 4]
    push dword ptr [Im_x_1]
    push dword ptr [Re_x_1 + 4]
    push dword ptr [Re_x_1]
    push offset complex_format
    call printf
    add esp, 36
    popa

    Skip1:
    ret
 end main