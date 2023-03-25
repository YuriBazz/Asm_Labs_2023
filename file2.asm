.486
.model flat, stdcall

.data 
n db 7

.data?
facts dd ?, ?, ?, ?, ?, ?, ?

.code
main: 
 mov bl, 0
 mov ecx, 0
 mov eax, 1
 inc n
 
 Cycle:
  cmp bl, n
  je Finish
  mov facts[4*ecx], eax
  inc ecx
  inc bl
  mul ecx
  jmp Cycle

 Finish:
 ret
end main