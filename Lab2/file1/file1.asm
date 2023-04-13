.486
.model flat, stdcall

.data
  a dw 1231
  b dw -1 ;0FFFFH или 1111111111111111B
.code 
main:
  not a
  inc a
  ret
  ;mov ax, a
  ;xor ax, b
  ;inc ax
  ;mov a,ax
end main
;