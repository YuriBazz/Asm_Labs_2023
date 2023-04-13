.486
.model flat, stdcall

.data
string db "500500", 0

.data?
new_string db 56 dub (?)


.code
main:
 mov ecx, 0
 loop_start: 
  cmp string[ecx], 0
  je loop_stop

  inc ecx
  jmp loop_start

 loop_stop:

 dec ecx
 mov eax, 0
 mov bl, 1
 Cycle:
  cmp ecx, 0
  jl Finish
 
  cmp string[ecx], 48
  jnz Not_Zero
  
  cmp bl, 1
  jz Skip
  
  Not_Zero:
   mov bl, string[ecx]
   mov new_string[eax], bl
  
  Skip:
   inc eax
   dec ecx
   jmp Cycle

 Finish:
 inc eax
 mov new_string[eax], 0
 
 ret
end main
