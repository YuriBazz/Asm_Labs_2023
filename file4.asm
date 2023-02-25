.486
.model flat, stdcall

.data
a dd 3
b dd 3
d dd 1
e dd 0

.code 
main:
 mov eax, a
 mul b
 add eax, d
 mov e, eax
 ret
end main