.486
.model flat, stdcall


.data 
 n db 6

.data? 
 F dd ?

.code

main:
 mov cl, n
 mov eax, 1
 mov ebx, 1
 
 Cycle:
  cmp cl, 1
  jbe Finish
  mov edx, eax
  add eax, ebx
  mov ebx, edx
  dec cl
  jmp Cycle

 Finish:
  mov F, eax
 ret
end main