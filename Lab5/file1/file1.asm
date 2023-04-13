.486
.model flat, stdcall

.data 
string db "kOvaCH", 0


.code
main:
 First_step:
  cmp string[0], 90
  jbe go_Next
  mov al,string[0]
  sub al, 32
  mov string[0], al

 go_Next:
  mov ecx, 0
  Cycle:
   inc ecx
   cmp string[ecx], 0
   je Finish
   
   cmp string[ecx], 97
   jae Cycle
   mov al, string[ecx]
   add al, 32
   mov string[ecx], al
   jmp Cycle
   
  Finish:
 ret
end main