;   _____  .___  _________________  
;  /  _  \ |   |/   _____/\_____  \ 
; /  /_\  \|   |\_____  \   _(__  < 
;/    |    \   |/        \ /       \
;\____|__  /___/_______  //______  /
;        \/            \/        \/ 


banner1:
    db '   _____  .___  _________________' ;len 33
banner2:
    db '  /  _  \ |   |/   _____/\_____  \' ; len 34
banner3:
    db ' /  /_\  \|   |\_____  \   _(__  <' ; len 34
banner4:
    db '/    |    \   |/        \ /       \' ; len 35
banner5:
    db '\____|__  /___/_______  //______  /' ; len 35
banner6:
    db '        \/            \/        \/' ; len 34

print_ais3_banner2:
    mov esi, 0xa0
    add esi, 40
    mov edi, 33
    mov ebx, 6
    xor ecx, ecx
    mov edx, banner1
    call print_sub_banner

    mov esi, 0x140
    add esi, 40
    mov edi, 34
    mov ebx, 4
    xor ecx, ecx
    mov edx, banner2
    call print_sub_banner
    
    mov esi, 0x1e0
    add esi, 40
    mov edi, 34
    mov ebx, 2
    xor ecx, ecx
    mov edx, banner3
    call print_sub_banner
    
    mov esi, 0x280
    add esi, 40
    mov edi, 35
    mov ebx, 0
    xor ecx, ecx
    mov edx, banner4
    call print_sub_banner

    mov esi, 0x320
    add esi, 40
    mov edi, 35
    mov ebx, 0
    xor ecx, ecx
    mov edx, banner5
    call print_sub_banner

    mov esi, 0x3c0
    add esi, 40
    mov edi, 34
    mov ebx, 0
    xor ecx, ecx
    mov edx, banner6
    call print_sub_banner
    ret

print_sub_banner:
    cmp ecx, edi
    jz p_end
    mov al, byte[edx+ecx]
    mov byte[gs:esi+ebx],al
    inc ebx
    mov byte[gs:esi+ebx],0xB
    inc ebx
    inc ecx
    jmp print_sub_banner
p_end:
    ret



