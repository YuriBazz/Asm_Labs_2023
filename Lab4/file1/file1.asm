.486
.model flat, stdcall

.data 
list dw 1,2,3
len equ 3

.data? 
sum dd ?
prod dd ?

.code
main: 
 mov ecx, 0
 mov eax, 1
 mov ebx, 0
 
 Cycle:
  cmp ecx, len
  je Finish
  movzx edx, list[2*ecx]
  inc ecx
  add ebx, edx
  mul edx
  jmp Cycle

 Finish:
  mov sum, ebx
  mov prod, eax

 ret
end main

