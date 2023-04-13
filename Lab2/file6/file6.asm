.486
.model flat, stdcall



.data
  n dw 54223 ;1101001111001111B 
  i db 9
.data?
  nr dw ?
.code
main:
  
  xor ecx, ecx
  xor eax,eax
  xor ebx, ebx
  
  mov ax, n 
  
  mov cl, 15
  sub cl, i
  add cl, 1
  
  shl ax, cl
  shr ax, cl
  mov bx, ax
  
 
  mov cl, i
  add cl, 1
  
  mov ax,n
  shr ax, cl
  sub cl, 1
  shl ax, cl
  
  or ax,bx
  mov nr,ax
  ret
end main