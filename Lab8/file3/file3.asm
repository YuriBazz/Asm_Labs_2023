.486
.model flat, stdcall

.data
  list dd  8888, 0, 0, 9999, 0
  len equ 5
  des dd 10
.data?
  result db ?
  
.code


Function:
; Считает цифры, записывает.
;   [ebp+8]  - адресс массива
;   [ebp+12] - длина массива
;   [ebp+16] - адресс результата

;   СЧЕТЧИКИ
;   [ebp-1] 0
;   [ebp-2] 1
;   [ebp-3] 2
;   [ebp-4] 3
;   [ebp-5] 4
;   [ebp-6] 5
;   [ebp-7] 6
;   [ebp-8] 7
;   [ebp-9] 8
;   [ebp-10] 9

;   [ebp-11]  локальный максимум для результата
  push ebp
  mov ebp, esp
  
  sub esp, 11
  
  pusha
  
  mov [ebp-1], byte ptr 0;0
  mov [ebp-2], byte ptr 0;1
  mov [ebp-3], byte ptr 0;2
  mov [ebp-4], byte ptr 0;3
  mov [ebp-5], byte ptr 0;4
  mov [ebp-6], byte ptr 0;5
  mov [ebp-7], byte ptr 0;6
  mov [ebp-8], byte ptr 0;7
  mov [ebp-9], byte ptr 0;8
  mov [ebp-10], byte ptr 0;9
  
  mov [ebp-11], byte ptr 0
  
  mov ecx, 0
  mov esi, [ebp+8]
  mov edi, [ebp+16]
  
Cycle:
  cmp ecx, [ebp+12]
  je Cycle_Finish
  mov eax, [esi+4*ecx]
  ;особый случай когда 0 лежит в массиве
  cmp eax, 0
  jne Cycle_Div
  inc byte ptr [ebp-1]
  inc ecx
  jmp Cycle
  
  
Cycle_Div:
  cmp eax, 0
  je Next_Step
  
  xor edx, edx
  div des
  
  cmp edx, 0
  jne Save1
  
  inc byte ptr [ebp-1]
  jmp Cycle_Div
Save1:
  cmp edx, 1
  jne Save2
  
  inc byte ptr [ebp-2]
  jmp Cycle_Div
Save2:
  cmp edx, 2
  jne Save3
  
  inc byte ptr [ebp-3]
  jmp Cycle_Div
Save3:
  cmp edx, 3
  jne Save4
  
  inc byte ptr [ebp-4]
  jmp Cycle_Div
Save4:
  cmp edx, 4
  jne Save5
  
  inc byte ptr [ebp-5]
  jmp Cycle_Div
Save5:
  cmp edx, 5
  jne Save6
  
  inc byte ptr [ebp-6]
  jmp Cycle_Div
Save6:
  cmp edx, 6
  jne Save7
  
  inc byte ptr [ebp-7]
  jmp Cycle_Div
Save7:
  cmp edx, 7
  jne Save8
  
  inc byte ptr [ebp-8]
  jmp Cycle_Div
Save8:
  cmp edx, 8
  jne Save9
  
  inc byte ptr [ebp-9]
  jmp Cycle_Div
Save9:
  inc byte ptr [ebp-10]
  jmp Cycle_Div
  
Next_Step:
  inc ecx
  jmp Cycle
  
Cycle_Finish:
  mov ecx, 0
  mov ch, 1
  mov al, [ebp-1]
Cycle_Result:
  cmp ch, 10
  je Function_Finish
  movzx ebx, ch
  neg ebx
  dec ebx
  mov ah, [ebp+ebx]
  cmp ah, al
  ja Saver 
  
  cmp ah, al
  je Remember_about_this_situation
  inc ch
  jmp Cycle_Result
Saver:
  mov al, [ebp+ebx]
  mov [ebp-11], ch
  inc ch
  jmp Cycle_Result
Remember_about_this_situation:
  mov [ebp-11], ch
  inc ch
  jmp Cycle_Result
  

Function_Finish:
  mov ah, [ebp-11]
  mov [edi], ah
  popa
  
  add esp, 11 
  pop ebp
  
  ret

main:
  push offset result
  push len
  push offset list
  
  call Function
  
  add esp, 12
  ret
end main
