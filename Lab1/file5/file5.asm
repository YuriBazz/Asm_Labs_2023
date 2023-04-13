.486
.model flat, stdcall

.data
x1 dw 2000 ; 2 байта
x2 dw -2000 
y1 dw 2000
y2 dw -2000

.data?
 sq dd ?

.code
main:
 movsx eax, x1
 movsx ebx, x2
 sub eax, ebx
 mov sq, eax
 movsx ebx, y1
 movsx eax, y2
 sub ebx, eax
 mov eax, sq
 imul ebx
 mov sq, eax
 
 ret
end main
 