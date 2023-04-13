.486
.model flat, stdcall

.data
list db 1, 2, 3, 4
len equ 4

.data?
reversedList db ?, ?, ?, ?

.code
main:
 mov ecx, len
 dec ecx
 mov ebx, 0
 
 Cycle:
  cmp ebx, len
  je Finish
  mov al, list[ecx]
  mov reversedList[ebx], al
  inc ebx
  dec ecx
  jmp Cycle
 
 Finish:

 ret
end main