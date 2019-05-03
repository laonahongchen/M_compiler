





default rel

global __print
global __println
global __getString
global __getInt
global __toString
global __string_length
global __string_substring
global __string_parseInt
global __string_ord
global __stringConcat
global __stringComp
global main

extern strcmp
extern __sprintf_chk
extern __stack_chk_fail
extern memcpy
extern malloc
extern __isoc99_scanf
extern puts
extern __printf_chk
extern _GLOBAL_OFFSET_TABLE_


SECTION .text

__print:
        lea     rdx, [rdi+8H]
        mov     rsi, L_011
        mov     edi, 1
        xor     eax, eax
        jmp     __printf_chk

ALIGN   16

__println:
        add     rdi, 8
        jmp     puts

ALIGN   8

__getString:
        push    rbp
        push    rbx
        mov     rsi, __buffer.3340
        mov     rdi, L_011
        xor     eax, eax
        sub     rsp, 8
        call    __isoc99_scanf
        mov     rcx, __buffer.3340
        mov     rbx, rcx

L_001:  mov     edx, dword [rbx]
        add     rbx, 4
        lea     eax, [rdx-1010101H]
        not     edx
        and     eax, edx
        and     eax, 80808080H
        jz      L_001
        mov     edx, eax
        shr     edx, 16
        test    eax, 8080H
        cmove   eax, edx
        lea     rdx, [rbx+2H]
        mov     esi, eax
        cmove   rbx, rdx
        add     sil, al
        sbb     rbx, 3
        sub     rbx, rcx
        lea     edi, [rbx+8H]
        movsxd  rdi, edi
        call    malloc
        mov     rbp, rax
        lea     rdx, [rbx+1H]
        movsxd  rax, ebx
        lea     rdi, [rbp+8H]
        mov     rsi, __buffer.3340
        mov     qword [rbp], rax
        call    memcpy
        add     rsp, 8
        mov     rax, rbp
        pop     rbx
        pop     rbp
        ret

__getInt:
        sub     rsp, 24
        mov     rdi, L_012
        mov     rax, qword [fs:abs 28H]
        mov     qword [rsp+8H], rax
        xor     eax, eax
        mov     rsi, rsp
        call    __isoc99_scanf
        mov     rdx, qword [rsp+8H]
        xor     rdx, qword [fs:abs 28H]
        mov     rax, qword [rsp]
        jnz     L_002
        add     rsp, 24
        ret

L_002:  call    __stack_chk_fail

ALIGN   16

__toString:
        push    rbp
        push    rbx
        mov     rbp, rdi
        mov     edi, 32
        sub     rsp, 8
        call    malloc
        lea     rcx, [rel L_012]
        lea     rdi, [rax+8H]
        mov     rbx, rax
        mov     r8, rbp
        mov     edx, 24
        mov     esi, 1
        xor     eax, eax
        call    __sprintf_chk
        cdqe
        mov     qword [rbx], rax
        add     rsp, 8
        mov     rax, rbx
        pop     rbx
        pop     rbp
        ret

ALIGN   16

__string_length:
        mov     rax, qword [rdi]
        ret

ALIGN   16

__string_substring:
        push    r14
        push    r13
        mov     r14, rsi
        push    r12
        push    rbp
        mov     r12, rdi
        push    rbx
        mov     ebx, edx
        sub     ebx, esi
        lea     edi, [rbx+0AH]
        lea     ebp, [rbx+1H]
        movsxd  rdi, edi
        call    malloc
        test    ebp, ebp
        mov     r13, rax
        movsxd  rax, ebp
        mov     qword [r13], rax
        jle     L_003
        mov     edx, ebx
        lea     rdi, [r13+8H]
        lea     rsi, [r12+r14+8H]
        add     rdx, 1
        call    memcpy

L_003:  add     ebp, 8
        mov     rax, r13
        movsxd  rbp, ebp
        pop     rbx
        mov     byte [r13+rbp], 0
        pop     rbp
        pop     r12
        pop     r13
        pop     r14
        ret

ALIGN   8

__string_parseInt:
        movsx   eax, byte [rdi+8H]
        cmp     al, 45
        jz      L_006
        lea     edx, [rax-30H]
        cmp     dl, 9
        ja      L_007
        lea     rcx, [rdi+8H]
        xor     edi, edi

L_004:  xor     edx, edx

ALIGN   16

