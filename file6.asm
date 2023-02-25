.486
.model flat, stdcall

.data
a dd 10
b dd 2
d dd 3

.data?
e db ?
f db ?

.code
main:
 mov eax, a
 cdq
 div b
 mov e, dl
 mov eax, a
 cdq
 idiv d
 mov f, dl
 mov al, e
 mov ah, f
 ret
end main
 