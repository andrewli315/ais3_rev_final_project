%include "boot.inc"

LOADER_STACK_TOP equ LOADER_BASE_ADDR

;--------GDT 相關常數--------
GDT_SIZE    equ  GDT_END-GDT_BASE
GDT_LIMIT   equ  GDT_SIZE-1

;--------記憶體大小記錄在 0x510--------
total_mem_bytes equ 0x510
[BITS 16]
_start:
;--------列印字串--------
    mov sp, LOADER_BASE_ADDR
    mov bp, loadermsg
    mov cx, 17
    mov ax, 0x1301
    mov bx, 0x001f
    mov dx, 0x1800
    int 0x10

;--------print banner----------
    mov bp, ssbr1
    mov cx, 49
    mov ax, 0x1300
    mov bx, 0x0007
    mov dx, 0x030f
    int 0x10
    mov bp, ssbr2
    mov cx, 49
    mov ax, 0x1300
    mov bx, 0x0007
    mov dx, 0x040f
    int 0x10
    mov bp, ssbr3
    mov cx, 49
    mov ax, 0x1300
    mov bx, 0x0007
    mov dx, 0x050f
    int 0x10
    mov bp, ssbr4
    mov cx, 49
    mov ax, 0x1300
    mov bx, 0x0007
    mov dx, 0x060f
    int 0x10
    mov bp, ssbr5
    mov cx, 49
    mov ax, 0x1300
    mov bx, 0x0007
    mov dx, 0x070f
    int 0x10
    mov bp, ssbr6
    mov cx, 49
    mov ax, 0x1300
    mov bx, 0x0007
    mov dx, 0x080f
    int 0x10
    mov bp, ssbr7
    mov cx, 49
    mov ax, 0x1300
    mov bx, 0x0007
    mov dx, 0x090f
    int 0x10
    
;--------get user inupt----------
    xor bx, bx ; default is turning off secure mode
    call print_secure_selector
get_secure_mode:
    mov ah, 0
    int 0x16    ; get user input

    cmp ax, 0x4800
    jz turn_off_secure
    cmp ax, 0x5000
    jz turn_on_secure
    cmp al, 0x0d
    jz get_secure_mode_done

    jmp get_secure_mode

turn_on_secure:
    cmp bx, 1
    jz get_secure_mode
    mov bx, 1
    call print_secure_selector
    jmp get_secure_mode

turn_off_secure:
    cmp bx, 0
    jz get_secure_mode
    mov bx, 0
    call print_secure_selector
    jmp get_secure_mode

print_secure_selector:
    push bx
    cmp bx, 0
    jnz print_non_secure
    mov bp, ssmsg1
    mov cx, 16      ; length
    mov ax, 0x1300  ; mode: output string, don't update cursor position
    mov bx, 0x0070  ; color: BG 7-> RGB
    mov dx, 0x1020  ; position: row:10 col:1b
    int 0x10
    mov bp, ssmsg2
    mov cx, 12
    mov ax, 0x1300
    mov bx, 0x0007
    mov dx, 0x1120
    int 0x10
    mov bp, sspointer
    mov cx, 1
    mov ax, 0x1301
    mov bx, 0x00f0
    mov dx, 0x101f
    int 0x10
    mov bp, ssspace
    mov cx, 1
    mov ax, 0x1300
    mov bx, 0x0000
    mov dx, 0x111f
    int 0x10
    jmp print_secure_selector_end
print_non_secure:
    mov bp, ssmsg1
    mov cx, 16
    mov ax, 0x1300
    mov bx, 0x0007
    mov dx, 0x1020
    int 0x10
    mov bp, ssmsg2
    mov cx, 12
    mov ax, 0x1300
    mov bx, 0x0070
    mov dx, 0x1120
    int 0x10
    mov bp, sspointer
    mov cx, 1
    mov ax, 0x1301
    mov bx, 0x00f0
    mov dx, 0x111f
    int 0x10
    mov bp, ssspace
    mov cx, 1
    mov ax, 0x1300
    mov bx, 0x0000
    mov dx, 0x101f
    int 0x10
