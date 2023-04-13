.486
.model flat, stdcall

.data
  n dw 12345 ; 0011000000111001B
  i db 1
.data?
  nr dw ?
.code 
main:
  xor eax, eax 
  xor ecx, ecx
  mov ax, 1 
  mov cl, i
  shl ax, cl
  xor ax, n
  mov nr, ax
ret
end main