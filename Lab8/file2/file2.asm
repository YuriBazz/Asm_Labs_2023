.486
.model flat, stdcall

.data
  list dw -1,-2,10,2,5,-5,-8
  len equ 7
.data?
  min dw ?
  max dw ?
.code
;"-" - отрицательные
;"+" - неотрицательные
;если 3 "-" и 3 "+" -  берем "+"

;Результат: eax - 1 - если "+" больше или равно "-", и -1 если наоборот
 Function:
;   [ebp-4] - количество "+"
;   [ebp-8] - количество "-"
;   [ebp+8]  - адресс массива
;   [ebp+12] - длина массива
  push ebp
  mov ebp, esp
  
  sub esp, 8
  
  push esi
  push ecx
  push ebx
  
  mov [ebp-4], dword ptr 0
  mov [ebp-8], dword ptr 0
  
  mov esi, [ebp+8]
  mov ecx, 0
  xor ebx, ebx
 
 Cycle:
  cmp ecx, [ebp+12]
  je Finish
  
  mov bx, [esi+2*ecx]
  cmp bx, 0
  jge Positive
  
  inc dword ptr [ebp-8]
  inc ecx
  jmp Cycle
 
 Positive:
  inc dword ptr [ebp-4]
  inc ecx
  jmp Cycle
 
 Finish:

  mov ebx, [ebp-4]
  cmp ebx, [ebp-8]
  jb Negative
  mov eax, 1
 
  jmp Finish1

 Negative:
  mov eax, -1
 
 Finish1:
  pop ebx
  pop ecx
  pop esi
  
  add esp, 8 
  pop ebp
  
  ret

;поиск максимума м минимума среди "+"  и "-"
; eax  - флаг для понимания кого надо - "+" или "-"

; записывает найденый минимум или максимум в переданные переменные
 Find_Min_And_Max:
;   [ebp-4] - локальный минимум
;   [ebp-8] - локальный максимум
;   [ebp+8] - адрес минимума
;   [ebp+12] - адрес максимума
;   [ebp+16] - адресс массива
;   [ebp+20] - длина массива
  push ebp
  mov ebp, esp
  
  sub esp, 8
  
  push esi
  push ecx
  
  
  mov ecx, 0
  mov esi, [ebp+16]
  
  mov [ebp-4], word ptr 0
  mov [ebp-8], word ptr 0
  
  cmp eax, 1
  je Positive1
  xor eax, eax
  jmp Cycle_Neg
 Positive1:
  xor eax, eax
  jmp Cycle_Pos
  
 Cycle_Neg:
  mov ax, [esi+2*ecx]
  cmp ax, 0
  jl Saver1
  inc ecx
  jmp Cycle_Neg
  
 Cycle_Pos:
  mov ax, [esi+2*ecx]
  cmp ax, 0
  jge Saver2
  inc ecx
  jmp Cycle_Pos
  
 Saver1:
  mov [ebp-4], ax
  mov [ebp-8], ax
  mov ecx, 0
  jmp Cycle_Neg1
 
 Saver2:
  mov [ebp-4], ax
  mov [ebp-8], ax
  mov ecx, 0
  jmp Cycle_Pos1

 Cycle_Neg1:
  cmp ecx, [ebp+20]
  je Finish2
  mov ax, [esi+2*ecx]
  cmp ax, 0
  jl Comp_Min1 
  inc ecx
  jmp Cycle_Neg1

 Comp_Min1:
  cmp ax, [ebp-4];min
  jnle Cmp_Max1 
  mov [ebp-4], ax

 Cmp_Max1:
  cmp ax, [ebp-8];max
  jl Save_Max1
  mov [ebp-8], ax
  
 Save_Max1:
  inc ecx
  jmp Cycle_Neg1

 Cycle_Pos1:
  cmp ecx, [ebp+20]
  je Finish2
  mov ax, [esi+2*ecx]
  cmp ax, 0
  jge Cmp_Min2 
  inc ecx
  jmp Cycle_Pos1

 Cmp_Min2:
  cmp ax, [ebp-4];min
  jnle Cmp_Max2
  mov [ebp-4], ax

 Cmp_Max2:
  cmp ax, [ebp-8];max
  jl Save_Max2
  mov [ebp-8], ax
  
 Save_Max2:
  inc ecx
  jmp Cycle_Pos1





 Finish2:
  mov esi, [ebp+8]
  mov ax, [ebp-4]
  mov [esi], ax
  
  mov esi, [ebp+12]
  mov ax, [ebp-8]
  mov [esi], ax
  
  pop ecx
  pop esi 
  
  add esp, 8 
  pop ebp
  ret 
 main:
  push len
  push offset list
  call Function
  add esp, 8
  
  push len 
  push offset list
  push offset max
  push offset min
  call Find_Min_And_Max
  add esp, 16
  ret
end main