print_secure_selector_end:
    pop bx
    ret

get_secure_mode_done:
    mov [0x600], ebx ; secure mode: 0; non secure mode: 1

    ; clear menu
    mov bp, ssmsgclear
    mov cx, 1
    mov ax, 0x1301
    mov bx, 0x00f0
    mov dx, 0x111f
    int 0x10
    mov bp, ssmsgclear
    mov cx, 1
    mov ax, 0x1300
    mov bx, 0x0000
    mov dx, 0x101f
    int 0x10

    xor bx, bx ; default is choose top kernel
    call print_kernel_selector
get_load_kernel:
    mov ah, 0
    int 0x16    ; get user input
    cmp ax, 0x4800
    jz select_up
    cmp ax, 0x5000
    jz select_down
    cmp al, 0x0d
    jz get_load_kernel_done

    jmp get_load_kernel

select_up:
    cmp bx, 0
    jz get_load_kernel
    dec bx
    call print_kernel_selector
    jmp get_load_kernel

select_down:
    cmp bx, 1
    jz get_load_kernel
    inc bx
    call print_kernel_selector
    jmp get_load_kernel

print_kernel_selector:
    push bx
    cmp bx, 0
    jnz print_kernel_selector_2
    mov bp, ksmsg1
    mov cx, 21      ; length
    mov ax, 0x1300  ; mode: output string, don't update cursor position
    mov bx, 0x0070  ; color: FG 7-> RGB
    mov dx, 0x101e  ; position: row:10 col:20
    int 0x10
    mov bp, ksmsg2
    mov cx, 21
    mov ax, 0x1300
    mov bx, 0x0007
    mov dx, 0x111e
    int 0x10
    mov bp, kspointer
    mov cx, 1
    mov ax, 0x1301
    mov bx, 0x0070
    mov dx, 0x101d
    int 0x10
    mov bp, ksspace
    mov cx, 1
    mov ax, 0x1300
    mov bx, 0x0000
    mov dx, 0x111d
    int 0x10
    jmp print_kernel_selector_end
print_kernel_selector_2:
    mov bp, ksmsg1
    mov cx, 21      ; length
    mov ax, 0x1300  ; mode: output string, don't update cursor position
    mov bx, 0x0007  ; color: FG 7-> RGB
    mov dx, 0x101e  ; position: row:10 col:20
    int 0x10
    mov bp, ksmsg2
    mov cx, 21
    mov ax, 0x1300
    mov bx, 0x0070
    mov dx, 0x111e
    int 0x10
    mov bp, kspointer
    mov cx, 1
    mov ax, 0x1301
    mov bx, 0x0070
    mov dx, 0x111d
    int 0x10
    mov bp, ksspace
    mov cx, 1
    mov ax, 0x1300
    mov bx, 0x0000
    mov dx, 0x101d
    int 0x10
print_kernel_selector_end
    pop bx
    ret

get_load_kernel_done:
    mov [0x604], ebx ; kernel id

    mov eax, 3 ; clear screen
    int 0x10
;--------e820 get memory size--------
    xor ebx, ebx
    mov edx, 0x534d4150
    mov di, ards_buf
    e820_mem_get_loop:
        mov eax, 0x0000e820
        mov ecx, 20
        int 0x15
        jc  e820_failed_try_e801
    
        add di, cx
        inc word [ards_nr]
        cmp ebx, 0
        jnz e820_mem_get_loop

    mov cx, [ards_nr]
    mov ebx, ards_buf - 20
    xor edx, edx
    find_max_mem_area:
        add ebx, 20
        mov eax, [ebx+8]
        cmp edx, eax
        jge next_ards
        cmp dword [ebx+16], 1
        jne next_ards
        mov edx, eax
    next_ards:
        loop find_max_mem_area
    jmp  mem_get_ok
;--------e801 get memory size--------
e820_failed_try_e801:
    mov ax, 0xe801
    int 0x15
    jc  e801_failed_go_88        
;below 15MB        
    mov cx, 0x400
    mul cx
    shl edx, 16
    and eax, 0x0000ffff
    or edx, eax
    add edx, 0x100000
    mov esi, edx
