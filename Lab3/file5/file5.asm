.486
.model flat, stdcall

.data
 a dd 111000011B
 b dd  10001011B

.code
main:
 mov eax, a
 mov cl, 31

 Cycle:
  cmp b, eax
  jae Finish
  mov ebx, 1
  shl ebx, cl
  not ebx
  and eax, ebx
  dec cl
  jmp Cycle

 Finish:
  mov a, eax
  ret
end main