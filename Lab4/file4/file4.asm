.486
.model flat, stdcall

.data
list dw 18, -1, 0C000H, 4000H
len equ 4

.data?
newList db ?, ?, ?, ?

.code
main:
 mov ecx, 0
 mov bl, 10
 
 Cycle:
  cmp ecx, len
  je Finish
  mov ax, list[2*ecx]
  
  idiv bl
  cmp ah, 0
  jge Positive
  jmp Negative

 Positive:
  mov newList[ecx], ah
  inc ecx
  jmp Cycle
 
 Negative:
  neg ah
  mov newList[ecx], ah
  inc ecx
  jmp Cycle

 Finish:

 ret
end main