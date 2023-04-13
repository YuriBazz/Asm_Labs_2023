.486
.model flat, stdcall

.data
 string db "ABC", 0
 

.data?
 substring_Result db 3 dup (?)

 substring_Save db 100 dup (?)


.code 
 main:
   mov eax, 0
    ;Найти максимальный символ -> Удалить все символы, кроме двух, следующих за макисмальным -> 
    ; -> Повторить для нового максимального, удалив все, кроме следующего -> Повторить для третьей буквы 
    ; al - первая буква, ah - вторая буква
    mov ecx, 0
    mov al, -1
    mov ebx, 0
    Find_Greatest_Letter:
        cmp string[ecx], 0
        je Found_Greatest_Letter

        cmp string[ecx], al
        jl Shortcut

        mov al, string[ecx]

        Shortcut:
            inc ecx
            jmp Find_Greates t_Letter
    
    Found_Greatest_Letter:
        mov ecx, 0

    Delete_Letters:
        cmp string[ecx], 0
        je Next_Step

        cmp string[ecx], al
        je Write_Three_Letters

        inc ecx
        jmp Delete_Letters

        Write_Three_Letters:
            mov dl, 1
            Mini_Cycle:
                cmp dl, 4
                je End_Mini_Cycle

                mov dh, string[ecx]
                mov substring_Save[ebx], dh
                inc ebx
                inc ecx
                inc dl
                jmp Mini_Cycle
            End_Mini_Cycle:
                jmp Delete_Letters
    
    Next_Step:
        mov substring_Save[ebx], 0
        mov ecx, 0
        mov ebx, 0
        mov ah , -1
    Find_Second_Letter:
        cmp substring_Save[ecx], 0
        je Found_Second_Letter

        inc ecx
        cmp substring_Save[ecx], ah
        jl Shortcut1

        mov ah, substring_Save[ecx]

        Shortcut1:
            add ecx, 2
            jmp Find_Second_Letter

    Found_Second_Letter:
        mov ecx, 0
        mov ebx, 0
        mov bl, -1

    Find_Last_Letter:
        cmp substring_Save[ecx], 0
        je Found_Last_Letter

        add ecx, 2
        cmp substring_Save[ecx], bl
        jl Shortcut2

        mov bl, substring_Save[ecx]

        Shortcut2:
            inc ecx
            jmp Find_Last_Letter
    
    Found_Last_Letter:
        
    mov substring_Result[0], al
    mov substring_Result[1], ah
    mov substring_Result[2], bl
    mov substring_Result[3], 0

    ret
 end main