L_005:  lea     edx, [rdx+rdx*4]
        add     rcx, 1
        lea     edx, [rax+rdx*2-30H]
        movsx   eax, byte [rcx]
        lea     esi, [rax-30H]
        cmp     sil, 9
        jbe     L_005
        movsxd  rcx, edx
        neg     edx
        test    edi, edi
        movsxd  rax, edx
        cmove   rax, rcx
        ret

ALIGN   16

L_006:  movsx   eax, byte [rdi+9H]
        lea     rcx, [rdi+9H]
        lea     edx, [rax-30H]
        cmp     dl, 9
        ja      L_007
        mov     edi, 1
        jmp     L_004

ALIGN   16

L_007:  xor     eax, eax
        ret

ALIGN   16

__string_ord:
        movsx   rax, byte [rdi+rsi+8H]
        ret

ALIGN   16

__stringConcat:
        push    r14
        push    r13
        mov     r14, rdi
        push    r12
        push    rbp
        mov     r13, rsi
        push    rbx
        mov     rbx, qword [rdi]
        mov     r12, qword [rsi]
        lea     rdi, [rbx+r12+9H]
        call    malloc
        mov     rbp, rax
        lea     rax, [rbx+r12]
        test    rbx, rbx
        mov     qword [rbp], rax
        jle     L_010
        lea     rdi, [rbp+8H]
        lea     rsi, [r14+8H]
        mov     rdx, rbx
        add     ebx, 8
        call    memcpy
        movsxd  rax, ebx
L_008:  test    r12, r12
        jle     L_009
        movsxd  rdi, ebx
        lea     rsi, [r13+8H]
        mov     rdx, r12
        add     rdi, rbp
        call    memcpy
        lea     eax, [rbx+r12]
        cdqe
L_009:  mov     byte [rbp+rax], 0
        mov     rax, rbp
        pop     rbx
        pop     rbp
        pop     r12
        pop     r13
        pop     r14
        ret

L_010:  mov     eax, 8
        mov     ebx, 8
        jmp     L_008

ALIGN   8

__stringComp:
        sub     rsp, 8
        add     rsi, 8
        add     rdi, 8
        call    strcmp
        add     rsp, 8
        cdqe
        ret

SECTION .data

SECTION .bss    align=32

__buffer.3340:
        resb    1048576

SECTION .text.startup

main:
        xor     eax, eax
        jmp     __init

SECTION .rodata.str1.1

L_011:
        db 25H, 73H, 00H

L_012:
        db 25H, 6CH, 64H, 00H

;====================================================
	 section .text
_origin_User_Defined_fihriaifhiahidsafans:
	l_0:
	push rbp
	mov rbp, rsp
	sub rsp, 80
	mov qword [rbp-8], rdi
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [rbp-8]
	mov r10, rbx
	mov qword [rbp-40], r10
	mov rbx, qword [rbp-56]
	mov r10, qword [rbp-40]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-56], rbx
	mov rdi, qword [rbp-56]
	call malloc 
	mov qword [rbp-72], rax
	mov rbx, qword [rbp-72]
	mov r10, qword [rbp-40]
	mov qword [rbx], r10
	l_1:
	mov rbx, qword [rbp-40]
	cmp rbx, 0
	jg l_2
	l_3:
	mov rbx, qword [rbp-72]
	mov r10, rbx
	mov qword [g_1], r10
	mov rbx, 0
	mov qword [g_0], rbx
	l_4:
	mov rbx, qword [g_0]
	mov r10, qword [rbp-8]
	cmp rbx, r10
	jl l_5
	l_6:
	l_7:
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	leave 
	ret
	l_5:
	mov r10, qword [rbp-8]
	mov rbx, r10
	mov qword [rbp-32], rbx
	mov rbx, qword [rbp-32]
	mov r10, qword [rbp-80]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-80], r10
	mov rdi, qword [rbp-80]
	call malloc 
	mov qword [rbp-24], rax
	mov rbx, qword [rbp-32]
	mov r10, qword [rbp-24]
	mov qword [r10], rbx
	l_8:
	mov rbx, qword [rbp-32]
	cmp rbx, 0
	jg l_9
	l_10:
	mov rbx, qword [g_0]
	mov r10, qword [g_1]
	mov r11, qword [rbp-24]
	mov qword [r10 + rbx * 8 + 8], r11
	mov rbx, 0
	mov qword [g_2], rbx
	l_11:
	mov rbx, qword [g_2]
	mov r10, qword [rbp-8]
	cmp rbx, r10
	jl l_12
	l_13:
	l_14:
	mov rbx, qword [g_0]
	mov r10, rbx
	mov qword [rbp-16], r10
	mov rbx, qword [g_0]
	inc rbx
	mov qword [g_0], rbx
	jmp l_4
	l_12:
	mov rbx, qword [g_0]
	mov r10, qword [g_1]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-64], r11
	mov rbx, qword [g_2]
	mov r10, qword [rbp-64]
	mov qword [r10 + rbx * 8 + 8], 0
	l_15:
	mov rbx, qword [g_2]
	mov r10, rbx
	mov qword [rbp-48], r10
	mov rbx, qword [g_2]
	inc rbx
	mov qword [g_2], rbx
	jmp l_11
	l_9:
	mov rbx, qword [rbp-32]
	mov r10, qword [rbp-24]
	mov qword [r10 + rbx * 8], 0
	mov rbx, qword [rbp-32]
	dec rbx
	mov qword [rbp-32], rbx
	jmp l_8
	l_2:
	mov rbx, qword [rbp-72]
	mov r10, qword [rbp-40]
	mov qword [rbx + r10 * 8], 0
	mov rbx, qword [rbp-40]
	dec rbx
	mov qword [rbp-40], rbx
	jmp l_1
