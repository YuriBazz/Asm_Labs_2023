.486
.model flat, stdcall

.data
  s db "KoUndefinedUselessStringUvach", 0;UndefinedUselessStringU
  ch_ db 'U'
  min dd 10000
  max dd 0
.data?
  
  s1 db 100 dup (?)
  
.code
main:
  mov ecx, 0
  
  Find_Min:
  cmp s[ecx], 0
  je prod
  
  mov al, s[ecx]
  cmp al, ch_
  je Compare1
  inc ecx
  jmp Find_Min
  
  Compare1:
   cmp ecx, min
   jb Change_Min
   jmp Compare2
  
  Change_Min:
   mov min, ecx
   jmp Compare2
  
  Compare2:
   cmp ecx, max
   ja Change_Max
   inc ecx
   jmp Find_Min
  
  Change_Max:
   mov max, ecx
   inc ecx
   jmp Find_Min
  
  prod:
   mov ecx, 0
   mov edx, 0
   mov ebx, min
   add ebx, max

  cmp ebx, 10000
  jne Deleter
  
  Step2:
   cmp s[ecx], 0
   je Finish
  
  mov al, s[ecx]
  mov s1[ecx], al
  inc ecx
  jmp Step2
  
  Deleter:
   cmp s[ecx], 0
   je Finish
   cmp ecx, min 
   jb Mover
  
  cmp ecx, max 
  ja Mover
  
  inc ecx
  jmp Deleter
  
  Mover:
   mov al, s[ecx]
   mov s1[edx], al
   inc edx
   inc ecx
   jmp Deleter
  
  Finish:
  ret
end main