;above 16MB
    xor eax, eax
    mov ax, bx
    mov ecx, 0x10000
    mul ecx

    add esi, eax
    mov edx, esi
    jmp mem_get_ok
;--------0x88 get memory size--------
e801_failed_go_88:
    mov ah, 0x99
    int 0x15
    jc error_hlt
    and eax, 0x0000ffff
    mov cx, 0x400
    mul cx
    shl edx, 16
    or  edx, eax
    add edx, 0x100000

;儲存得到的記憶體資訊
mem_get_ok:
    mov [total_mem_bytes], edx
    ; clear terminal
    mov eax, 0x0003
    int 0x10
;--------進入保護模式--------
;1. 開啟 A20 位址線
;2. 讀取 Global Descriptor Table
;3. set cr0 暫存器的 PE 位

;==1==
    in  al, 0x92
    or  al, 10b
    out 0x92, al
;==2==
    lgdt    [gdt_ptr]
;==3==
    mov eax, cr0
    or  eax, 1
    mov cr0, eax

;用 far jump 來設定段暫存器，使之為保護模式下的選擇子
;且清空 pipeline，避免執行解碼錯誤的指令(真實模式下 GDTR 只使用低20位，其他位為0，D 位會是0，造成把 32bit 指令解碼為 16bit 指令)
    jmp dword SELECTOR_CODE:p_mode_start

[BITS 32]
;以32位元指令的格式組譯指令
%include "secure-boot.autogen.inc"

p_mode_start:
;初始化段暫存器
    mov ax, SELECTOR_DATA
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov esp, LOADER_STACK_TOP
    mov ax, SELECTOR_VIDEO
    mov gs, ax
;顯示 P
    ;mov byte [gs:160], 'P'
;--------載入 kernel--------
    ; choose which kernel
    mov ax, [0x604]
    cmp ax, 0
    jnz not_kernel1
    mov ax, KERNEL_START_SECTOR
    jmp choose_kernel_end
not_kernel1:
    mov ax, KERNEL2_START_SECTOR
choose_kernel_end:
    mov bx, KERNEL_BASE_ADDR
    mov cx, 20

    call read_disk
; If user choose to enter secure mode
    mov eax, [0x600]
    cmp eax, 0
    jz integrity_test_done
;-------- get md5sum of the kernel ----
    push KERN_BIN_SIZE ; better sol: linker script 
    push KERNEL_BASE_ADDR
    push KERN_MD5_BASE ; addr of calculated md5sum
    call _rwf_md5

    xor ecx, ecx
    xor ebx, ebx
integrity_test:
    cmp ecx, 16
    jz compare_decrypt
;-------- edit by andrew Li --------------------
;
; this is usage and asm code for rsa decryption
;
; ------- rsa decrypt stored cipehr ------------
    xor eax, eax
    mov ax, word [KERNEL_BASE_ADDR + KERN_BIN_SIZE + ebx ]
    mov ebx, dword [PUB_KEY]
    mov edx, dword [N]
    push ecx
    push eax
    push ebx
    push edx
    call mod_power
    pop ecx
    pop ecx
    pop ecx
    pop ecx
    inc ecx
    mov byte[KERN_MD5_BASE + ecx + 15], al
    mov ebx, ecx
    imul ebx, 2
    jmp integrity_test
; ------ compare decrypt and md5 ---------------
compare_decrypt:
    xor ecx,ecx
loop_compare:
    cmp ecx,16
    jz integrity_test_done
    ; decrypt
    mov eax, dword [KERN_MD5_BASE + 16 + ecx]
    ; calculated md5
    mov edx, dword [KERN_MD5_BASE + ecx]
    add ecx, 4
    cmp eax, edx
    jz loop_compare
    call print_error
    call print_skull
    jmp $
; ----------------------------------------------



;-------- decrypt stored partial md5sum -------
;    mov eax, dword [EFUSE_KEY]
;    mov ebx, dword [KERNEL_BASE_ADDR + KERN_BIN_SIZE + ecx]
;    xor eax, ebx
    ; mov dword [0x2010 + ecx], eax ! just for debugging
