%include "../include/io.mac"

extern printf
extern position
global solve_labyrinth

; you can declare any helper variables in .data or .bss

section .text

; void solve_labyrinth(int *out_line, int *out_col, int m, int n, char **labyrinth);
solve_labyrinth:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     eax, [ebp + 8]  ; unsigned int *out_line, pointer to structure containing exit position
    mov     ebx, [ebp + 12] ; unsigned int *out_col, pointer to structure containing exit position
    mov     ecx, [ebp + 16] ; unsigned int m, number of lines in the labyrinth
    mov     edx, [ebp + 20] ; unsigned int n, number of colons in the labyrinth
    mov     esi, [ebp + 24] ; char **a, matrix represantation of the labyrinth
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here

    xor eax, eax            ; linie = 0
    xor ebx, ebx            ; coloana = 0

    dec ecx                 ; m = m - 1
    dec edx                 ; n = n - 1

normal_loop:

    cmp eax, ecx            ; if linie == m
    je end

    cmp ebx, edx            ; if coloana == n
    je end

    mov edi, [esi + eax * 4]    ; pointer catre linia a[linie]
    mov byte [edi + ebx], 0x31  ; a[linie][coloana] = '1', pozitia curenta primeste '1'

sus:

    cmp eax, 0              ; if linie == 0, verificam conditiile pentru linia 0

    je stanga              ; go left

    mov edi, [esi + eax * 4 - 4]
    cmp byte [edi + ebx], 0x30      ; if a[linie - 1][coloana] == '0'

    je decrem_eax

stanga:

    cmp ebx, 0              ; if coloana == 0
    je jos                 ; go down

    mov edi, [esi + eax * 4]
    cmp byte [edi + ebx - 1], 0x30      ; if a[linie][coloana - 1] == '0'
    je decrem_ebx

jos:

    mov edi, [esi + eax * 4 + 4]
    cmp byte [edi + ebx], 0x30      ; if a[linie][coloana - 1] == '0'

    je increm_eax

dreapta:

    mov edi, [esi + eax * 4]
    cmp byte [edi + ebx + 1], 0x30      ; if a[linie][coloana + 1] == '0'

    je increm_ebx

decrem_eax:
    dec eax
    jmp normal_loop

increm_ebx:
    inc ebx
    jmp normal_loop

decrem_ebx:
    dec ebx
    jmp normal_loop


increm_eax:
    inc eax
    jmp normal_loop

    ;; Freestyle ends here
end:
    mov ecx, eax
    mov edx, ebx

    mov eax, [ebp + 8] ; *outline
    mov ebx, [ebp + 12] ; *outcol

    mov dword [eax], ecx   ; *outline = linie
    mov dword [ebx], edx   ; *outcol = coloana
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
