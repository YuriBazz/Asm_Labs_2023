.486
.model flat, stdcall

.data
 a dd 10001111B
 b dd 11100101B
 k db 0



.code
main:
 mov cl, 0 
 mov edx, 1
 
 Cycle:
  cmp cl, 32
  jz Finish
  mov eax, a
  mov ebx, b
  and eax, edx
  and ebx, edx
  cmp eax, ebx
  jz Equal
  jmp Different

 Different:
  shl edx, 1
  inc cl
  inc k
  jmp Cycle


 Equal:
  shl edx, 1
  inc cl
  jmp Cycle
 

 Finish:

 ret
end main