_search_User_Defined_fihriaifhiahidsafans:
	l_16:
	push rbp
	mov rbp, rsp
	sub rsp, 736
	mov qword [rbp-696], rdi
	mov qword [rbp-80], rsi
	mov qword [rbp-584], rdx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rbx, qword [rbp-80]
	cmp rbx, 0
	jle l_17
	l_18:
	mov rbx, qword [rbp-80]
	cmp rbx, 0
	jl l_17
	jmp l_19
	l_17:
	mov rbx, qword [rbp-696]
	cmp rbx, 0
	je l_19
	jmp l_20
	l_19:
	mov rbx, qword [rbp-696]
	mov r10, rbx
	mov qword [rbp-224], r10
	mov rbx, qword [rbp-224]
	sub rbx, 1
	mov qword [rbp-224], rbx
	mov rbx, qword [rbp-224]
	mov r11, qword [g_1]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-88], r10
	mov r10, qword [rbp-696]
	mov rbx, r10
	mov qword [rbp-368], rbx
	mov rbx, qword [rbp-368]
	sub rbx, 1
	mov qword [rbp-368], rbx
	mov r10, qword [rbp-368]
	mov r11, qword [g_1]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-680], rbx
	mov rbx, qword [rbp-88]
	mov r10, qword [rbx + 8]
	mov qword [rbp-608], r10
	mov rbx, qword [rbp-680]
	mov r10, qword [rbp-608]
	add r10, qword [rbx + 16]
	mov qword [rbp-608], r10
	mov rbx, qword [rbp-696]
	mov r10, rbx
	mov qword [rbp-216], r10
	mov rbx, qword [rbp-216]
	sub rbx, 1
	mov qword [rbp-216], rbx
	mov rbx, qword [g_1]
	mov r10, qword [rbp-216]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-176], r11
	mov r10, qword [rbp-608]
	mov rbx, r10
	mov qword [rbp-168], rbx
	mov rbx, qword [rbp-168]
	mov r10, qword [rbp-176]
	add rbx, qword [r10 + 24]
	mov qword [rbp-168], rbx
	mov rbx, qword [rbp-168]
	cmp rbx, 15
	je l_20
	jmp l_21
	l_20:
	mov rbx, qword [rbp-696]
	cmp rbx, 2
	jne l_22
	l_23:
	mov rbx, qword [rbp-80]
	cmp rbx, 2
	jne l_22
	jmp l_24
	l_22:
	mov rbx, qword [rbp-80]
	cmp rbx, 2
	je l_25
	l_26:
	mov rbx, 1
	mov qword [rbp-200], rbx
	l_27:
	mov rbx, qword [rbp-200]
	cmp rbx, 9
	jle l_28
	l_29:
	jmp l_30
	l_28:
	mov rbx, qword [g_3]
	mov r10, qword [rbp-200]
	cmp qword [rbx + r10 * 8 + 8], 0
	jne l_31
	l_32:
	mov rbx, qword [g_3]
	mov r10, qword [rbp-200]
	mov qword [rbx + r10 * 8 + 8], 1
	mov r10, qword [rbp-696]
	mov r11, qword [g_1]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-496], rbx
	mov rbx, qword [rbp-496]
	mov r10, qword [rbp-80]
	mov r11, qword [rbp-200]
	mov qword [rbx + r10 * 8 + 8], r11
	mov rbx, qword [rbp-80]
	cmp rbx, 2
	je l_33
	l_34:
	mov rbx, qword [rbp-80]
	mov r10, rbx
	mov qword [rbp-544], r10
	mov rbx, qword [rbp-544]
	add rbx, 1
	mov qword [rbp-544], rbx
	mov rbx, qword [rbp-584]
	mov r10, rbx
	mov qword [rbp-304], r10
	mov rbx, qword [rbp-200]
	mov r10, qword [rbp-304]
	add r10, rbx
	mov qword [rbp-304], r10
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rdx, qword [rbp-304]
	mov rsi, qword [rbp-544]
	mov rdi, qword [rbp-696]
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	call _search_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-648], rax
	jmp l_35
	l_33:
	mov rbx, qword [rbp-696]
	mov r10, rbx
	mov qword [rbp-232], r10
	mov rbx, qword [rbp-232]
	add rbx, 1
	mov qword [rbp-232], rbx
	mov r10, qword [rbp-584]
	mov rbx, r10
	mov qword [rbp-520], rbx
	mov rbx, qword [rbp-520]
	mov r10, qword [rbp-200]
	add rbx, r10
	mov qword [rbp-520], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rdx, qword [rbp-520]
	mov rsi, 0
	mov rdi, qword [rbp-232]
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	call _search_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-256], rax
	l_35:
	mov r10, qword [rbp-696]
	mov r11, qword [g_1]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-728], rbx
	mov rbx, qword [rbp-728]
	mov r10, qword [rbp-80]
	mov qword [rbx + r10 * 8 + 8], 0
	mov rbx, qword [g_3]
	mov r10, qword [rbp-200]
	mov qword [rbx + r10 * 8 + 8], 0
	l_31:
	l_36:
	mov r10, qword [rbp-200]
	mov rbx, r10
	mov qword [rbp-152], rbx
	mov rbx, qword [rbp-200]
	inc rbx
	mov qword [rbp-200], rbx
	jmp l_27
	l_25:
	mov r10, qword [rbp-696]
	mov r11, qword [g_1]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-624], rbx
	mov r10, qword [rbp-696]
	mov r11, qword [g_1]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-592], rbx
	mov rbx, 15
	mov qword [rbp-296], rbx
	mov rbx, qword [rbp-296]
	mov r10, qword [rbp-592]
	sub rbx, qword [r10 + 8]
	mov qword [rbp-296], rbx
	mov r10, qword [rbp-696]
	mov r11, qword [g_1]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-392], rbx
	mov rbx, qword [rbp-296]
	mov r10, rbx
	mov qword [rbp-560], r10
	mov rbx, qword [rbp-392]
	mov r10, qword [rbp-560]
	sub r10, qword [rbx + 16]
	mov qword [rbp-560], r10
	mov rbx, qword [rbp-624]
	mov r10, qword [rbp-560]
	mov r11, qword [rbp-80]
	mov qword [rbx + r11 * 8 + 8], r10
	mov r10, qword [rbp-696]
	mov r11, qword [g_1]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-720], rbx
	mov rbx, qword [rbp-720]
	mov r10, qword [rbp-80]
	cmp qword [rbx + r10 * 8 + 8], 0
	jle l_37
	l_38:
	mov rbx, qword [rbp-696]
	mov r10, qword [g_1]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-512], r11
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-512]
	cmp qword [r10 + rbx * 8 + 8], 10
	jge l_37
	l_39:
	mov rbx, qword [rbp-696]
	mov r11, qword [g_1]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-536], r10
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-536]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-464], r11
	mov rbx, qword [g_3]
	mov r10, qword [rbp-464]
	cmp qword [rbx + r10 * 8 + 8], 0
	jne l_37
	l_40:
	mov r10, qword [rbp-696]
	mov r11, qword [g_1]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-640], rbx
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-640]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-320], r11
	mov rbx, qword [g_3]
	mov r10, qword [rbp-320]
	mov qword [rbx + r10 * 8 + 8], 1
	mov rbx, qword [rbp-80]
	cmp rbx, 2
	je l_41
	l_42:
	mov r10, qword [rbp-80]
	mov rbx, r10
	mov qword [rbp-408], rbx
	mov rbx, qword [rbp-408]
	add rbx, 1
	mov qword [rbp-408], rbx
	mov r10, qword [rbp-696]
	mov r11, qword [g_1]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-128], rbx
	mov r10, qword [rbp-584]
	mov rbx, r10
	mov qword [rbp-208], rbx
	mov rbx, qword [rbp-208]
	mov r10, qword [rbp-128]
	mov r11, qword [rbp-80]
	add rbx, qword [r10 + r11 * 8 + 8]
	mov qword [rbp-208], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rdx, qword [rbp-208]
	mov rsi, qword [rbp-408]
	mov rdi, qword [rbp-696]
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	call _search_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-600], rax
	jmp l_43
	l_41:
	mov rbx, qword [rbp-696]
	mov r10, rbx
	mov qword [rbp-424], r10
	mov rbx, qword [rbp-424]
	add rbx, 1
	mov qword [rbp-424], rbx
	mov r10, qword [rbp-696]
	mov r11, qword [g_1]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-576], rbx
	mov rbx, qword [rbp-584]
	mov r10, rbx
	mov qword [rbp-160], r10
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-576]
	mov r11, qword [rbp-160]
	add r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-160], r11
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rdx, qword [rbp-160]
	mov rsi, 0
	mov rdi, qword [rbp-424]
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	call _search_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-192], rax
	l_43:
	mov rbx, qword [rbp-696]
	mov r10, qword [g_1]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-72], r11
	mov rbx, qword [rbp-80]
	mov r11, qword [rbp-72]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-144], r10
	mov rbx, qword [g_3]
	mov r10, qword [rbp-144]
	mov qword [rbx + r10 * 8 + 8], 0
	l_37:
	l_30:
	jmp l_44
	l_24:
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 24]
	mov qword [rbp-184], rbx
	mov rbx, 45
	mov qword [rbp-376], rbx
	mov rbx, qword [rbp-584]
	mov r10, qword [rbp-376]
	sub r10, rbx
	mov qword [rbp-376], r10
	mov rbx, qword [rbp-184]
	mov r10, qword [rbp-376]
	mov qword [rbx + 24], r10
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-8], rbx
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-712], rbx
	mov rbx, qword [rbp-8]
	mov r10, qword [rbx + 8]
	mov qword [rbp-616], r10
	mov rbx, qword [rbp-712]
	mov r10, qword [rbp-616]
	add r10, qword [rbx + 16]
	mov qword [rbp-616], r10
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-96], rbx
	mov r10, qword [rbp-616]
	mov rbx, r10
	mov qword [rbp-136], rbx
	mov rbx, qword [rbp-136]
	mov r10, qword [rbp-96]
	add rbx, qword [r10 + 24]
	mov qword [rbp-136], rbx
	mov rbx, qword [rbp-136]
	mov r10, rbx
	mov qword [rbp-328], r10
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 16]
	mov qword [rbp-552], rbx
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 16]
	mov qword [rbp-40], rbx
	mov rbx, qword [rbp-552]
	mov r10, qword [rbx + 8]
	mov qword [rbp-280], r10
	mov rbx, qword [rbp-40]
	mov r10, qword [rbp-280]
	add r10, qword [rbx + 16]
	mov qword [rbp-280], r10
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 16]
	mov qword [rbp-400], rbx
	mov r10, qword [rbp-280]
	mov rbx, r10
	mov qword [rbp-432], rbx
	mov rbx, qword [rbp-432]
	mov r10, qword [rbp-400]
	add rbx, qword [r10 + 24]
	mov qword [rbp-432], rbx
	mov rbx, qword [rbp-432]
	mov r10, qword [rbp-328]
	cmp rbx, r10
	jne l_45
	l_46:
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 24]
	mov qword [rbp-24], r10
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 24]
	mov qword [rbp-120], rbx
	mov r10, qword [rbp-24]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-656], rbx
	mov rbx, qword [rbp-120]
	mov r10, qword [rbp-656]
	add r10, qword [rbx + 16]
	mov qword [rbp-656], r10
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 24]
	mov qword [rbp-56], rbx
	mov r10, qword [rbp-656]
	mov rbx, r10
	mov qword [rbp-240], rbx
	mov rbx, qword [rbp-240]
	mov r10, qword [rbp-56]
	add rbx, qword [r10 + 24]
	mov qword [rbp-240], rbx
	mov rbx, qword [rbp-240]
	mov r10, qword [rbp-328]
	cmp rbx, r10
	jne l_45
	l_47:
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-32], rbx
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 16]
	mov qword [rbp-272], rbx
	mov r10, qword [rbp-32]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-352], rbx
	mov rbx, qword [rbp-352]
	mov r10, qword [rbp-272]
	add rbx, qword [r10 + 8]
	mov qword [rbp-352], rbx
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 24]
	mov qword [rbp-112], rbx
	mov rbx, qword [rbp-352]
	mov r10, rbx
	mov qword [rbp-64], r10
	mov rbx, qword [rbp-112]
	mov r10, qword [rbp-64]
	add r10, qword [rbx + 8]
	mov qword [rbp-64], r10
	mov rbx, qword [rbp-64]
	mov r10, qword [rbp-328]
	cmp rbx, r10
	jne l_45
	l_48:
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-736], rbx
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 16]
	mov qword [rbp-664], rbx
	mov rbx, qword [rbp-736]
	mov r10, qword [rbx + 16]
	mov qword [rbp-440], r10
	mov rbx, qword [rbp-664]
	mov r10, qword [rbp-440]
	add r10, qword [rbx + 16]
	mov qword [rbp-440], r10
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 24]
	mov qword [rbp-528], r10
	mov r10, qword [rbp-440]
	mov rbx, r10
	mov qword [rbp-344], rbx
	mov rbx, qword [rbp-344]
	mov r10, qword [rbp-528]
	add rbx, qword [r10 + 16]
	mov qword [rbp-344], rbx
	mov rbx, qword [rbp-344]
	mov r10, qword [rbp-328]
	cmp rbx, r10
	jne l_45
	l_49:
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-264], rbx
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 16]
	mov qword [rbp-480], rbx
	mov r10, qword [rbp-264]
	mov rbx, qword [r10 + 24]
	mov qword [rbp-288], rbx
	mov rbx, qword [rbp-288]
	mov r10, qword [rbp-480]
	add rbx, qword [r10 + 24]
	mov qword [rbp-288], rbx
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 24]
	mov qword [rbp-336], rbx
	mov rbx, qword [rbp-288]
	mov r10, rbx
	mov qword [rbp-456], r10
	mov rbx, qword [rbp-336]
	mov r10, qword [rbp-456]
	add r10, qword [rbx + 24]
	mov qword [rbp-456], r10
	mov rbx, qword [rbp-456]
	mov r10, qword [rbp-328]
	cmp rbx, r10
	jne l_45
	l_50:
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 8]
	mov qword [rbp-704], r10
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 16]
	mov qword [rbp-104], rbx
	mov rbx, qword [rbp-704]
	mov r10, qword [rbx + 8]
	mov qword [rbp-16], r10
	mov rbx, qword [rbp-104]
	mov r10, qword [rbp-16]
	add r10, qword [rbx + 16]
	mov qword [rbp-16], r10
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 24]
	mov qword [rbp-384], rbx
	mov r10, qword [rbp-16]
	mov rbx, r10
	mov qword [rbp-448], rbx
	mov rbx, qword [rbp-384]
	mov r10, qword [rbp-448]
	add r10, qword [rbx + 24]
	mov qword [rbp-448], r10
	mov rbx, qword [rbp-448]
	mov r10, qword [rbp-328]
	cmp rbx, r10
	jne l_45
	l_51:
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 24]
	mov qword [rbp-360], r10
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 16]
	mov qword [rbp-488], rbx
	mov r10, qword [rbp-360]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-416], rbx
	mov rbx, qword [rbp-488]
	mov r10, qword [rbp-416]
	add r10, qword [rbx + 16]
	mov qword [rbp-416], r10
	mov r10, qword [g_1]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-312], rbx
	mov rbx, qword [rbp-416]
	mov r10, rbx
	mov qword [rbp-688], r10
	mov rbx, qword [rbp-312]
	mov r10, qword [rbp-688]
	add r10, qword [rbx + 24]
	mov qword [rbp-688], r10
	mov rbx, qword [rbp-688]
	mov r10, qword [rbp-328]
	cmp rbx, r10
	jne l_45
	l_52:
	mov r10, qword [g_4]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-504], rbx
	mov rbx, qword [rbp-504]
	add rbx, 1
	mov qword [rbp-504], rbx
	mov rbx, qword [rbp-504]
	mov r10, qword [g_4]
	mov qword [r10 + 8], rbx
	mov rbx, 0
	mov qword [rbp-200], rbx
	l_53:
	mov rbx, qword [rbp-200]
	cmp rbx, 2
	jle l_54
	l_55:
	mov rdi, g_5
	call __print 
	l_45:
	l_44:
	l_21:
	mov rax, 0
	l_56:
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	leave 
	ret
	l_54:
	mov rbx, 0
	mov qword [rbp-248], rbx
	l_57:
	mov rbx, qword [rbp-248]
	cmp rbx, 2
	jle l_58
	l_59:
	mov rdi, g_6
	call __print 
	l_60:
	mov r10, qword [rbp-200]
	mov rbx, r10
	mov qword [rbp-48], rbx
	mov rbx, qword [rbp-200]
	inc rbx
	mov qword [rbp-200], rbx
	jmp l_53
	l_58:
	mov r10, qword [g_1]
	mov r11, qword [rbp-200]
	mov rbx, qword [r10 + r11 * 8 + 8]
	mov qword [rbp-672], rbx
	mov rbx, qword [rbp-672]
	mov r10, qword [rbp-248]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-472], r11
	mov rdi, qword [rbp-472]
	call __toString 
	mov qword [rbp-632], rax
	mov rdi, qword [rbp-632]
	call __print 
	mov rdi, g_7
	call __print 
	l_61:
	mov rbx, qword [rbp-248]
	mov r10, rbx
	mov qword [rbp-568], r10
	mov rbx, qword [rbp-248]
	inc rbx
	mov qword [rbp-248], rbx
	jmp l_57