;-------- compare 2 partial md5sum ------------
;    mov edx, dword [KERN_MD5_BASE + ecx]
;    add ecx, 4
;    cmp eax, edx
;    jz integrity_test    
;    call print_error
;    jmp $
integrity_test_done:
    ;call print_skull
    call print_ais3_banner2
    ; call RSA_by_c_is_safe_and_sound
    
;--------啟用分頁機制--------
;1. 設定好 Page Directory，Page Table
;2. 把分頁位址放進控制暫存器 cr3（Page Directory Base Register，PDBR）
;3. set cr0 暫存器的 PG 位

;==1==
    call setup_page
;要修改選擇子，否則開啟分頁後會找錯實體位址
    sgdt [gdt_ptr]

    mov ebx, [gdt_ptr + 2]
    or dword [ebx + 0x18 + 4], 0xc0000000

    add dword [gdt_ptr + 2], 0xc0000000

;==2==
    mov eax, PAGE_DIR_TABLE_POS
    mov cr3, eax
;==3==    
    mov eax, cr0
    or eax, 0x80000000
    mov cr0, eax
;重新讀取分頁下的 gdt    
    lgdt [gdt_ptr]
;show a V
    ;mov byte[gs:160], 'V'
;kernel stack
    mov esp, 0xc009f000
    jmp 0xc0000000 | KERNEL_BASE_ADDR
error_hlt:
    jmp $

read_disk:
;--------------------------------
;從硬碟載入到記憶體
;ax:LBA 編號，bx: 載入位址, cx: 載入 block 數
;--------------------------------
    mov esi, eax
    mov di, cx

    mov dx, 0x1f2
    mov al, cl
    out dx, al

    mov eax, esi

    mov dx, 0x1f3
    out dx, al

    mov cl, 8
    shr eax, cl
    mov dx, 0x1f4
    out dx, al

    shr eax, cl
    mov dx, 0x1f5
    out dx, al

    shr eax, cl
    and al, 0x0f    ;24~27 bits for lba
    or  al, 0xe0    ;lba mode
    mov dx, 0x1f6
    out dx, al

    mov dx, 0x1f7
    mov al, 0x20    ;0x20 is read
    out dx, al

    not_ready:
        nop
        in al, dx
        and al, 0x88
        cmp al, 0x08
        jnz not_ready

    mov ax, di
    mov dx, 256
    mul dx
    mov cx, ax
    mov dx, 0x1f0
    go_on_read:
        in ax, dx
        mov [bx], ax
        add bx, 2
        loop go_on_read
    ret


setup_page:
;--------------------------------
;設定 PDE，PTE
;--------------------------------
;每個 PDE 佔 4byte，共 1k 項，要清空 4096byte 的空間
    mov ecx, 1024
    mov esi, 0
    clear_page_dir:
        mov dword [PAGE_DIR_TABLE_POS + esi*4], 0
        inc esi
        loop clear_page_dir
;我們將 PDE PTE 連續放置，所以 PAGE_DIR_TABLE_POS + 0x1000 是第一個 PTE
create_pde:
    mov eax, PAGE_DIR_TABLE_POS
    add eax, 0x1000
    mov ebx, eax
    or eax, PG_US_U | PG_RW_W | PG_P
;讓分頁目錄項的 0x0（第0項）、0xc00（第768項）都存第一分頁的位址
    mov [PAGE_DIR_TABLE_POS + 0x0], eax
    mov [PAGE_DIR_TABLE_POS + 0xc00], eax
;讓分頁目錄表的最後一項指向 PAGE_DIR_TABLE_POS
    sub eax, 0x1000
    mov [PAGE_DIR_TABLE_POS + 4092], eax

;每個 PTE 表 4k 實體對應，1M／4k＝256  
    mov ecx, 256
    mov esi, 0 
    mov edx, PG_US_U | PG_RW_W | PG_P 
create_pte:
    mov [ebx+esi*4], edx
    add edx, 4096
    inc esi
    loop create_pte

    mov eax, PAGE_DIR_TABLE_POS
    add eax, 0x2000
    or eax,  PG_US_U | PG_RW_W | PG_P
    mov ebx, PAGE_DIR_TABLE_POS
    mov ecx, 254
    mov esi, 769
