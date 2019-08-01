
; gcd( a , b )
gcd:
    push ebp
    mov ebp, esp
    sub esp, 16
    mov eax , DWORD [ebp + 8]
    mov ebx, DWORD [ebp + 12]

 ; if x == 0; return
 ; if x < y; swap
 L1:
    cmp eax, 0
    je L3
    cmp eax,ebx
    jge L2
    xchg eax,ebx

L2:
    cdq
    idiv ebx
    mov eax, edx ; remainder is in edx
    jmp L1
L3:
    mov eax,ebx
    mov esp,ebp
    pop ebp
    ret

; calculate pow(msg,exponent,modulo)
; ret = 1
; while exponent > 0
;   if exponent & 1 // exponent is odd
;       ret = re

mod_power:
    push ebp
    mov ebp, esp
    sub esp, 32
    ; msg -> ebp + 16
    ; e -> ebp + 12
    mov eax, dword [ebp+16]
    mov ecx, dword [ebp+12]
    ; res = 1, res in esp
    mov edx, 1
    mov [esp], edx
    ; modulo -> ebp + 8
    mov ebx, [ebp+8]
    cdq
    idiv ebx
    ; msg in esp + 4
    mov [esp+4], edx

power_loop_start:
    
    cmp ecx, 0
    je end_pow
    mov eax, ecx
    and eax, 1
    cmp eax, 1
    jne exp_is_even
    mov eax, [esp]
    mov ebx, [esp+4]
    imul eax,ebx
    mov ebx, [ebp+8]
    cdq
    idiv ebx
    mov [esp], edx
; if exponent is even, calculate msg ^ 2 % modulo 
; exponent >> 1
exp_is_even:
    ; exponent = exponent >> 1
    shr ecx, 1
    mov [ebp+12], ecx
    ; x = (x*x) % n
    mov eax, [esp+4]
    imul eax,eax
    ; ebx <- n
    mov ebx, [ebp+8]
    cdq
    ; eax / ebx : x*x / n = eax:quotient, edx:remainder
    idiv ebx
    mov [esp+4], edx
    jmp power_loop_start

end_pow:
    mov eax, [esp]
    mov esp,ebp
    pop ebp
    ret

; modinv(int a, int m)
modinv:
    push ebp
    mov ebp,esp
    sub esp, 16
    ; m
    mov ebx, dword [ebp+8]
    ;  a
    mov eax, dword [ebp+12]
    ; a = a % m
    ; eax = a, ebx = m
    cdq
    idiv ebx
    ; a in local variable
    ; a in esp
    mov [esp], edx
    mov ecx, 1
    mov edx, dword [ebp+8]
    ; edx = m
    ; for i = 1; i < m ; i++
inv_loop:
    cmp ecx,edx
    je end_inv
    mov eax, dword [esp]
    imul eax,ecx
    cdq
    idiv ebx
    mov eax, edx
    cmp eax, 1
    jne jmp_back
    mov eax, ecx
    mov esp,ebp
    pop ebp
    ret
jmp_back:
    inc ecx
    jmp inv_loop
end_inv:
    ; no result for invmod
    mov eax, 0
    mov esp,ebp
    pop ebp
    ret



; parameters: msg , e , n
; return value in eax
rsa_decrypt:
    ;prologue
    push ebp
    mov ebp, esp
    sub esp, 40
    ;set e(public key)
    push dword [ebp + 8 ]
    push dword [ebp + 12]
    push dword [ebp + 16]
    call mod_power
    mov esp,ebp
    pop ebp
    ret

