.486
.model flat, stdcall

.data
  a dd  10111111010001B ; 10: 12241 - 16: 02FD1H
  a1 dd 10010001111011001111100011000111B  ; 10: 1224113251 - 16: 091ECF8C7H
  n db 12
.code 
main:
  ;a 
  mov eax, a  
  shr eax, 1  
  shl eax, 1  
  mov a, eax  
  ;б
  mov eax, a1  
  mov cl, n 
  shr eax, cl 
  shl eax, cl 
  mov a1, eax
  ret
end main