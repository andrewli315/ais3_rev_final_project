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
    xor cl, cl
    xor di, di
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

    ; just for debug
    ; cmp al, 0x8 ; backspace pressed?
    ; jz backspace_pressed
    ; cmp al, 0x0d ; enter pressed?
    ; jz enter_pressed
    ; mov ah, 0xe
    ; int 0x10 ; print out
    ; stosb
    ; inc cl

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

; just for debug
; backspace_pressed:
;     cmp cl, 0
;     jz get_user_input
;     dec di
;     mov byte [di], 0
;     dec cl
;     mov ah, 0x0e
;     mov al, 0x08
;     int 0x10
;     mov al, ' '
;     int 0x10
;     mov al, 0x08
;     int 0x10
;     jmp get_user_input
; enter_pressed:
;     mov ah, 0x0e
;     mov al, 0x0d
;     int 0x10
;     mov al, 0x0a
;     int 0x10    ; new line

get_secure_mode_done:
    push ebx ; secure mode: 0; non secure mode: 1

    

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
extern RSA_by_c_is_safe_and_sound

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
    mov byte [gs:160], 'P'
;--------載入 kernel--------
    mov ax, KERNEL_START_SECTOR
    mov bx, KERNEL_BASE_ADDR
    mov cx, 20

    call read_disk
;-------- get md5sum of the kernel ----
    push KERN_BIN_SIZE ; better sol: linker script 
    push KERNEL_BASE_ADDR
    push KERN_MD5_BASE ; addr of calculated md5sum
    call _rwf_md5

    xor ecx, ecx
integrity_test:
    cmp ecx, 16 
    jz integrity_test_done
;-------- decrypt stored partial md5sum -------
    mov eax, dword [EFUSE_KEY]
    mov ebx, dword [KERNEL_BASE_ADDR + KERN_BIN_SIZE + ecx]
    xor eax, ebx
    ; mov dword [0x2010 + ecx], eax ! just for debugging
;-------- compare 2 partial md5sum ------------
    mov edx, dword [KERN_MD5_BASE + ecx]
    add ecx, 4
    cmp eax, edx
    jz integrity_test    
    call print_error
    jmp $
integrity_test_done:

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
    mov byte[gs:160], 'V'
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
    mov esi, 0x1e0
    mov byte[gs:esi], 'E' 
    mov byte[gs:esi + 1], 0x0F
    mov byte[gs:esi + 2], 'R' 
    mov byte[gs:esi + 3], 0x0F
    mov byte[gs:esi + 4], 'R' 
    mov byte[gs:esi + 5], 0x0F
    mov byte[gs:esi + 6], 'O' 
    mov byte[gs:esi + 7], 0x0F
    mov byte[gs:esi + 8], 'R' 
    mov byte[gs:esi + 9], 0x0F
    mov byte[gs:esi + 10], '!' 
    mov byte[gs:esi + 11], 0x0F
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
ssmsg1:
    db ' Non secure mode'
ssmsg2:
    db ' Secure mode '
sspointer:
    db '>'
ssspace:
    db ' '

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
