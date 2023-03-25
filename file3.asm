.486
.model flat, stdcall

.data
years dw 2002, 2008, 2016
len equ 3

.data? 
leaps db ?, ?, ?

.code
main:
 mov ecx, 0
 
 Cycle:
  cmp ecx, len
  je Finish
  mov ax, years[2*ecx]
  mov bx, 400
  mov dx, 0
  div bx
  cmp dx, 0
  je Leap

  mov ax, years[2*ecx]
  mov bx, 4
  mov dx, 0
  div bx
  cmp dx, 0
  je SemiLeap
  jmp NotLeap
  
 Leap:
  mov leaps[ecx], 1
  inc ecx
  jmp Cycle

 SemiLeap:
  mov ax, years[2*ecx]
  mov bx, 100
  mov dx, 0
  div bx
  cmp dx, 0
  jnz Leap
  jmp NotLeap

 NotLeap:
  mov leaps[ecx], 0
  inc ecx
  jmp Cycle
 
 Finish:
 ret
end main