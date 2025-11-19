section .rodata
	global sbox
	global num_rounds
	sbox db 126, 3, 45, 32, 174, 104, 173, 250, 46, 141, 209, 96, 230, 155, 197, 56, 19, 88, 50, 137, 229, 38, 16, 76, 37, 89, 55, 51, 165, 213, 66, 225, 118, 58, 142, 184, 148, 102, 217, 119, 249, 133, 105, 99, 161, 160, 190, 208, 172, 131, 219, 181, 248, 242, 93, 18, 112, 150, 186, 90, 81, 82, 215, 83, 21, 162, 144, 24, 117, 17, 14, 10, 156, 63, 238, 54, 188, 77, 169, 49, 147, 218, 177, 239, 143, 92, 101, 187, 221, 247, 140, 108, 94, 211, 252, 36, 75, 103, 5, 65, 251, 115, 246, 200, 125, 13, 48, 62, 107, 171, 205, 124, 199, 214, 224, 22, 27, 210, 179, 132, 201, 28, 236, 41, 243, 233, 60, 39, 183, 127, 203, 153, 255, 222, 85, 35, 30, 151, 130, 78, 109, 253, 64, 34, 220, 240, 159, 170, 86, 91, 212, 52, 1, 180, 11, 228, 15, 157, 226, 84, 114, 2, 231, 106, 8, 43, 23, 68, 164, 12, 232, 204, 6, 198, 33, 152, 227, 136, 29, 4, 121, 139, 59, 31, 25, 53, 73, 175, 178, 110, 193, 216, 95, 245, 61, 97, 71, 158, 9, 72, 194, 196, 189, 195, 44, 129, 154, 168, 116, 135, 7, 69, 120, 166, 20, 244, 192, 235, 223, 128, 98, 146, 47, 134, 234, 100, 237, 74, 138, 206, 149, 26, 40, 113, 111, 79, 145, 42, 191, 87, 254, 163, 167, 207, 185, 67, 57, 202, 123, 182, 176, 70, 241, 80, 122, 0
	num_rounds dd 10

section .text
	global treyfer_crypt
	global treyfer_dcrypt

; void treyfer_crypt(char text[8], char key[8]);
treyfer_crypt:
	;; DO NOT MODIFY
	push ebp
	mov ebp, esp
	pusha

	mov esi, [ebp + 8] ; plaintext
	mov edi, [ebp + 12] ; key	
	;; DO NOT MODIFY
	;; FREESTYLE STARTS HERE
	;; TODO implement treyfer_crypt

	mov ecx,[num_rounds]	; eax = num_rounds, numarul de runde de criptare

crypt_text:
	xor eax, eax			; resetam valoarea lui eax
	xor ebx, ebx			; resetam valoarea lui ebx

	mov al, 0				; i = 0
	mov bl, byte [esi]		; in bl am stocat valoarea lui text[0]

for_loop1:

	cmp al, 8				; daca i == 8, atunci am terminat de criptat textul (pentru o rotatie completa)
	je end_for_loop1

	add bl, byte [edi + eax] ; adunam la text[i] valoarea lui key[i]
	mov bl, byte [sbox + ebx] ; t = sbox[t]

	cmp al, 7				; daca i + 1 == 8
	jne continue

	add bl, byte [esi]
	rol bl, 1				; t = (t << 1) | (t >> 7)
	mov byte [esi], bl		; text[(i + 1) % 8] = t
	jmp skip_continue

continue:

	add bl, byte [esi + eax + 1]
	rol bl, 1							; t = (t << 1) | (t >> 7)
	mov byte [esi + eax + 1], bl		; text[(i + 1) % 8] = t

skip_continue:

	inc al
	jmp for_loop1

end_for_loop1:
	loop crypt_text
    ;; FREESTYLE ENDS HERE
	;; DO NOT MODIFY
	popa
	leave
	ret 

; void treyfer_dcrypt(char text[8], char key[8]);
treyfer_dcrypt:
	;; DO NOT MODIFY
	push ebp
	mov ebp, esp
	pusha
	;; DO NOT MODIFY
	;; FREESTYLE STARTS HERE
	;; TODO implement treyfer_dcrypt

	mov esi, [ebp + 8] ; plaintext
	mov edi, [ebp + 12] ; key

	mov ecx,[num_rounds]	; eax = num_rounds, numarul de runde de criptare

decrypt_proccess:
	
	xor eax, eax			; resetam valoarea lui eax
	xor ebx, ebx			; resetam valoarea lui ebx
	xor edx, edx			; resetam valoarea lui edx
	
	mov bl, 7				; bl = 7, va reprezenta indexul i care porneste de la 7 si ajunge la 0

for_loop2:

	mov al, byte [esi + ebx]	; al = text[i]
	add al, byte [edi + ebx]	; al = text[i] + key[i]

	mov al, byte [sbox + eax]	; al = sbox[text[i] + key[i]]

	cmp bl, 7					; daca i == 7
	jne continue2

	mov dl, byte [esi]			; dl = text[0]
	ror dl, 1					; dl = (text[0] >> 1) | (text[0] << 7)
	sub dl, al					; dl = text[0] - sbox[text[i] + key[i]]

	mov byte [esi], dl			; text[0] = dl
	jmp skip_continue2

continue2:

	mov dl, byte [esi + ebx + 1]	; dl = text[i + 1]
	ror dl, 1						; dl = (text[i + 1] >> 1) | (text[i + 1] << 7)
	sub dl, al						; dl = text[i + 1] - sbox[text[i] + key[i]]

	mov byte [esi + ebx + 1], dl	; text[i + 1] = dl

skip_continue2:

	cmp bl, 0
	je done

	dec bl
	jmp for_loop2

done:
	loop decrypt_proccess	
	;; FREESTYLE ENDS HERE
	;; DO NOT MODIFY
	popa
	leave
	ret

