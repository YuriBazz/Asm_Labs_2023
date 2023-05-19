.486
.model flat, stdcall

.data
  a0 dd 7
  k dd 5
  two dd 2
  three dd 3
.data?
  less_list dw 100 dup (?)
  greater_list dw 100 dup (?)
  
.code

 Function:
;   [ebp+8]  - число а0 
;   [ebp+12] - число k 
;   [ebp+16] - адрес массива 1  
;   [ebp+20] - адрес массива 2 
;   [ebp-4] - для 1 массива
;   [ebp-8] - для 2 массива

  push ebp
  mov ebp, esp
  
  sub esp, 8
  pusha
  
  mov [ebp-4], dword ptr 0
  mov [ebp-8], dword ptr 0
  
  mov ebx, [ebp+8]
  mov esi, [ebp+16]
  mov edi, [ebp+20]
  
  Cycle:
    mov eax, ebx
  
    xor edx, edx
    div two
    cmp edx, 0 
    jne Multiplication
  Compare:
    mov ebx, eax
    cmp ebx, [ebp+12] ; сравнение с k
    jb Greater
  
    mov eax, [ebp-8]
    mov [edi + 4* eax],ebx
    inc dword ptr [ebp-8]
    cmp ebx, 1
    je Finish
    jmp Cycle

  Greater:
    mov eax, [ebp-4]
    mov [esi + 4*eax],ebx
    inc dword ptr [ebp-4]
    cmp ebx, 1
    je Finish
    jmp Cycle
  
  Multiplication:
    mov eax, ebx
    mul three
    inc eax
    jmp Compare
  
  Finish:
    popa
  
    add esp, 8 
    pop ebp
  
  ret

main:
  push offset greater_list
  push offset less_list
  push k
  push a0
  
  call Function
  add esp, 16
  ret
end main