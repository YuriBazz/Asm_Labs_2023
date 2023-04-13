.486
.model flat, stdcall
; (av*bv - cv mod dv)*(cv*dv + av mod bv)
.data
av dd 100
bv dd 100
cv dd 100
dv dd 100

.data?
saver1 dd ?
saver2 dd ?
ev dd ?
.code
main:
 mov eax, av
 mul bv
 mov saver1, eax
 mov eax, cv
 mov edx, 0
 div dv
 sub saver1, edx
 mov eax, cv
 mul dv
 mov saver2, eax
 mov eax, av
 mov edx, 0
 div bv
 add saver2, edx
 mov eax, saver1
 mul saver2
 mov ev, eax
 ret
end main