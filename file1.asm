.486
.model flat, stdcall

.data
a dd 4
b dd -4

.data? 
d dd ? 

.code
main:
 mov eax, a
 mov ebx, b
 cmp eax, ebx
 jge Point
 mov d, ebx
 jmp Finish
Point:
  mov d, eax
 Finish:
 ret
end main

