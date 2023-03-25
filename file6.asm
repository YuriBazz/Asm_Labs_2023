.486
.model flat, stdcall

.data
k dd 3
list dd 1, 7, 9, 10, 12
len equ 5

.data?
newList dd ?, ?, ?, ?, ?
res dd ?

.code 
main:
 mov ecx, 0
 mov ebx, 0
 
 Cycle: 
  cmp ecx, len
  je Finish
  mov eax, list[4*ecx]
  cdq
  idiv k
  cmp edx, 0
  je Multiples
  jmp NotMultiples

 Multiples:
  mov eax, list[4*ecx]
  mov newList[4*ebx], eax
  inc ecx
  inc ebx
  jmp Cycle

 NotMultiples:
  inc ecx
  jmp Cycle

 Finish:
  mov res, ebx 
  

 ret
end main