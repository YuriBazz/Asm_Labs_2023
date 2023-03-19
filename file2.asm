.486
.model flat, stdcall

.data
a dd -1
b dd 14

.code

main:
 mov eax, a
 imul eax, a
 imul eax, 5
 add eax, 2
 mov ebx, a
 imul ebx, -7
 add eax, ebx
 mov ebx, b
 cmp eax, ebx
 je Point
 mov eax, 0
 jmp Finish
 
 Point:
   mov eax,0
   mov al, 1
 
 Finish:

 ret
end main

