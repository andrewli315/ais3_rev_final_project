
;
; aaaaa      iiiiii    ssssss     333333
;aa   aa       ii     sss             33
;a     aa      ii      ssss       333333  
;aa   aaa      ii         sss         33 
; aaaaa aa   iiiiii   ssssss      333333   

;
;
;....###....####..######...#######.
;...##.##....##..##....##.##.....##
;..##...##...##..##..............##
;.##.....##..##...######...#######.
;.#########..##........##........##
;.##.....##..##..##....##.##.....##
;.##.....##.####..######...#######.
;
;
;
print_ais3_banner:
    mov esi, 0x1e0
    mov byte[gs:esi], ' '
    mov byte[gs:esi+1], 0xF
    mov byte[gs:esi+2], 'a'
    mov byte[gs:esi+3], 0xF
    mov byte[gs:esi+4], 'a'
    mov byte[gs:esi+5], 0xF
    mov byte[gs:esi+6], 'a'
    mov byte[gs:esi+7], 0xF
    mov byte[gs:esi+8], 'a'
    mov byte[gs:esi+9], 0xF
    mov byte[gs:esi+10], 'a'
    mov byte[gs:esi+11], 0xF
    mov byte[gs:esi+22], 'i'
    mov byte[gs:esi+23], 0xF
    mov byte[gs:esi+24], 'i'
    mov byte[gs:esi+25], 0xF
    mov byte[gs:esi+26], 'i'
    mov byte[gs:esi+27], 0xF
    mov byte[gs:esi+28], 'i'
    mov byte[gs:esi+29], 0xF
    mov byte[gs:esi+30], 'i'
    mov byte[gs:esi+31], 0xF
    mov byte[gs:esi+32], 'i'
    mov byte[gs:esi+33], 0xF
    mov byte[gs:esi+42], 's'
    mov byte[gs:esi+43], 0xF
    mov byte[gs:esi+44], 's'
    mov byte[gs:esi+45], 0xF
    mov byte[gs:esi+46], 's'
    mov byte[gs:esi+47], 0xF
    mov byte[gs:esi+48], 's'
    mov byte[gs:esi+49], 0xF
    mov byte[gs:esi+50], 's'
    mov byte[gs:esi+51], 0xF
    mov byte[gs:esi+52], 's'
    mov byte[gs:esi+53], 0xF
    mov byte[gs:esi+62], '3'
    mov byte[gs:esi+63], 0xF
    mov byte[gs:esi+64], '3'
    mov byte[gs:esi+65], 0xF
    mov byte[gs:esi+66], '3'
    mov byte[gs:esi+67], 0xF
    mov byte[gs:esi+68], '3'
    mov byte[gs:esi+69], 0xF
    mov byte[gs:esi+70], '3'
    mov byte[gs:esi+71], 0xF
    mov byte[gs:esi+72], '3'
    mov byte[gs:esi+73], 0xF
    mov byte[gs:esi+0xa0], 'a'
    mov byte[gs:esi+0xa0+1], 0xF
    mov byte[gs:esi+0xa0+2], 'a'
    mov byte[gs:esi+0xa0+3], 0xF
    mov byte[gs:esi+0xa0+10], 'a'
    mov byte[gs:esi+0xa0+11], 0xF
    mov byte[gs:esi+0xa0+12], 'a'
    mov byte[gs:esi+0xa0+13], 0xF
    mov byte[gs:esi+0xa0+26], 'i'
    mov byte[gs:esi+0xa0+27], 0xF
    mov byte[gs:esi+0xa0+28], 'i'
    mov byte[gs:esi+0xa0+29], 0xF
    mov byte[gs:esi+0xa0+40], 's'
    mov byte[gs:esi+0xa0+41], 0xF
    mov byte[gs:esi+0xa0+42], 's'
    mov byte[gs:esi+0xa0+43], 0xF
    mov byte[gs:esi+0xa0+44], 's'
    mov byte[gs:esi+0xa0+45], 0xF
    mov byte[gs:esi+0xa0+70], '3'
    mov byte[gs:esi+0xa0+71], 0xF
    mov byte[gs:esi+0xa0+72], '3'
    mov byte[gs:esi+0xa0+73], 0xF
    mov byte[gs:esi+0x140], 'a'
    mov byte[gs:esi+0x140+1], 0xF
    mov byte[gs:esi+0x140+12], 'a'
    mov byte[gs:esi+0x140+13], 0xF
    mov byte[gs:esi+0x140+14], 'a'
    mov byte[gs:esi+0x140+15], 0xF
    mov byte[gs:esi+0x140+26], 'i'
    mov byte[gs:esi+0x140+27], 0xF
    mov byte[gs:esi+0x140+28], 'i'
    mov byte[gs:esi+0x140+29], 0xF
    mov byte[gs:esi+0x140+42], 's'
    mov byte[gs:esi+0x140+43], 0xF
    mov byte[gs:esi+0x140+44], 's'
    mov byte[gs:esi+0x140+45], 0xF
    mov byte[gs:esi+0x140+46], 's'
    mov byte[gs:esi+0x140+47], 0xF
    mov byte[gs:esi+0x140+48], 's'
    mov byte[gs:esi+0x140+49], 0xF
    mov byte[gs:esi+0x140+62], '3'
    mov byte[gs:esi+0x140+63], 0xF
    mov byte[gs:esi+0x140+64], '3'
    mov byte[gs:esi+0x140+65], 0xF
    mov byte[gs:esi+0x140+66], '3'
    mov byte[gs:esi+0x140+67], 0xF
    mov byte[gs:esi+0x140+68], '3'
    mov byte[gs:esi+0x140+69], 0xF
    mov byte[gs:esi+0x140+70], '3'
    mov byte[gs:esi+0x140+71], 0xF
    mov byte[gs:esi+0x140+72], '3'
    mov byte[gs:esi+0x140+73], 0xF
    mov byte[gs:esi+0x1e0], 'a'
    mov byte[gs:esi+0x1e0+1], 0xF
    mov byte[gs:esi+0x1e0+2], 'a'
    mov byte[gs:esi+0x1e0+3], 0xF
    mov byte[gs:esi+0x1e0+10], 'a'
    mov byte[gs:esi+0x1e0+11], 0xF
    mov byte[gs:esi+0x1e0+12], 'a'
    mov byte[gs:esi+0x1e0+13], 0xF
    mov byte[gs:esi+0x1e0+26], 'i'
    mov byte[gs:esi+0x1e0+27], 0xF
    mov byte[gs:esi+0x1e0+28], 'i'
    mov byte[gs:esi+0x1e0+29], 0xF
    mov byte[gs:esi+0x1e0+48], 's'
    mov byte[gs:esi+0x1e0+49], 0xF
    mov byte[gs:esi+0x1e0+50], 's'
    mov byte[gs:esi+0x1e0+51], 0xF
    mov byte[gs:esi+0x1e0+52], 's'
    mov byte[gs:esi+0x1e0+53], 0xF
    mov byte[gs:esi+0x1e0+70], '3'
    mov byte[gs:esi+0x1e0+71], 0xF
    mov byte[gs:esi+0x1e0+72], '3'
    mov byte[gs:esi+0x1e0+73], 0xF
    mov byte[gs:esi+0x280+2], 'a'
    mov byte[gs:esi+0x280+3], 0xF
    mov byte[gs:esi+0x280+4], 'a'
    mov byte[gs:esi+0x280+5], 0xF
    mov byte[gs:esi+0x280+6], 'a'
    mov byte[gs:esi+0x280+7], 0xF
    mov byte[gs:esi+0x280+8], 'a'
    mov byte[gs:esi+0x280+9], 0xF
    mov byte[gs:esi+0x280+10], 'a'
    mov byte[gs:esi+0x280+11], 0xF

    mov byte[gs:esi+0x280+14], 'a'
    mov byte[gs:esi+0x280+15], 0xF
    mov byte[gs:esi+0x280+16], 'a'
    mov byte[gs:esi+0x280+17], 0xF
    mov byte[gs:esi+0x280+22], 'i'
    mov byte[gs:esi+0x280+23], 0xF
    mov byte[gs:esi+0x280+24], 'i'
    mov byte[gs:esi+0x280+25], 0xF
    mov byte[gs:esi+0x280+26], 'i'
    mov byte[gs:esi+0x280+27], 0xF
    mov byte[gs:esi+0x280+28], 'i'
    mov byte[gs:esi+0x280+29], 0xF
    mov byte[gs:esi+0x280+30], 'i'
    mov byte[gs:esi+0x280+31], 0xF
    mov byte[gs:esi+0x280+32], 'i'
    mov byte[gs:esi+0x280+33], 0xF

    mov byte[gs:esi+0x280+40], 's'
    mov byte[gs:esi+0x280+41], 0xF
    mov byte[gs:esi+0x280+42], 's'
    mov byte[gs:esi+0x280+43], 0xF
    mov byte[gs:esi+0x280+44], 's'
    mov byte[gs:esi+0x280+45], 0xF
    mov byte[gs:esi+0x280+46], 's'
    mov byte[gs:esi+0x280+47], 0xF
    mov byte[gs:esi+0x280+48], 's'
    mov byte[gs:esi+0x280+49], 0xF
    mov byte[gs:esi+0x280+50], 's'
    mov byte[gs:esi+0x280+51], 0xF

    mov byte[gs:esi+0x280+62], '3'
    mov byte[gs:esi+0x280+63], 0xF
    mov byte[gs:esi+0x280+64], '3'
    mov byte[gs:esi+0x280+65], 0xF
    mov byte[gs:esi+0x280+66], '3'
    mov byte[gs:esi+0x280+67], 0xF
    mov byte[gs:esi+0x280+68], '3'
    mov byte[gs:esi+0x280+69], 0xF
    mov byte[gs:esi+0x280+70], '3'
    mov byte[gs:esi+0x280+71], 0xF
    mov byte[gs:esi+0x280+72], '3'
    mov byte[gs:esi+0x280+73], 0xF
    ret



