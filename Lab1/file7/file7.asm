.486
.model flat, stdcall

.data
a dd 1
b dd 2
res1 dd 101
res2 dd 102
res3 dd 103

.data? 
saverB dd ?

.code
main:
 ;1) Положительный остаток
 mov eax, 0
 sub eax, b
 mov saverB, eax
 mov eax, a
 cdq
 idiv saverB
 mov res1, edx
 mov edx, 0
 ;2) Отрицательный остаток
 mov eax, 0
 sub eax, a
 cdq
 idiv b
 mov res2, edx
 mov edx, 0
 ;3) Отрицательный остаток
 mov eax, 0
 sub eax, a
 cdq
 idiv saverB
 mov res3, edx
 ret
end main