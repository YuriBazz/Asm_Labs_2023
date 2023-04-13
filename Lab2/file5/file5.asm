.486
.model flat, stdcall

.data
  n db 99 ;  01100011B 
.data?
  nr db ?
.code 
main:
  xor eax, eax 
  xor ebx, ebx
  mov al, n
  and al, 01010101B 
  shl al, 1
  mov bl, al
  
  mov al, n
  and al, 10101010B 
  shr al, 1
  
  or al, bl 
  mov nr, al
  ret
end main