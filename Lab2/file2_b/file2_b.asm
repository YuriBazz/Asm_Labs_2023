.486
.model flat, stdcall
; (av*bv - cv mod dv)*(cv*dv + av mod bv)


.data
av dd 2
bv dd 3
cv dd -2
dv dd -2

.data?
saver1 dd ?
saver2 dd ?
ev dd ?

.code
main:
 mov eax, av
 imul bv
 mov saver1, eax
 mov eax, cv
 cdq
 idiv dv
 sub saver1, edx
 mov eax, cv
 imul dv
 mov saver2, eax
 mov eax, av
 cdq
 idiv bv
 add saver2, edx
 mov eax, saver1
 imul saver2
 mov ev, eax
 ret
end main