.486
.model flat, stdcall

.data
a dd 3
b dd 2
cv dd 17
dv dd 0

.code 
main:
 mov eax, a
 mul b
 div cv
 mov dv, edx
 ret
end main
 