.486
.model flat, stdcall

.data

av dd 1
bv dd 2
cv dd 0

.code
main:
 mov eax, av
 mov ebx, bv
 sub eax, ebx
 mov cv, eax
 ret
end main
