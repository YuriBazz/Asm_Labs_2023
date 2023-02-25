.486
.model flat, stdcall

.data
x1 dw 3 ; 2 байта
x2 dw 4
y1 dw 3
y2 dw 4
sq dd 0 ; 4 байта

.code
main:
 mov ax, x1
 sub ax, x2
 mov bx, y1
 sub bx, y2
 imul bx
 mov sq, eax
 ret
end main
 