_main_User_Defined_fihriaifhiahidsafans:
	l_62:
	push rbp
	mov rbp, rsp
	sub rsp, 32
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rbx, qword [g_4]
	mov qword [rbx + 8], 0
	mov rdi, 3
	call _origin_User_Defined_fihriaifhiahidsafans 
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rdx, 0
	mov rsi, 0
	mov rdi, 0
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	call _search_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-24], rax
	mov rbx, qword [g_4]
	mov r10, qword [rbx + 8]
	mov qword [rbp-16], r10
	mov rdi, qword [rbp-16]
	call __toString 
	mov qword [rbp-8], rax
	mov rdi, qword [rbp-8]
	call __println 
	mov rax, 0
	l_63:
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	leave 
	ret
__init:
	l_64:
	push rbp
	mov rbp, rsp
	sub rsp, 48
	mov rbx, 10
	mov qword [rbp-8], rbx
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-48]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-48], r10
	mov rdi, qword [rbp-48]
	call malloc 
	mov qword [rbp-40], rax
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-40]
	mov qword [r10], rbx
	l_65:
	mov rbx, qword [rbp-8]
	cmp rbx, 0
	jg l_66
	l_67:
	mov r10, qword [rbp-40]
	mov rbx, r10
	mov qword [g_3], rbx
	mov rbx, 1
	mov qword [rbp-32], rbx
	mov rbx, qword [rbp-16]
	mov r10, qword [rbp-32]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-16], rbx
	mov rdi, qword [rbp-16]
	call malloc 
	mov qword [rbp-24], rax
	mov rbx, qword [rbp-24]
	mov r10, qword [rbp-32]
	mov qword [rbx], r10
	l_68:
	mov rbx, qword [rbp-32]
	cmp rbx, 0
	jg l_69
	l_70:
	mov rbx, qword [rbp-24]
	mov r10, rbx
	mov qword [g_4], r10
	call _main_User_Defined_fihriaifhiahidsafans 
	leave 
	ret
	l_69:
	mov rbx, qword [rbp-24]
	mov r10, qword [rbp-32]
	mov qword [rbx + r10 * 8], 0
	mov rbx, qword [rbp-32]
	dec rbx
	mov qword [rbp-32], rbx
	jmp l_68
	l_66:
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-40]
	mov qword [r10 + rbx * 8], 0
	mov rbx, qword [rbp-8]
	dec rbx
	mov qword [rbp-8], rbx
	jmp l_65
	 section .data
g_1:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_3:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_4:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_0:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_2:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_7:
	dq 1
	db 20H, 00H
g_6:
	dq 1
	db 0AH, 00H
g_5:
	dq 1
	db 0AH, 00H