create_kernel_pde:
    mov [ebx+esi*4], eax
    inc esi
    add eax, 0x1000
    loop create_kernel_pde
    ret

print_error:
;--------------------------------
;Print ERROR
;--------------------------------
    mov esi, 0xa0
    mov byte[gs:esi], 'E' 
    mov byte[gs:esi + 1], 0xF4
    mov byte[gs:esi + 2], 'R' 
    mov byte[gs:esi + 3], 0xF4
    mov byte[gs:esi + 4], 'R' 
    mov byte[gs:esi + 5], 0xF4
    mov byte[gs:esi + 6], 'O' 
    mov byte[gs:esi + 7], 0xF4
    mov byte[gs:esi + 8], 'R' 
    mov byte[gs:esi + 9], 0xF4
    mov byte[gs:esi + 10], '!' 
    mov byte[gs:esi + 11], 0xF4
    mov ebx,0x280 
    xor ecx, ecx
print_loop:
    cmp ecx, 34
    jz print_error_end
    mov al, byte [STR+ecx]
    mov byte[gs:esi+ebx], al
    inc ebx
    mov byte[gs:esi+ebx], 0x4
    inc ebx
    inc ecx
    jmp print_loop
print_error_end:
    ret 

;--------GDT--------
;第0個不可用
GDT_BASE:   
    dd 0x00000000
    dd 0x00000000

;平坦模型下的 cs
GDT_DESC:
    dd 0x0000ffff
    dd DESC_CODE_HIGH4

;平坦模型下的 ds，ss
DATA_STACK_DESC:    
    dd  0x0000ffff
    dd  DESC_DATA_HIGH4

;文字模式顯卡的記憶體位置 0xb8000~0xbffff ,((0xbffff-0xb8000)+1)/4-1 = 7
VIDEO_DESC:    
    dd  0x80000007
    dd  DESC_VIDEO_HIGH4

GDT_END:

gdt_ptr:     
    dw  GDT_LIMIT
    dd  GDT_BASE

;Address Range Descriptor Structure
ards_buf times 200 db 0
ards_nr dw 0

loadermsg: 
    db '2 loader in real.'

; ss: secure selector 
ssmsgclear:
    db '                 '
ssmsg1:
    db ' Non secure mode'
ssmsg2:
    db ' Secure mode'
sspointer:
    db '>'
ssspace:
    db ' '

; ks: kernel selector 
ksmsgclear:
    db '                      '
ksmsg1:
    db ' 1. Terry NiNi Kernel'
ksmsg2:
    db ' 2. ????? ???? Kernel'
kspointer:
    db '>'
ksspace:
    db ' '

STR:
    db 'You did not pass the'
    db ' verification!' ;

; ssb: secure selector banner
;           :::     ::::::::::: ::::::::   ::::::::
;        :+: :+:       :+:    :+:    :+: :+:    :+:
;      +:+   +:+      +:+    +:+               +:+ 
;    +#++:++#++:     +#+    +#++:++#++     +#++:   
;   +#+     +#+     +#+           +#+        +#+   
;  #+#     #+#     #+#    #+#    #+# #+#    #+#    
; ###     ### ########### ########   ########      
; length of a row: 49
ssbr1:
    db '          :::     ::::::::::: ::::::::   ::::::::' ; length 49
ssbr2:
    db '       :+: :+:       :+:    :+:    :+: :+:    :+:'
ssbr3:
    db '     +:+   +:+      +:+    +:+               +:+ '
ssbr4:
    db '   +#++:++#++:     +#+    +#++:++#++     +#++:   '
ssbr5:
    db '  +#+     +#+     +#+           +#+        +#+   '
ssbr6:
    db ' #+#     #+#     #+#    #+#    #+# #+#    #+#    '
ssbr7:
    db '###     ### ########### ########   ########      '

%include "md5.inc"
%include "math.inc"
%include "banner2.inc"
%include "skull.inc"
