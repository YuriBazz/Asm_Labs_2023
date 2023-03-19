.486
.model flat, stdcall

.data 
 a dd 4
 b dd 2

.data?
 gcd dd ?
.code 
 main:
 mov eax, a
 mov ebx, b
 
 Cycle:
  cmp ebx, 0
  jz Finish
  mov edx, 0
  div ebx
  mov eax, ebx
  mov ebx, edx
  jmp Cycle

 Finish:
  mov gcd, eax
 ret
end main
