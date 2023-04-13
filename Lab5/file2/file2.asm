.486
.model flat, stdcall

.data 
string db "abrACarBa", 0

.data?
string_length dd ?
res db ?

.code
main:
 mov res, 1
 mov ecx, 0
 mov al, 0
 loop_start: 
  cmp string[ecx], 0
  je loop_stop

  cmp string[ecx], 90
  jae next_Step

  mov al, string[ecx]
  add al, 32
  mov string[ecx], al
  jmp next_Step

  next_Step:
   inc ecx
   jmp loop_start

 loop_stop:
  mov string_length, ecx
  
 dec string_length
 mov ecx, 0
 
 Cycle:
  cmp string[ecx], 0
  je Finish
  
  mov eax, string_length
  sub eax, ecx
  mov bl, string[eax]
  cmp string[ecx], bl
  jnz Bad_Result
  
  inc ecx
  jmp Cycle

  Bad_Result:
   dec res
   jmp Finish


 Finish: 
 ret
end main