;                  _________-----_____
;       _____------           __      ----_
;___----             ___------              \
;   ----________        ----                 \
;               -----__    |             _____)
;                    __-                /     \
;        _______-----    ___--          \    /)\
;  ------_______      ---____            \__/  /
;               -----__    \ --    _          /\
;                      --__--__     \_____/   \_/\
;                              ----|   /          |
;                                  |  |___________|
;                                  |  | ((_(_)| )_)
;                                  |  \_((_(_)|/(_)
;                                  \             (
;                                   \_____________)

print_skull:
    mov esi, 20
    mov ecx, 9
    mov ebx,36
    call print__
    mov ecx,5
    call print_
    mov ecx, 5
    call print__
    mov ebx, 0xa0
    add ebx, 20
    add ebx, 16
    mov ecx, 5
    call print__
    mov ecx, 6
    call print_
    add ebx, 22
    mov ecx, 2
    call print__
    add ebx, 10
    mov ecx, 4
    call print_
    mov byte[gs:esi+ebx], '_'
    mov byte[gs:esi+ebx+1], 0xF
    mov ebx, 0x140
    add ebx, 20
    mov ecx, 3
    call print__
    mov ecx, 4
    call print_
    add ebx, 26
    mov ecx, 3
    call print__
    mov ecx, 6
    call print_
    add ebx,28
    mov byte[gs:esi+ebx], '\'
    mov byte[gs:esi+ebx+1], 0xF
    mov ebx, 0x1e6
    add ebx, 20
    mov ecx, 4
    call print_
    mov ecx, 8
    call print__
    add ebx, 16
    mov ecx, 4
    call print_
    add ebx,34
    mov byte[gs:esi+ebx], '\'
    mov byte[gs:esi+ebx+1], 0xF
    mov ebx, 0x280
    add ebx, 20
    add ebx, 28
    mov ecx, 5
    call print_
    mov ecx,2
    call print__
    add ebx, 8

    mov byte[gs:esi+ebx], '|'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx,28
    mov ecx, 5
    call print__
    mov byte[gs:esi+ebx], ')'
    mov byte[gs:esi+ebx+1], 0xF
    mov ebx, 0x320
    add ebx, 20
    add ebx, 38

    mov byte[gs:esi+ebx], '_'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], '_'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx,2
    mov byte[gs:esi+ebx], '-'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    add ebx, 32

    mov byte[gs:esi+ebx], '/'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    add ebx, 10
    mov byte[gs:esi+ebx], '\'
    mov byte[gs:esi+ebx+1], 0xF
    
    mov ebx, 0x3c0
    add ebx, 20
    add ebx, 16
    mov ecx, 7
    call print__
    mov ecx, 5
    call print_
    add ebx, 8
    mov ecx, 3
    call print__
    mov ecx, 2
    call print_
    add ebx,20
    mov byte[gs:esi+ebx], '\'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 8

    mov byte[gs:esi+ebx], '/'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx,2    
    mov byte[gs:esi+ebx], ')'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx,2
    mov byte[gs:esi+ebx], '\'
    mov byte[gs:esi+ebx+1], 0xF
    
    mov ebx, 0x464
    add ebx, 20
    mov ecx, 6
    call print_
    mov ecx, 7
    call print__
    add ebx, 12
    mov ecx, 3 
    call print_
    mov ecx, 4
    call print__
    
    add ebx, 24
    mov byte[gs:esi+ebx], '\'
    mov byte[gs:esi+ebx+1], 0xF
    mov ecx, 2
    call print__
    mov byte[gs:esi+ebx], '/'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 6
    mov byte[gs:esi+ebx], '/'
    mov byte[gs:esi+ebx+1], 0xF
    mov ebx, 0x500
    add ebx, 20
    add ebx, 30
    mov ecx, 5
    call print_
    mov ecx, 2
    call print__
    add ebx, 8
    mov byte[gs:esi+ebx], '\'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx,4
    mov ecx, 2
    call print_
    add ebx, 8
    mov byte[gs:esi+ebx], '_'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 22
    mov byte[gs:esi+ebx], '/'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], '\'
    mov byte[gs:esi+ebx+1], 0xF
    mov ebx, 0x5a0
    add ebx, 20
    add ebx, 46
    mov ecx, 2
    call print_
    mov ecx, 6
    call print__
    add ebx, 8
    mov byte[gs:esi+ebx], '\'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov ecx, 5
    call print__
    mov byte[gs:esi+ebx], '/'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 6
    mov byte[gs:esi+ebx], '\'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], '_'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], '/'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], '\'
    mov byte[gs:esi+ebx+1], 0xF
    mov ebx, 0x640
    add ebx, 20
    add ebx, 62
    mov ecx, 4
    call print_
    
    mov byte[gs:esi+ebx], '|'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 6
    mov byte[gs:esi+ebx], '/'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 22
    mov byte[gs:esi+ebx], '|'
    mov byte[gs:esi+ebx+1], 0xF
    mov ebx,0x6e0
    add ebx, 20
    add ebx, 70
    mov byte[gs:esi+ebx], '|'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx,4
    mov byte[gs:esi+ebx], '|'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov ecx, 11
    call print__
    mov byte[gs:esi+ebx], '|'
    mov byte[gs:esi+ebx+1], 0xF
    mov ebx, 0x780
    add ebx, 20
    add ebx, 70 
    mov byte[gs:esi+ebx], '|'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 4
    mov byte[gs:esi+ebx], '|'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 4 
    mov byte[gs:esi+ebx], '('
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], '('
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], '_'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], '('
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], '_'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], ')'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], '|'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 4
    mov byte[gs:esi+ebx], ')'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    
    mov byte[gs:esi+ebx], '_'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], ')'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2

    mov ebx,0x6e0
    add ebx, 20
    add ebx, 70
    mov byte[gs:esi+ebx], '|'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx,4
    mov byte[gs:esi+ebx], '|'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov ecx, 11
    call print__
    mov byte[gs:esi+ebx], '|'
    mov byte[gs:esi+ebx+1], 0xF
    mov ebx, 0x820
    add ebx, 20
    add ebx, 70 
    mov byte[gs:esi+ebx], '|'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 4
    mov byte[gs:esi+ebx], '|'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 4 
    mov byte[gs:esi+ebx], '('
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], '('
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], '_'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], '('
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], '_'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], ')'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], '|'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], '/'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], ')'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    
    mov byte[gs:esi+ebx], '_'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov byte[gs:esi+ebx], ')'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    
    mov ebx, 0x8c0
    add ebx, 20
    add ebx, 70
    mov byte[gs:esi+ebx], '\'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 28
    mov byte[gs:esi+ebx], '('
    mov byte[gs:esi+ebx+1], 0xF
    
    mov ebx, 0x960
    add ebx, 20
    add ebx, 72
    mov byte[gs:esi+ebx], '\'
    mov byte[gs:esi+ebx+1], 0xF
    add ebx, 2
    mov ecx, 13
    call print__
    mov byte[gs:esi+ebx], ')'
    mov byte[gs:esi+ebx+1], 0xF

    ret




print__:
    mov byte [gs:esi+ebx], '_'
    inc ebx
    mov byte [gs:esi+ebx], 0xF
    inc ebx
    dec ecx
    cmp ecx, 0
    jne print__
    ret
print_:
    mov byte[gs:esi+ebx], '-'
    inc ebx
    mov byte[gs:esi+ebx], 0xF
    inc ebx
    dec ecx
    cmp ecx,0
    jne print_
    ret
