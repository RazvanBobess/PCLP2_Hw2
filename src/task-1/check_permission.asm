%include "../include/io.mac"

extern ant_permissions

extern printf
global check_permission

section .text

check_permission:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     eax, [ebp + 8]  ; id and permission
    mov     ebx, [ebp + 12] ; address to return the result
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    mov ecx, eax      ; Copiem argument in registrul ecx
    shr ecx, 24       ; extragem id-ul

    ;; Mutam in registrul edx permisiunile furnicii
    shl eax, 8
    shr eax, 8
    mov edx, [ant_permissions + ecx * 4]
    mov edi, 1

    mov esi, eax
    and eax, edx

    cmp eax, esi 
    jz allowed

    xor edi, edi

allowed :
    mov [ebx], edi

    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
