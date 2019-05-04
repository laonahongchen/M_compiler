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
        mov     rcx, L_012
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
_restore_User_Defined_fihriaifhiahidsafans:
	l_0:
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, 1
	mov qword [rbp-16], rbx
	l_1:
	mov rbx, qword [g_0]
	mov r10, qword [rbp-16]
	cmp r10, rbx
	jle l_2
	l_3:
	l_4:
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	leave 
	ret
	l_2:
	mov r10, qword [rbp-16]
	mov r11, qword [g_1]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-8], rbx
	mov rbx, qword [rbp-8]
	mov r10, qword [g_2]
	mov r11, qword [rbp-16]
	mov qword [r10 + r11 * 8 + 8], rbx
	l_5:
	mov rbx, qword [rbp-16]
	inc rbx
	mov qword [rbp-16], rbx
	jmp l_1
_quicksort_User_Defined_fihriaifhiahidsafans:
	l_6:
	push rbp
	mov rbp, rsp
	sub rsp, 176
	mov qword [rbp-24], rdi
	mov qword [rbp-152], rsi
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rbx, 0
	mov qword [rbp-128], rbx
	mov rbx, qword [g_2]
	mov r10, qword [rbp-24]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-72], r11
	mov rbx, 0
	mov qword [rbp-112], rbx
	mov rbx, 0
	mov qword [rbp-88], rbx
	mov rbx, qword [rbp-24]
	mov r10, rbx
	mov qword [rbp-176], r10
	mov rbx, qword [rbp-176]
	add rbx, 1
	mov qword [rbp-176], rbx
	mov r10, qword [rbp-176]
	mov rbx, r10
	mov qword [rbp-144], rbx
	l_7:
	mov rbx, qword [rbp-144]
	mov r10, qword [rbp-152]
	cmp rbx, r10
	jl l_8
	l_9:
	mov r10, qword [rbp-24]
	mov rbx, r10
	mov qword [rbp-104], rbx
	mov rbx, 0
	mov qword [rbp-144], rbx
	l_10:
	mov rbx, qword [rbp-144]
	mov r10, qword [rbp-112]
	cmp rbx, r10
	jl l_11
	l_12:
	mov rbx, qword [rbp-104]
	mov r10, rbx
	mov qword [rbp-136], r10
	mov rbx, qword [rbp-104]
	inc rbx
	mov qword [rbp-104], rbx
	mov rbx, qword [g_2]
	mov r10, qword [rbp-72]
	mov r11, qword [rbp-136]
	mov qword [rbx + r11 * 8 + 8], r10
	mov rbx, 0
	mov qword [rbp-144], rbx
	l_13:
	mov rbx, qword [rbp-144]
	mov r10, qword [rbp-88]
	cmp rbx, r10
	jl l_14
	l_15:
	mov rbx, qword [rbp-112]
	cmp rbx, 1
	jle l_16
	l_17:
	mov r10, qword [rbp-24]
	mov rbx, r10
	mov qword [rbp-48], rbx
	mov rbx, qword [rbp-48]
	mov r10, qword [rbp-112]
	add rbx, r10
	mov qword [rbp-48], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rsi, qword [rbp-48]
	mov rdi, qword [rbp-24]
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	call _quicksort_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-8], rax
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-128]
	add r10, rbx
	mov qword [rbp-128], r10
	l_16:
	mov rbx, qword [rbp-88]
	cmp rbx, 1
	jle l_18
	l_19:
	mov r10, qword [rbp-152]
	mov rbx, r10
	mov qword [rbp-80], rbx
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-88]
	sub rbx, r10
	mov qword [rbp-80], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rsi, qword [rbp-152]
	mov rdi, qword [rbp-80]
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	call _quicksort_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-96], rax
	mov rbx, qword [rbp-128]
	mov r10, qword [rbp-96]
	add rbx, r10
	mov qword [rbp-128], rbx
	l_18:
	mov rax, qword [rbp-128]
	l_20:
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	leave 
	ret
	l_14:
	mov rbx, qword [rbp-104]
	mov r10, rbx
	mov qword [rbp-40], r10
	mov rbx, qword [rbp-104]
	inc rbx
	mov qword [rbp-104], rbx
	mov rbx, qword [rbp-144]
	mov r10, qword [g_3]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-64], r11
	mov rbx, qword [g_2]
	mov r10, qword [rbp-40]
	mov r11, qword [rbp-64]
	mov qword [rbx + r10 * 8 + 8], r11
	l_21:
	mov rbx, qword [rbp-144]
	inc rbx
	mov qword [rbp-144], rbx
	jmp l_13
	l_11:
	mov rbx, qword [rbp-104]
	mov r10, rbx
	mov qword [rbp-168], r10
	mov rbx, qword [rbp-104]
	inc rbx
	mov qword [rbp-104], rbx
	mov rbx, qword [rbp-144]
	mov r10, qword [g_4]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-160], r11
	mov rbx, qword [g_2]
	mov r10, qword [rbp-168]
	mov r11, qword [rbp-160]
	mov qword [rbx + r10 * 8 + 8], r11
	l_22:
	mov rbx, qword [rbp-144]
	inc rbx
	mov qword [rbp-144], rbx
	jmp l_10
	l_8:
	mov rbx, qword [rbp-128]
	inc rbx
	mov qword [rbp-128], rbx
	mov rbx, qword [g_2]
	mov r10, qword [rbp-144]
	mov r11, qword [rbp-72]
	cmp qword [rbx + r10 * 8 + 8], r11
	jl l_23
	l_24:
	mov r10, qword [rbp-88]
	mov rbx, r10
	mov qword [rbp-56], rbx
	mov rbx, qword [rbp-88]
	inc rbx
	mov qword [rbp-88], rbx
	mov rbx, qword [g_2]
	mov r10, qword [rbp-144]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-32], r11
	mov rbx, qword [rbp-56]
	mov r10, qword [rbp-32]
	mov r11, qword [g_3]
	mov qword [r11 + rbx * 8 + 8], r10
	jmp l_25
	l_23:
	mov r10, qword [rbp-112]
	mov rbx, r10
	mov qword [rbp-16], rbx
	mov rbx, qword [rbp-112]
	inc rbx
	mov qword [rbp-112], rbx
	mov rbx, qword [g_2]
	mov r10, qword [rbp-144]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-120], r11
	mov rbx, qword [rbp-120]
	mov r10, qword [g_4]
	mov r11, qword [rbp-16]
	mov qword [r10 + r11 * 8 + 8], rbx
	l_25:
	l_26:
	mov rbx, qword [rbp-144]
	inc rbx
	mov qword [rbp-144], rbx
	jmp l_7
_calc_User_Defined_fihriaifhiahidsafans:
	l_27:
	push rbp
	mov rbp, rsp
	sub rsp, 96
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rbx, 1
	mov qword [rbp-56], rbx
	l_28:
	mov rbx, qword [rbp-56]
	mov r10, qword [g_0]
	cmp rbx, r10
	jle l_29
	l_30:
	mov rbx, 0
	mov qword [rbp-48], rbx
	mov rbx, qword [g_0]
	mov r10, rbx
	mov qword [rbp-56], r10
	l_31:
	mov rbx, qword [rbp-56]
	cmp rbx, 1
	jge l_32
	l_33:
	mov rax, qword [rbp-48]
	l_34:
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	leave 
	ret
	l_32:
	mov rbx, qword [rbp-56]
	mov r10, qword [g_2]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-80], r11
	mov r10, qword [g_4]
	mov r11, qword [rbp-80]
	mov rbx, qword [r10 + r11 * 8 + 8]
	mov qword [rbp-32], rbx
	mov rbx, qword [rbp-56]
	mov r10, qword [g_2]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-16], r11
	mov rbx, qword [g_3]
	mov r11, qword [rbp-16]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-64], r10
	mov rbx, qword [rbp-32]
	mov r10, qword [g_3]
	mov r11, qword [rbp-64]
	mov qword [r10 + rbx * 8 + 8], r11
	mov rbx, qword [rbp-32]
	mov r10, qword [g_4]
	mov r11, qword [rbp-64]
	mov qword [r10 + r11 * 8 + 8], rbx
	mov rbx, qword [rbp-48]
	mov r10, rbx
	mov qword [rbp-24], r10
	mov rbx, qword [rbp-24]
	mov r10, qword [rbp-64]
	add rbx, r10
	mov qword [rbp-24], rbx
	mov r10, qword [rbp-24]
	mov rbx, r10
	mov qword [rbp-72], rbx
	mov rbx, qword [rbp-72]
	mov r10, qword [rbp-32]
	sub rbx, r10
	mov qword [rbp-72], rbx
	mov rbx, qword [rbp-72]
	mov r10, rbx
	mov qword [rbp-8], r10
	mov rbx, qword [rbp-8]
	sub rbx, 2
	mov qword [rbp-8], rbx
	mov r10, qword [rbp-8]
	mov rbx, r10
	mov qword [rbp-48], rbx
	l_35:
	mov rbx, qword [rbp-56]
	dec rbx
	mov qword [rbp-56], rbx
	jmp l_31
	l_29:
	mov rbx, qword [rbp-56]
	mov r10, rbx
	mov qword [rbp-40], r10
	mov rbx, qword [rbp-40]
	sub rbx, 1
	mov qword [rbp-40], rbx
	mov rbx, qword [rbp-56]
	mov r10, qword [rbp-40]
	mov r11, qword [g_4]
	mov qword [r11 + rbx * 8 + 8], r10
	mov rbx, qword [rbp-56]
	mov r10, rbx
	mov qword [rbp-88], r10
	mov rbx, qword [rbp-88]
	add rbx, 1
	mov qword [rbp-88], rbx
	mov rbx, qword [rbp-56]
	mov r10, qword [g_3]
	mov r11, qword [rbp-88]
	mov qword [r10 + rbx * 8 + 8], r11
	l_36:
	mov rbx, qword [rbp-56]
	inc rbx
	mov qword [rbp-56], rbx
	jmp l_28
_mergesort_User_Defined_fihriaifhiahidsafans:
	l_37:
	push rbp
	mov rbp, rsp
	sub rsp, 256
	mov qword [rbp-256], rdi
	mov qword [rbp-48], rsi
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov r10, qword [rbp-256]
	mov rbx, r10
	mov qword [rbp-120], rbx
	mov rbx, qword [rbp-120]
	add rbx, 1
	mov qword [rbp-120], rbx
	mov rbx, qword [rbp-120]
	mov r10, qword [rbp-48]
	cmp rbx, r10
	je l_38
	l_39:
	mov r10, qword [rbp-256]
	mov rbx, r10
	mov qword [rbp-64], rbx
	mov rbx, qword [rbp-64]
	mov r10, qword [rbp-48]
	add rbx, r10
	mov qword [rbp-64], rbx
	mov rbx, qword [rbp-64]
	mov r10, rbx
	mov qword [rbp-16], r10
	mov rcx, 1
	mov rbx, qword [rbp-16]
	sar rbx, cl
	mov qword [rbp-16], rbx
	mov r10, qword [rbp-16]
	mov rbx, r10
	mov qword [rbp-24], rbx
	mov rbx, 0
	mov qword [rbp-184], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rsi, qword [rbp-24]
	mov rdi, qword [rbp-256]
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	call _mergesort_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-216], rax
	mov rbx, qword [rbp-216]
	mov r10, qword [rbp-184]
	add r10, rbx
	mov qword [rbp-184], r10
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rsi, qword [rbp-48]
	mov rdi, qword [rbp-24]
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	call _mergesort_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-240], rax
	mov rbx, qword [rbp-240]
	mov r10, qword [rbp-184]
	add r10, rbx
	mov qword [rbp-184], r10
	mov rbx, 0
	mov qword [rbp-96], rbx
	mov rbx, 0
	mov qword [rbp-160], rbx
	mov r10, qword [rbp-256]
	mov rbx, r10
	mov qword [rbp-136], rbx
	l_40:
	mov rbx, qword [rbp-136]
	mov r10, qword [rbp-24]
	cmp rbx, r10
	jl l_41
	l_42:
	mov r10, qword [rbp-24]
	mov rbx, r10
	mov qword [rbp-136], rbx
	l_43:
	mov rbx, qword [rbp-136]
	mov r10, qword [rbp-48]
	cmp rbx, r10
	jl l_44
	l_45:
	mov rbx, 0
	mov qword [rbp-176], rbx
	mov rbx, 0
	mov qword [rbp-232], rbx
	mov r10, qword [rbp-256]
	mov rbx, r10
	mov qword [rbp-248], rbx
	l_46:
	mov rbx, qword [rbp-176]
	mov r10, qword [rbp-96]
	cmp rbx, r10
	jge l_47
	l_48:
	mov rbx, qword [rbp-232]
	mov r10, qword [rbp-160]
	cmp rbx, r10
	jge l_47
	jmp l_49
	l_47:
	l_50:
	mov rbx, qword [rbp-176]
	mov r10, qword [rbp-96]
	cmp rbx, r10
	jl l_51
	l_52:
	l_53:
	mov rbx, qword [rbp-232]
	mov r10, qword [rbp-160]
	cmp rbx, r10
	jl l_54
	l_55:
	mov rax, qword [rbp-184]
	jmp l_56
	l_54:
	mov rbx, qword [rbp-248]
	mov r10, rbx
	mov qword [rbp-72], r10
	mov rbx, qword [rbp-248]
	inc rbx
	mov qword [rbp-248], rbx
	mov r10, qword [rbp-232]
	mov rbx, r10
	mov qword [rbp-208], rbx
	mov rbx, qword [rbp-232]
	inc rbx
	mov qword [rbp-232], rbx
	mov rbx, qword [rbp-208]
	mov r11, qword [g_3]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-192], r10
	mov rbx, qword [g_2]
	mov r10, qword [rbp-192]
	mov r11, qword [rbp-72]
	mov qword [rbx + r11 * 8 + 8], r10
	jmp l_53
	l_51:
	mov rbx, qword [rbp-248]
	mov r10, rbx
	mov qword [rbp-8], r10
	mov rbx, qword [rbp-248]
	inc rbx
	mov qword [rbp-248], rbx
	mov r10, qword [rbp-176]
	mov rbx, r10
	mov qword [rbp-128], rbx
	mov rbx, qword [rbp-176]
	inc rbx
	mov qword [rbp-176], rbx
	mov rbx, qword [rbp-128]
	mov r11, qword [g_4]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-88], r10
	mov rbx, qword [g_2]
	mov r10, qword [rbp-88]
	mov r11, qword [rbp-8]
	mov qword [rbx + r11 * 8 + 8], r10
	jmp l_50
	l_49:
	mov rbx, qword [rbp-184]
	inc rbx
	mov qword [rbp-184], rbx
	mov r10, qword [rbp-176]
	mov r11, qword [g_4]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-112], rbx
	mov rbx, qword [rbp-112]
	mov r10, qword [g_3]
	mov r11, qword [rbp-232]
	cmp rbx, qword [r10 + r11 * 8 + 8]
	jl l_57
	l_58:
	mov rbx, qword [rbp-248]
	mov r10, rbx
	mov qword [rbp-32], r10
	mov rbx, qword [rbp-248]
	inc rbx
	mov qword [rbp-248], rbx
	mov r10, qword [rbp-232]
	mov rbx, r10
	mov qword [rbp-224], rbx
	mov rbx, qword [rbp-232]
	inc rbx
	mov qword [rbp-232], rbx
	mov rbx, qword [g_3]
	mov r11, qword [rbp-224]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-40], r10
	mov rbx, qword [g_2]
	mov r10, qword [rbp-32]
	mov r11, qword [rbp-40]
	mov qword [rbx + r10 * 8 + 8], r11
	jmp l_59
	l_57:
	mov rbx, qword [rbp-248]
	mov r10, rbx
	mov qword [rbp-104], r10
	mov rbx, qword [rbp-248]
	inc rbx
	mov qword [rbp-248], rbx
	mov rbx, qword [rbp-176]
	mov r10, rbx
	mov qword [rbp-152], r10
	mov rbx, qword [rbp-176]
	inc rbx
	mov qword [rbp-176], rbx
	mov rbx, qword [g_4]
	mov r10, qword [rbp-152]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-168], r11
	mov rbx, qword [g_2]
	mov r10, qword [rbp-104]
	mov r11, qword [rbp-168]
	mov qword [rbx + r10 * 8 + 8], r11
	l_59:
	jmp l_46
	l_44:
	mov r10, qword [rbp-160]
	mov rbx, r10
	mov qword [rbp-56], rbx
	mov rbx, qword [rbp-160]
	inc rbx
	mov qword [rbp-160], rbx
	mov rbx, qword [rbp-136]
	mov r10, qword [g_2]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-144], r11
	mov rbx, qword [rbp-56]
	mov r10, qword [rbp-144]
	mov r11, qword [g_3]
	mov qword [r11 + rbx * 8 + 8], r10
	l_60:
	mov rbx, qword [rbp-136]
	inc rbx
	mov qword [rbp-136], rbx
	jmp l_43
	l_41:
	mov r10, qword [rbp-96]
	mov rbx, r10
	mov qword [rbp-80], rbx
	mov rbx, qword [rbp-96]
	inc rbx
	mov qword [rbp-96], rbx
	mov rbx, qword [rbp-136]
	mov r10, qword [g_2]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-200], r11
	mov rbx, qword [rbp-80]
	mov r10, qword [g_4]
	mov r11, qword [rbp-200]
	mov qword [r10 + rbx * 8 + 8], r11
	l_61:
	mov rbx, qword [rbp-136]
	inc rbx
	mov qword [rbp-136], rbx
	jmp l_40
	l_38:
	mov rax, 0
	l_56:
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	leave 
	ret
_heapsort_User_Defined_fihriaifhiahidsafans:
	l_62:
	push rbp
	mov rbp, rsp
	sub rsp, 192
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_5]
	mov qword [g_5], rbx
	mov rbx, 0
	mov qword [rbp-64], rbx
	mov rbx, 1
	mov qword [rbp-56], rbx
	l_63:
	mov rbx, qword [g_0]
	mov r10, qword [rbp-56]
	cmp r10, rbx
	jle l_64
	l_65:
	mov rbx, qword [g_0]
	mov r10, rbx
	mov qword [rbp-144], r10
	mov rbx, 1
	mov qword [rbp-56], rbx
	l_66:
	mov rbx, qword [g_0]
	mov r10, qword [rbp-56]
	cmp r10, rbx
	jle l_67
	l_68:
	mov rax, qword [rbp-64]
	l_69:
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_5]
	mov qword [g_5], rbx
	leave 
	ret
	l_67:
	mov r10, qword [g_5]
	mov rbx, qword [r10 + 16]
	mov qword [rbp-32], rbx
	mov rbx, qword [g_2]
	mov r10, qword [rbp-32]
	mov r11, qword [rbp-56]
	mov qword [rbx + r11 * 8 + 8], r10
	mov rbx, qword [rbp-144]
	mov r10, rbx
	mov qword [rbp-72], r10
	mov rbx, qword [rbp-144]
	dec rbx
	mov qword [rbp-144], rbx
	mov rbx, qword [g_5]
	mov r10, qword [rbp-72]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-104], r11
	mov rbx, qword [g_5]
	mov r10, qword [rbp-104]
	mov qword [rbx + 16], r10
	mov rbx, 1
	mov qword [rbp-112], rbx
	l_70:
	mov rbx, qword [rbp-112]
	mov r10, rbx
	mov qword [rbp-88], r10
	mov rcx, 1
	mov rbx, qword [rbp-88]
	sal rbx, cl
	mov qword [rbp-88], rbx
	mov rbx, qword [rbp-144]
	mov r10, qword [rbp-88]
	cmp r10, rbx
	jg l_71
	l_72:
	mov rbx, qword [rbp-112]
	mov r10, rbx
	mov qword [rbp-128], r10
	mov rcx, 1
	mov rbx, qword [rbp-128]
	sal rbx, cl
	mov qword [rbp-128], rbx
	mov r10, qword [rbp-128]
	mov rbx, r10
	mov qword [rbp-40], rbx
	mov rbx, qword [rbp-40]
	mov r10, rbx
	mov qword [rbp-184], r10
	mov rbx, qword [rbp-184]
	add rbx, 1
	mov qword [rbp-184], rbx
	mov r10, qword [rbp-184]
	mov rbx, r10
	mov qword [rbp-24], rbx
	mov rbx, qword [rbp-40]
	mov r10, rbx
	mov qword [rbp-192], r10
	mov rbx, qword [rbp-144]
	mov r10, qword [rbp-24]
	cmp r10, rbx
	jg l_73
	l_74:
	mov rbx, qword [rbp-64]
	inc rbx
	mov qword [rbp-64], rbx
	mov r10, qword [g_5]
	mov r11, qword [rbp-24]
	mov rbx, qword [r10 + r11 * 8 + 8]
	mov qword [rbp-48], rbx
	mov rbx, qword [rbp-48]
	mov r10, qword [rbp-40]
	mov r11, qword [g_5]
	cmp rbx, qword [r11 + r10 * 8 + 8]
	jge l_75
	l_76:
	mov r10, qword [rbp-24]
	mov rbx, r10
	mov qword [rbp-192], rbx
	l_75:
	l_73:
	mov rbx, qword [rbp-64]
	inc rbx
	mov qword [rbp-64], rbx
	mov rbx, qword [g_5]
	mov r10, qword [rbp-112]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-136], r11
	mov rbx, qword [rbp-192]
	mov r10, qword [g_5]
	mov r11, qword [rbp-136]
	cmp r11, qword [r10 + rbx * 8 + 8]
	jl l_77
	l_78:
	mov r10, qword [g_5]
	mov r11, qword [rbp-112]
	mov rbx, qword [r10 + r11 * 8 + 8]
	mov qword [rbp-8], rbx
	mov rbx, qword [rbp-192]
	mov r10, qword [g_5]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-168], r11
	mov rbx, qword [g_5]
	mov r10, qword [rbp-168]
	mov r11, qword [rbp-112]
	mov qword [rbx + r11 * 8 + 8], r10
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-192]
	mov r11, qword [g_5]
	mov qword [r11 + r10 * 8 + 8], rbx
	mov rbx, qword [rbp-192]
	mov r10, rbx
	mov qword [rbp-112], r10
	jmp l_70
	l_77:
	l_71:
	l_79:
	mov rbx, qword [rbp-56]
	inc rbx
	mov qword [rbp-56], rbx
	jmp l_66
	l_64:
	mov rbx, qword [g_2]
	mov r11, qword [rbp-56]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-176], r10
	mov rbx, qword [g_5]
	mov r10, qword [rbp-176]
	mov r11, qword [rbp-56]
	mov qword [rbx + r11 * 8 + 8], r10
	mov r10, qword [rbp-56]
	mov rbx, r10
	mov qword [rbp-160], rbx
	l_80:
	mov rbx, qword [rbp-160]
	cmp rbx, 1
	je l_81
	l_82:
	mov rbx, qword [rbp-64]
	inc rbx
	mov qword [rbp-64], rbx
	mov rbx, qword [rbp-160]
	mov r10, rbx
	mov qword [rbp-96], r10
	mov rcx, 1
	mov rbx, qword [rbp-96]
	sar rbx, cl
	mov qword [rbp-96], rbx
	mov r10, qword [g_5]
	mov r11, qword [rbp-160]
	mov rbx, qword [r10 + r11 * 8 + 8]
	mov qword [rbp-80], rbx
	mov rbx, qword [rbp-80]
	mov r10, qword [g_5]
	mov r11, qword [rbp-96]
	cmp rbx, qword [r10 + r11 * 8 + 8]
	jg l_83
	l_84:
	mov r10, qword [g_5]
	mov r11, qword [rbp-160]
	mov rbx, qword [r10 + r11 * 8 + 8]
	mov qword [rbp-8], rbx
	mov r10, qword [rbp-160]
	mov rbx, r10
	mov qword [rbp-16], rbx
	mov rcx, 1
	mov rbx, qword [rbp-16]
	sar rbx, cl
	mov qword [rbp-16], rbx
	mov rbx, qword [rbp-16]
	mov r10, qword [g_5]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-152], r11
	mov rbx, qword [g_5]
	mov r10, qword [rbp-160]
	mov r11, qword [rbp-152]
	mov qword [rbx + r10 * 8 + 8], r11
	mov rbx, qword [rbp-160]
	mov r10, rbx
	mov qword [rbp-120], r10
	mov rcx, 1
	mov rbx, qword [rbp-120]
	sar rbx, cl
	mov qword [rbp-120], rbx
	mov rbx, qword [rbp-8]
	mov r10, qword [g_5]
	mov r11, qword [rbp-120]
	mov qword [r10 + r11 * 8 + 8], rbx
	mov rcx, 1
	mov rbx, qword [rbp-160]
	sar rbx, cl
	mov qword [rbp-160], rbx
	jmp l_80
	l_83:
	l_81:
	l_85:
	mov rbx, qword [rbp-56]
	inc rbx
	mov qword [rbp-56], rbx
	jmp l_63
_main_User_Defined_fihriaifhiahidsafans:
	l_86:
	push rbp
	mov rbp, rsp
	sub rsp, 192
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	call __getInt 
	mov qword [rbp-168], rax
	mov r10, qword [rbp-168]
	mov rbx, r10
	mov qword [g_0], rbx
	call __getInt 
	mov qword [rbp-152], rax
	mov r10, qword [rbp-152]
	mov rbx, r10
	mov qword [rbp-128], rbx
	mov rbx, 1
	mov qword [rbp-8], rbx
	l_87:
	mov rbx, qword [rbp-8]
	mov r10, qword [g_0]
	cmp rbx, r10
	jle l_88
	l_89:
	mov rbx, qword [g_0]
	mov r10, rbx
	mov qword [rbp-40], r10
	mov rbx, qword [rbp-40]
	add rbx, 1
	mov qword [rbp-40], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rsi, qword [rbp-40]
	mov rdi, 1
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	call _quicksort_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-48], rax
	mov r10, qword [rbp-48]
	mov rbx, r10
	mov qword [rbp-88], rbx
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	call _restore_User_Defined_fihriaifhiahidsafans 
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	call _calc_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-112], rax
	mov rbx, qword [rbp-112]
	mov r10, rbx
	mov qword [rbp-176], r10
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	call _restore_User_Defined_fihriaifhiahidsafans 
	mov rbx, qword [g_0]
	mov r10, rbx
	mov qword [rbp-24], r10
	mov rbx, qword [rbp-24]
	add rbx, 1
	mov qword [rbp-24], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rsi, qword [rbp-24]
	mov rdi, 1
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	call _mergesort_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-136], rax
	mov r10, qword [rbp-136]
	mov rbx, r10
	mov qword [rbp-32], rbx
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	call _restore_User_Defined_fihriaifhiahidsafans 
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	call _heapsort_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-192], rax
	mov r10, qword [rbp-192]
	mov rbx, r10
	mov qword [rbp-64], rbx
	mov rdi, qword [rbp-88]
	call __toString 
	mov qword [rbp-104], rax
	mov rdi, qword [rbp-104]
	call __println 
	mov rdi, qword [rbp-176]
	call __toString 
	mov qword [rbp-96], rax
	mov rdi, qword [rbp-96]
	call __println 
	mov rdi, qword [rbp-32]
	call __toString 
	mov qword [rbp-184], rax
	mov rdi, qword [rbp-184]
	call __println 
	mov rdi, qword [rbp-64]
	call __toString 
	mov qword [rbp-16], rax
	mov rdi, qword [rbp-16]
	call __println 
	mov rdi, 8
	call malloc 
	mov qword [rbp-72], rax
	mov rbx, qword [rbp-72]
	add rbx, 8
	mov qword [rbp-72], rbx
	mov rbx, qword [rbp-72]
	mov qword [rbx], 0
	mov rbx, qword [rbp-72]
	sub rbx, 8
	mov qword [rbp-72], rbx
	mov r10, qword [rbp-72]
	mov rbx, r10
	mov qword [rbp-160], rbx
	mov rbx, qword [rbp-160]
	mov r10, rbx
	mov qword [rbp-80], r10
	mov rdi, qword [rbp-80]
	call _Optimizer_User_Defined_fihriaifhiahidsafans 
	mov rax, 0
	l_90:
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	leave 
	ret
	l_88:
	mov rbx, qword [rbp-8]
	mov r10, qword [g_2]
	mov qword [r10 + rbx * 8 + 8], rbx
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-128]
	cmp rbx, r10
	jg l_91
	l_92:
	mov rbx, qword [rbp-128]
	mov r10, rbx
	mov qword [rbp-144], r10
	mov rbx, qword [rbp-144]
	add rbx, 1
	mov qword [rbp-144], rbx
	mov rbx, qword [rbp-144]
	mov r10, rbx
	mov qword [rbp-120], r10
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-120]
	sub r10, rbx
	mov qword [rbp-120], r10
	mov rbx, qword [rbp-8]
	mov r10, qword [g_2]
	mov r11, qword [rbp-120]
	mov qword [r10 + rbx * 8 + 8], r11
	l_91:
	mov rbx, qword [rbp-8]
	mov r11, qword [g_2]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-56], r10
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-56]
	mov r11, qword [g_1]
	mov qword [r11 + rbx * 8 + 8], r10
	l_93:
	mov rbx, qword [rbp-8]
	inc rbx
	mov qword [rbp-8], rbx
	jmp l_87
_A_User_Defined_fihriaifhiahidsafans:
	l_94:
	push rbp
	mov rbp, rsp
	sub rsp, 256
	mov qword [rbp-184], rdi
	mov rbx, 2
	mov qword [rbp-80], rbx
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-152]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-152], r10
	mov rdi, qword [rbp-152]
	call malloc 
	mov qword [rbp-240], rax
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-240]
	mov qword [r10], rbx
	l_95:
	mov rbx, qword [rbp-80]
	cmp rbx, 0
	jg l_96
	l_97:
	mov rbx, qword [rbp-184]
	mov r10, qword [rbp-240]
	mov qword [rbx + 0], r10
	l_98:
	leave 
	ret
	l_96:
	mov rbx, 2
	mov qword [rbp-224], rbx
	mov rbx, qword [rbp-224]
	mov r10, qword [rbp-24]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-24], r10
	mov rdi, qword [rbp-24]
	call malloc 
	mov qword [rbp-48], rax
	mov rbx, qword [rbp-224]
	mov r10, qword [rbp-48]
	mov qword [r10], rbx
	l_99:
	mov rbx, qword [rbp-224]
	cmp rbx, 0
	jg l_100
	l_101:
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-48]
	mov r11, qword [rbp-240]
	mov qword [r11 + rbx * 8], r10
	mov rbx, qword [rbp-80]
	dec rbx
	mov qword [rbp-80], rbx
	jmp l_95
	l_100:
	mov rbx, 3
	mov qword [rbp-160], rbx
	mov rbx, qword [rbp-160]
	mov r10, qword [rbp-200]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-200], r10
	mov rdi, qword [rbp-200]
	call malloc 
	mov qword [rbp-128], rax
	mov rbx, qword [rbp-128]
	mov r10, qword [rbp-160]
	mov qword [rbx], r10
	l_102:
	mov rbx, qword [rbp-160]
	cmp rbx, 0
	jg l_103
	l_104:
	mov rbx, qword [rbp-128]
	mov r10, qword [rbp-48]
	mov r11, qword [rbp-224]
	mov qword [r10 + r11 * 8], rbx
	mov rbx, qword [rbp-224]
	dec rbx
	mov qword [rbp-224], rbx
	jmp l_99
	l_103:
	mov rbx, 2
	mov qword [rbp-248], rbx
	mov rbx, qword [rbp-248]
	mov r10, qword [rbp-96]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-96], r10
	mov rdi, qword [rbp-96]
	call malloc 
	mov qword [rbp-112], rax
	mov rbx, qword [rbp-248]
	mov r10, qword [rbp-112]
	mov qword [r10], rbx
	l_105:
	mov rbx, qword [rbp-248]
	cmp rbx, 0
	jg l_106
	l_107:
	mov rbx, qword [rbp-128]
	mov r10, qword [rbp-160]
	mov r11, qword [rbp-112]
	mov qword [rbx + r10 * 8], r11
	mov rbx, qword [rbp-160]
	dec rbx
	mov qword [rbp-160], rbx
	jmp l_102
	l_106:
	mov rbx, 3
	mov qword [rbp-216], rbx
	mov rbx, qword [rbp-120]
	mov r10, qword [rbp-216]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-120], rbx
	mov rdi, qword [rbp-120]
	call malloc 
	mov qword [rbp-168], rax
	mov rbx, qword [rbp-168]
	mov r10, qword [rbp-216]
	mov qword [rbx], r10
	l_108:
	mov rbx, qword [rbp-216]
	cmp rbx, 0
	jg l_109
	l_110:
	mov rbx, qword [rbp-248]
	mov r10, qword [rbp-168]
	mov r11, qword [rbp-112]
	mov qword [r11 + rbx * 8], r10
	mov rbx, qword [rbp-248]
	dec rbx
	mov qword [rbp-248], rbx
	jmp l_105
	l_109:
	mov rbx, 2
	mov qword [rbp-136], rbx
	mov rbx, qword [rbp-88]
	mov r10, qword [rbp-136]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-88], rbx
	mov rdi, qword [rbp-88]
	call malloc 
	mov qword [rbp-64], rax
	mov rbx, qword [rbp-64]
	mov r10, qword [rbp-136]
	mov qword [rbx], r10
	l_111:
	mov rbx, qword [rbp-136]
	cmp rbx, 0
	jg l_112
	l_113:
	mov rbx, qword [rbp-168]
	mov r10, qword [rbp-216]
	mov r11, qword [rbp-64]
	mov qword [rbx + r10 * 8], r11
	mov rbx, qword [rbp-216]
	dec rbx
	mov qword [rbp-216], rbx
	jmp l_108
	l_112:
	mov rbx, 2
	mov qword [rbp-208], rbx
	mov rbx, qword [rbp-16]
	mov r10, qword [rbp-208]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-16], rbx
	mov rdi, qword [rbp-16]
	call malloc 
	mov qword [rbp-144], rax
	mov rbx, qword [rbp-144]
	mov r10, qword [rbp-208]
	mov qword [rbx], r10
	l_114:
	mov rbx, qword [rbp-208]
	cmp rbx, 0
	jg l_115
	l_116:
	mov rbx, qword [rbp-144]
	mov r10, qword [rbp-64]
	mov r11, qword [rbp-136]
	mov qword [r10 + r11 * 8], rbx
	mov rbx, qword [rbp-136]
	dec rbx
	mov qword [rbp-136], rbx
	jmp l_111
	l_115:
	mov rbx, 3
	mov qword [rbp-176], rbx
	mov rbx, qword [rbp-192]
	mov r10, qword [rbp-176]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-192], rbx
	mov rdi, qword [rbp-192]
	call malloc 
	mov qword [rbp-72], rax
	mov rbx, qword [rbp-72]
	mov r10, qword [rbp-176]
	mov qword [rbx], r10
	l_117:
	mov rbx, qword [rbp-176]
	cmp rbx, 0
	jg l_118
	l_119:
	mov rbx, qword [rbp-72]
	mov r10, qword [rbp-144]
	mov r11, qword [rbp-208]
	mov qword [r10 + r11 * 8], rbx
	mov rbx, qword [rbp-208]
	dec rbx
	mov qword [rbp-208], rbx
	jmp l_114
	l_118:
	mov rbx, 2
	mov qword [rbp-40], rbx
	mov rbx, qword [rbp-56]
	mov r10, qword [rbp-40]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-56], rbx
	mov rdi, qword [rbp-56]
	call malloc 
	mov qword [rbp-32], rax
	mov rbx, qword [rbp-40]
	mov r10, qword [rbp-32]
	mov qword [r10], rbx
	l_120:
	mov rbx, qword [rbp-40]
	cmp rbx, 0
	jg l_121
	l_122:
	mov rbx, qword [rbp-72]
	mov r10, qword [rbp-176]
	mov r11, qword [rbp-32]
	mov qword [rbx + r10 * 8], r11
	mov rbx, qword [rbp-176]
	dec rbx
	mov qword [rbp-176], rbx
	jmp l_117
	l_121:
	mov rbx, 2
	mov qword [rbp-8], rbx
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-232]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-232], r10
	mov rdi, qword [rbp-232]
	call malloc 
	mov qword [rbp-104], rax
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-104]
	mov qword [r10], rbx
	l_123:
	mov rbx, qword [rbp-8]
	cmp rbx, 0
	jg l_124
	l_125:
	mov rbx, qword [rbp-104]
	mov r10, qword [rbp-40]
	mov r11, qword [rbp-32]
	mov qword [r11 + r10 * 8], rbx
	mov rbx, qword [rbp-40]
	dec rbx
	mov qword [rbp-40], rbx
	jmp l_120
	l_124:
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-104]
	mov qword [r10 + rbx * 8], 0
	mov rbx, qword [rbp-8]
	dec rbx
	mov qword [rbp-8], rbx
	jmp l_123
_Optimizer_User_Defined_fihriaifhiahidsafans:
	l_126:
	push rbp
	mov rbp, rsp
	sub rsp, 3344
	mov rbx, 2
	mov qword [rbp-1896], rbx
	mov rbx, qword [rbp-3016]
	mov r10, qword [rbp-1896]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-3016], rbx
	mov rdi, qword [rbp-3016]
	call malloc 
	mov qword [rbp-448], rax
	mov rbx, qword [rbp-1896]
	mov r10, qword [rbp-448]
	mov qword [r10], rbx
	l_127:
	mov rbx, qword [rbp-1896]
	cmp rbx, 0
	jg l_128
	l_129:
	mov rbx, qword [rbp-448]
	mov r10, rbx
	mov qword [rbp-1080], r10
	mov rbx, 0
	mov qword [rbp-1768], rbx
	mov rbx, 1
	mov qword [rbp-1656], rbx
	l_130:
	mov rbx, qword [rbp-1656]
	cmp rbx, 1000
	jle l_131
	l_132:
	mov rdi, qword [rbp-1768]
	call __toString 
	mov qword [rbp-704], rax
	mov rdi, qword [rbp-704]
	call __println 
	mov rbx, 1
	mov qword [rbp-1656], rbx
	l_133:
	mov rbx, qword [rbp-1656]
	cmp rbx, 1000000
	jle l_134
	l_135:
	mov rdi, qword [rbp-1768]
	call __toString 
	mov qword [rbp-192], rax
	mov rdi, qword [rbp-192]
	call __println 
	mov rbx, 1
	mov qword [rbp-1656], rbx
	l_136:
	mov rbx, qword [rbp-1656]
	cmp rbx, 200000000
	jle l_137
	l_138:
	l_139:
	leave 
	ret
	l_137:
	l_140:
	mov rbx, qword [rbp-1656]
	inc rbx
	mov qword [rbp-1656], rbx
	jmp l_136
	l_134:
	mov rax, 9876
	cdq
	mov rbx, 1234
	mov qword [rbp-440], rbx
	mov rbx, qword [rbp-440]
	idiv rbx
	mov qword [rbp-2888], rdx
	mov rax, qword [rbp-2888]
	mov rbx, 2345
	mov qword [rbp-2128], rbx
	mov rbx, qword [rbp-2128]
	imul rbx
	mov qword [rbp-1760], rax
	mov rax, qword [rbp-1760]
	cdq
	mov rbx, 1234
	mov qword [rbp-576], rbx
	mov rbx, qword [rbp-576]
	idiv rbx
	mov qword [rbp-992], rdx
	mov rax, qword [rbp-992]
	mov rbx, 2345
	mov qword [rbp-8], rbx
	mov rbx, qword [rbp-8]
	imul rbx
	mov qword [rbp-2928], rax
	mov rax, qword [rbp-2928]
	cdq
	mov rbx, 1234
	mov qword [rbp-1952], rbx
	mov rbx, qword [rbp-1952]
	idiv rbx
	mov qword [rbp-1600], rdx
	mov rax, qword [rbp-1600]
	mov rbx, 2345
	mov qword [rbp-2032], rbx
	mov rbx, qword [rbp-2032]
	imul rbx
	mov qword [rbp-712], rax
	mov rax, qword [rbp-712]
	cdq
	mov rbx, 1234
	mov qword [rbp-3064], rbx
	mov rbx, qword [rbp-3064]
	idiv rbx
	mov qword [rbp-584], rdx
	mov rax, qword [rbp-584]
	mov rbx, 2345
	mov qword [rbp-2808], rbx
	mov rbx, qword [rbp-2808]
	imul rbx
	mov qword [rbp-1264], rax
	mov rax, qword [rbp-1264]
	cdq
	mov rbx, 1234
	mov qword [rbp-432], rbx
	mov rbx, qword [rbp-432]
	idiv rbx
	mov qword [rbp-2952], rdx
	mov rax, qword [rbp-2952]
	mov rbx, 2345
	mov qword [rbp-2136], rbx
	mov rbx, qword [rbp-2136]
	imul rbx
	mov qword [rbp-3048], rax
	mov rax, qword [rbp-3048]
	cdq
	mov rbx, 1234
	mov qword [rbp-2208], rbx
	mov rbx, qword [rbp-2208]
	idiv rbx
	mov qword [rbp-2712], rdx
	mov rax, qword [rbp-2712]
	mov rbx, 2345
	mov qword [rbp-1552], rbx
	mov rbx, qword [rbp-1552]
	imul rbx
	mov qword [rbp-1488], rax
	mov rax, qword [rbp-1488]
	cdq
	mov rbx, 1234
	mov qword [rbp-2576], rbx
	mov rbx, qword [rbp-2576]
	idiv rbx
	mov qword [rbp-472], rdx
	mov rax, qword [rbp-472]
	mov rbx, 2345
	mov qword [rbp-2304], rbx
	mov rbx, qword [rbp-2304]
	imul rbx
	mov qword [rbp-2560], rax
	mov rax, qword [rbp-2560]
	cdq
	mov rbx, 1234
	mov qword [rbp-728], rbx
	mov rbx, qword [rbp-728]
	idiv rbx
	mov qword [rbp-968], rdx
	mov rax, qword [rbp-968]
	mov rbx, 2345
	mov qword [rbp-2648], rbx
	mov rbx, qword [rbp-2648]
	imul rbx
	mov qword [rbp-64], rax
	mov rax, qword [rbp-64]
	cdq
	mov rbx, 1234
	mov qword [rbp-2864], rbx
	mov rbx, qword [rbp-2864]
	idiv rbx
	mov qword [rbp-1416], rdx
	mov rax, qword [rbp-1416]
	mov rbx, 2345
	mov qword [rbp-520], rbx
	mov rbx, qword [rbp-520]
	imul rbx
	mov qword [rbp-2072], rax
	mov rax, qword [rbp-2072]
	cdq
	mov rbx, 1234
	mov qword [rbp-1704], rbx
	mov rbx, qword [rbp-1704]
	idiv rbx
	mov qword [rbp-368], rdx
	mov rax, qword [rbp-368]
	mov rbx, 2345
	mov qword [rbp-872], rbx
	mov rbx, qword [rbp-872]
	imul rbx
	mov qword [rbp-400], rax
	mov rax, qword [rbp-400]
	cdq
	mov rbx, 1234
	mov qword [rbp-2768], rbx
	mov rbx, qword [rbp-2768]
	idiv rbx
	mov qword [rbp-1400], rdx
	mov rax, qword [rbp-1400]
	mov rbx, 2345
	mov qword [rbp-3320], rbx
	mov rbx, qword [rbp-3320]
	imul rbx
	mov qword [rbp-2360], rax
	mov rax, qword [rbp-2360]
	cdq
	mov rbx, 1234
	mov qword [rbp-2736], rbx
	mov rbx, qword [rbp-2736]
	idiv rbx
	mov qword [rbp-1312], rdx
	mov rax, qword [rbp-1312]
	mov rbx, 2345
	mov qword [rbp-3024], rbx
	mov rbx, qword [rbp-3024]
	imul rbx
	mov qword [rbp-2744], rax
	mov rax, qword [rbp-2744]
	cdq
	mov rbx, 1234
	mov qword [rbp-2424], rbx
	mov rbx, qword [rbp-2424]
	idiv rbx
	mov qword [rbp-2472], rdx
	mov rax, qword [rbp-2472]
	mov rbx, 2345
	mov qword [rbp-2240], rbx
	mov rbx, qword [rbp-2240]
	imul rbx
	mov qword [rbp-264], rax
	mov rax, qword [rbp-264]
	cdq
	mov rbx, 1234
	mov qword [rbp-3168], rbx
	mov rbx, qword [rbp-3168]
	idiv rbx
	mov qword [rbp-1144], rdx
	mov rax, qword [rbp-1144]
	mov rbx, 2345
	mov qword [rbp-936], rbx
	mov rbx, qword [rbp-936]
	imul rbx
	mov qword [rbp-1272], rax
	mov rax, qword [rbp-1272]
	cdq
	mov rbx, 1234
	mov qword [rbp-1200], rbx
	mov rbx, qword [rbp-1200]
	idiv rbx
	mov qword [rbp-2704], rdx
	mov rax, qword [rbp-2704]
	mov rbx, 2345
	mov qword [rbp-2976], rbx
	mov rbx, qword [rbp-2976]
	imul rbx
	mov qword [rbp-3312], rax
	mov rax, qword [rbp-3312]
	cdq
	mov rbx, 1234
	mov qword [rbp-1344], rbx
	mov rbx, qword [rbp-1344]
	idiv rbx
	mov qword [rbp-552], rdx
	mov rax, qword [rbp-552]
	mov rbx, 2345
	mov qword [rbp-2912], rbx
	mov rbx, qword [rbp-2912]
	imul rbx
	mov qword [rbp-1104], rax
	mov rax, qword [rbp-1104]
	cdq
	mov rbx, 1234
	mov qword [rbp-2016], rbx
	mov rbx, qword [rbp-2016]
	idiv rbx
	mov qword [rbp-1792], rdx
	mov rax, qword [rbp-1792]
	mov rbx, 2345
	mov qword [rbp-424], rbx
	mov rbx, qword [rbp-424]
	imul rbx
	mov qword [rbp-2456], rax
	mov rax, qword [rbp-2456]
	cdq
	mov rbx, 1234
	mov qword [rbp-2528], rbx
	mov rbx, qword [rbp-2528]
	idiv rbx
	mov qword [rbp-1880], rdx
	mov rax, qword [rbp-1880]
	mov rbx, 2345
	mov qword [rbp-2992], rbx
	mov rbx, qword [rbp-2992]
	imul rbx
	mov qword [rbp-600], rax
	mov rax, qword [rbp-600]
	cdq
	mov rbx, 1234
	mov qword [rbp-248], rbx
	mov rbx, qword [rbp-248]
	idiv rbx
	mov qword [rbp-2488], rdx
	mov rax, qword [rbp-2488]
	mov rbx, 2345
	mov qword [rbp-240], rbx
	mov rbx, qword [rbp-240]
	imul rbx
	mov qword [rbp-1032], rax
	mov rax, qword [rbp-1032]
	cdq
	mov rbx, 1234
	mov qword [rbp-2112], rbx
	mov rbx, qword [rbp-2112]
	idiv rbx
	mov qword [rbp-744], rdx
	mov rax, qword [rbp-744]
	mov rbx, 2345
	mov qword [rbp-1152], rbx
	mov rbx, qword [rbp-1152]
	imul rbx
	mov qword [rbp-344], rax
	mov rax, qword [rbp-344]
	cdq
	mov rbx, 1234
	mov qword [rbp-3272], rbx
	mov rbx, qword [rbp-3272]
	idiv rbx
	mov qword [rbp-3152], rdx
	mov rax, qword [rbp-3152]
	mov rbx, 2345
	mov qword [rbp-224], rbx
	mov rbx, qword [rbp-224]
	imul rbx
	mov qword [rbp-1280], rax
	mov rax, qword [rbp-1280]
	cdq
	mov rbx, 1234
	mov qword [rbp-1520], rbx
	mov rbx, qword [rbp-1520]
	idiv rbx
	mov qword [rbp-776], rdx
	mov rax, qword [rbp-776]
	mov rbx, 2345
	mov qword [rbp-720], rbx
	mov rbx, qword [rbp-720]
	imul rbx
	mov qword [rbp-952], rax
	mov rax, qword [rbp-952]
	cdq
	mov rbx, 1234
	mov qword [rbp-1008], rbx
	mov rbx, qword [rbp-1008]
	idiv rbx
	mov qword [rbp-2936], rdx
	mov rax, qword [rbp-2936]
	mov rbx, 2345
	mov qword [rbp-1616], rbx
	mov rbx, qword [rbp-1616]
	imul rbx
	mov qword [rbp-1752], rax
	mov rax, qword [rbp-1752]
	cdq
	mov rbx, 1234
	mov qword [rbp-1888], rbx
	mov rbx, qword [rbp-1888]
	idiv rbx
	mov qword [rbp-1000], rdx
	mov rax, qword [rbp-1000]
	mov rbx, 2345
	mov qword [rbp-2432], rbx
	mov rbx, qword [rbp-2432]
	imul rbx
	mov qword [rbp-1720], rax
	mov rax, qword [rbp-1720]
	cdq
	mov rbx, 1234
	mov qword [rbp-2696], rbx
	mov rbx, qword [rbp-2696]
	idiv rbx
	mov qword [rbp-616], rdx
	mov rax, qword [rbp-616]
	mov rbx, 2345
	mov qword [rbp-528], rbx
	mov rbx, qword [rbp-528]
	imul rbx
	mov qword [rbp-2856], rax
	mov rax, qword [rbp-2856]
	cdq
	mov rbx, 1234
	mov qword [rbp-2200], rbx
	mov rbx, qword [rbp-2200]
	idiv rbx
	mov qword [rbp-1208], rdx
	mov rax, qword [rbp-1208]
	mov rbx, 2345
	mov qword [rbp-2352], rbx
	mov rbx, qword [rbp-2352]
	imul rbx
	mov qword [rbp-1728], rax
	mov rax, qword [rbp-1728]
	cdq
	mov rbx, 1234
	mov qword [rbp-2504], rbx
	mov rbx, qword [rbp-2504]
	idiv rbx
	mov qword [rbp-2640], rdx
	mov rax, qword [rbp-2640]
	mov rbx, 2345
	mov qword [rbp-536], rbx
	mov rbx, qword [rbp-536]
	imul rbx
	mov qword [rbp-848], rax
	mov rax, qword [rbp-848]
	cdq
	mov rbx, 1234
	mov qword [rbp-40], rbx
	mov rbx, qword [rbp-40]
	idiv rbx
	mov qword [rbp-2656], rdx
	mov rax, qword [rbp-2656]
	mov rbx, 2345
	mov qword [rbp-1496], rbx
	mov rbx, qword [rbp-1496]
	imul rbx
	mov qword [rbp-1608], rax
	mov rax, qword [rbp-1608]
	cdq
	mov rbx, 1234
	mov qword [rbp-1288], rbx
	mov rbx, qword [rbp-1288]
	idiv rbx
	mov qword [rbp-360], rdx
	mov rax, qword [rbp-360]
	mov rbx, 2345
	mov qword [rbp-3056], rbx
	mov rbx, qword [rbp-3056]
	imul rbx
	mov qword [rbp-2392], rax
	mov rax, qword [rbp-2392]
	cdq
	mov rbx, 1234
	mov qword [rbp-2728], rbx
	mov rbx, qword [rbp-2728]
	idiv rbx
	mov qword [rbp-328], rdx
	mov rax, qword [rbp-328]
	mov rbx, 2345
	mov qword [rbp-2632], rbx
	mov rbx, qword [rbp-2632]
	imul rbx
	mov qword [rbp-2288], rax
	mov rax, qword [rbp-2288]
	cdq
	mov rbx, 1234
	mov qword [rbp-2688], rbx
	mov rbx, qword [rbp-2688]
	idiv rbx
	mov qword [rbp-2296], rdx
	mov rax, qword [rbp-2296]
	mov rbx, 2345
	mov qword [rbp-1856], rbx
	mov rbx, qword [rbp-1856]
	imul rbx
	mov qword [rbp-2584], rax
	mov rax, qword [rbp-2584]
	cdq
	mov rbx, 1234
	mov qword [rbp-680], rbx
	mov rbx, qword [rbp-680]
	idiv rbx
	mov qword [rbp-960], rdx
	mov rax, qword [rbp-960]
	mov rbx, 2345
	mov qword [rbp-120], rbx
	mov rbx, qword [rbp-120]
	imul rbx
	mov qword [rbp-3192], rax
	mov rax, qword [rbp-3192]
	cdq
	mov rbx, 1234
	mov qword [rbp-1440], rbx
	mov rbx, qword [rbp-1440]
	idiv rbx
	mov qword [rbp-56], rdx
	mov rax, qword [rbp-56]
	mov rbx, 2345
	mov qword [rbp-1712], rbx
	mov rbx, qword [rbp-1712]
	imul rbx
	mov qword [rbp-2480], rax
	mov rax, qword [rbp-2480]
	cdq
	mov rbx, 1234
	mov qword [rbp-2440], rbx
	mov rbx, qword [rbp-2440]
	idiv rbx
	mov qword [rbp-3336], rdx
	mov rax, qword [rbp-3336]
	mov rbx, 2345
	mov qword [rbp-1064], rbx
	mov rbx, qword [rbp-1064]
	imul rbx
	mov qword [rbp-2672], rax
	mov rax, qword [rbp-2672]
	cdq
	mov rbx, 1234
	mov qword [rbp-2872], rbx
	mov rbx, qword [rbp-2872]
	idiv rbx
	mov qword [rbp-2520], rdx
	mov rax, qword [rbp-2520]
	mov rbx, 2345
	mov qword [rbp-1848], rbx
	mov rbx, qword [rbp-1848]
	imul rbx
	mov qword [rbp-1160], rax
	mov rax, qword [rbp-1160]
	cdq
	mov rbx, 1234
	mov qword [rbp-880], rbx
	mov rbx, qword [rbp-880]
	idiv rbx
	mov qword [rbp-3256], rdx
	mov rax, qword [rbp-3256]
	mov rbx, 2345
	mov qword [rbp-3008], rbx
	mov rbx, qword [rbp-3008]
	imul rbx
	mov qword [rbp-1840], rax
	mov rax, qword [rbp-1840]
	cdq
	mov rbx, 1234
	mov qword [rbp-16], rbx
	mov rbx, qword [rbp-16]
	idiv rbx
	mov qword [rbp-1120], rdx
	mov rax, qword [rbp-1120]
	mov rbx, 2345
	mov qword [rbp-2256], rbx
	mov rbx, qword [rbp-2256]
	imul rbx
	mov qword [rbp-32], rax
	mov rax, qword [rbp-32]
	cdq
	mov rbx, 1234
	mov qword [rbp-1016], rbx
	mov rbx, qword [rbp-1016]
	idiv rbx
	mov qword [rbp-504], rdx
	mov rax, qword [rbp-504]
	mov rbx, 2345
	mov qword [rbp-352], rbx
	mov rbx, qword [rbp-352]
	imul rbx
	mov qword [rbp-1664], rax
	mov rax, qword [rbp-1664]
	cdq
	mov rbx, 1234
	mov qword [rbp-1224], rbx
	mov rbx, qword [rbp-1224]
	idiv rbx
	mov qword [rbp-3080], rdx
	mov rax, qword [rbp-3080]
	mov rbx, 2345
	mov qword [rbp-2880], rbx
	mov rbx, qword [rbp-2880]
	imul rbx
	mov qword [rbp-2008], rax
	mov rax, qword [rbp-2008]
	cdq
	mov rbx, 1234
	mov qword [rbp-1984], rbx
	mov rbx, qword [rbp-1984]
	idiv rbx
	mov qword [rbp-1776], rdx
	mov rax, qword [rbp-1776]
	mov rbx, 2345
	mov qword [rbp-760], rbx
	mov rbx, qword [rbp-760]
	imul rbx
	mov qword [rbp-512], rax
	mov rax, qword [rbp-512]
	cdq
	mov rbx, 1234
	mov qword [rbp-416], rbx
	mov rbx, qword [rbp-416]
	idiv rbx
	mov qword [rbp-2056], rdx
	mov rax, qword [rbp-2056]
	mov rbx, 2345
	mov qword [rbp-976], rbx
	mov rbx, qword [rbp-976]
	imul rbx
	mov qword [rbp-2800], rax
	mov rax, qword [rbp-2800]
	cdq
	mov rbx, 1234
	mov qword [rbp-3104], rbx
	mov rbx, qword [rbp-3104]
	idiv rbx
	mov qword [rbp-3288], rdx
	mov rax, qword [rbp-3288]
	mov rbx, 2345
	mov qword [rbp-2400], rbx
	mov rbx, qword [rbp-2400]
	imul rbx
	mov qword [rbp-2088], rax
	mov rax, qword [rbp-2088]
	cdq
	mov rbx, 1234
	mov qword [rbp-1968], rbx
	mov rbx, qword [rbp-1968]
	idiv rbx
	mov qword [rbp-2592], rdx
	mov rax, qword [rbp-2592]
	mov rbx, 2345
	mov qword [rbp-824], rbx
	mov rbx, qword [rbp-824]
	imul rbx
	mov qword [rbp-832], rax
	mov rax, qword [rbp-832]
	cdq
	mov rbx, 1234
	mov qword [rbp-3200], rbx
	mov rbx, qword [rbp-3200]
	idiv rbx
	mov qword [rbp-2176], rdx
	mov rax, qword [rbp-2176]
	mov rbx, 2345
	mov qword [rbp-984], rbx
	mov rbx, qword [rbp-984]
	imul rbx
	mov qword [rbp-2840], rax
	mov rax, qword [rbp-2840]
	cdq
	mov rbx, 1234
	mov qword [rbp-896], rbx
	mov rbx, qword [rbp-896]
	idiv rbx
	mov qword [rbp-1048], rdx
	mov rax, qword [rbp-1048]
	mov rbx, 2345
	mov qword [rbp-624], rbx
	mov rbx, qword [rbp-624]
	imul rbx
	mov qword [rbp-3136], rax
	mov rax, qword [rbp-3136]
	cdq
	mov rbx, 1234
	mov qword [rbp-3040], rbx
	mov rbx, qword [rbp-3040]
	idiv rbx
	mov qword [rbp-2600], rdx
	mov rax, qword [rbp-2600]
	mov rbx, 2345
	mov qword [rbp-304], rbx
	mov rbx, qword [rbp-304]
	imul rbx
	mov qword [rbp-2448], rax
	mov rax, qword [rbp-2448]
	cdq
	mov rbx, 1234
	mov qword [rbp-1976], rbx
	mov rbx, qword [rbp-1976]
	idiv rbx
	mov qword [rbp-160], rdx
	mov rax, qword [rbp-160]
	mov rbx, 2345
	mov qword [rbp-1816], rbx
	mov rbx, qword [rbp-1816]
	imul rbx
	mov qword [rbp-320], rax
	mov rax, qword [rbp-320]
	cdq
	mov rbx, 1234
	mov qword [rbp-3296], rbx
	mov rbx, qword [rbp-3296]
	idiv rbx
	mov qword [rbp-1168], rdx
	mov rax, qword [rbp-1168]
	mov rbx, 2345
	mov qword [rbp-2024], rbx
	mov rbx, qword [rbp-2024]
	imul rbx
	mov qword [rbp-2776], rax
	mov rax, qword [rbp-2776]
	cdq
	mov rbx, 1234
	mov qword [rbp-3248], rbx
	mov rbx, qword [rbp-3248]
	idiv rbx
	mov qword [rbp-1096], rdx
	mov rax, qword [rbp-1096]
	mov rbx, 2345
	mov qword [rbp-312], rbx
	mov rbx, qword [rbp-312]
	imul rbx
	mov qword [rbp-2320], rax
	mov rax, qword [rbp-2320]
	cdq
	mov rbx, 1234
	mov qword [rbp-1072], rbx
	mov rbx, qword [rbp-1072]
	idiv rbx
	mov qword [rbp-280], rdx
	mov rax, qword [rbp-280]
	mov rbx, 2345
	mov qword [rbp-1176], rbx
	mov rbx, qword [rbp-1176]
	imul rbx
	mov qword [rbp-3176], rax
	mov rax, qword [rbp-3176]
	cdq
	mov rbx, 1234
	mov qword [rbp-288], rbx
	mov rbx, qword [rbp-288]
	idiv rbx
	mov qword [rbp-2040], rdx
	mov rax, qword [rbp-2040]
	mov rbx, 2345
	mov qword [rbp-3160], rbx
	mov rbx, qword [rbp-3160]
	imul rbx
	mov qword [rbp-560], rax
	mov rax, qword [rbp-560]
	cdq
	mov rbx, 1234
	mov qword [rbp-1472], rbx
	mov rbx, qword [rbp-1472]
	idiv rbx
	mov qword [rbp-856], rdx
	mov rax, qword [rbp-856]
	mov rbx, 2345
	mov qword [rbp-2960], rbx
	mov rbx, qword [rbp-2960]
	imul rbx
	mov qword [rbp-2416], rax
	mov rax, qword [rbp-2416]
	cdq
	mov rbx, 1234
	mov qword [rbp-1216], rbx
	mov rbx, qword [rbp-1216]
	idiv rbx
	mov qword [rbp-3344], rdx
	mov rax, qword [rbp-3344]
	mov rbx, 2345
	mov qword [rbp-3264], rbx
	mov rbx, qword [rbp-3264]
	imul rbx
	mov qword [rbp-1864], rax
	mov rax, qword [rbp-1864]
	cdq
	mov rbx, 1234
	mov qword [rbp-2168], rbx
	mov rbx, qword [rbp-2168]
	idiv rbx
	mov qword [rbp-2272], rdx
	mov rax, qword [rbp-2272]
	mov rbx, 2345
	mov qword [rbp-1480], rbx
	mov rbx, qword [rbp-1480]
	imul rbx
	mov qword [rbp-888], rax
	mov rax, qword [rbp-888]
	cdq
	mov rbx, 1234
	mov qword [rbp-2544], rbx
	mov rbx, qword [rbp-2544]
	idiv rbx
	mov qword [rbp-1872], rdx
	mov rax, qword [rbp-1872]
	mov rbx, 2345
	mov qword [rbp-2336], rbx
	mov rbx, qword [rbp-2336]
	imul rbx
	mov qword [rbp-3184], rax
	mov rax, qword [rbp-3184]
	cdq
	mov rbx, 1234
	mov qword [rbp-296], rbx
	mov rbx, qword [rbp-296]
	idiv rbx
	mov qword [rbp-1568], rdx
	mov rax, qword [rbp-1568]
	mov rbx, 2345
	mov qword [rbp-1232], rbx
	mov rbx, qword [rbp-1232]
	imul rbx
	mov qword [rbp-1136], rax
	mov rax, qword [rbp-1136]
	cdq
	mov rbx, 1234
	mov qword [rbp-3280], rbx
	mov rbx, qword [rbp-3280]
	idiv rbx
	mov qword [rbp-1328], rdx
	mov rax, qword [rbp-1328]
	mov rbx, 2345
	mov qword [rbp-1424], rbx
	mov rbx, qword [rbp-1424]
	imul rbx
	mov qword [rbp-2048], rax
	mov rax, qword [rbp-2048]
	cdq
	mov rbx, 1234
	mov qword [rbp-2280], rbx
	mov rbx, qword [rbp-2280]
	idiv rbx
	mov qword [rbp-944], rdx
	mov rax, qword [rbp-944]
	mov rbx, 2345
	mov qword [rbp-1360], rbx
	mov rbx, qword [rbp-1360]
	imul rbx
	mov qword [rbp-816], rax
	mov rax, qword [rbp-816]
	cdq
	mov rbx, 1234
	mov qword [rbp-2224], rbx
	mov rbx, qword [rbp-2224]
	idiv rbx
	mov qword [rbp-2232], rdx
	mov rax, qword [rbp-2232]
	mov rbx, 2345
	mov qword [rbp-648], rbx
	mov rbx, qword [rbp-648]
	imul rbx
	mov qword [rbp-1640], rax
	mov rax, qword [rbp-1640]
	cdq
	mov rbx, 1234
	mov qword [rbp-1184], rbx
	mov rbx, qword [rbp-1184]
	idiv rbx
	mov qword [rbp-272], rdx
	mov rax, qword [rbp-272]
	mov rbx, 2345
	mov qword [rbp-376], rbx
	mov rbx, qword [rbp-376]
	imul rbx
	mov qword [rbp-2312], rax
	mov rax, qword [rbp-2312]
	cdq
	mov rbx, 1234
	mov qword [rbp-1800], rbx
	mov rbx, qword [rbp-1800]
	idiv rbx
	mov qword [rbp-1824], rdx
	mov rax, qword [rbp-1824]
	mov rbx, 2345
	mov qword [rbp-128], rbx
	mov rbx, qword [rbp-128]
	imul rbx
	mov qword [rbp-488], rax
	mov rax, qword [rbp-488]
	cdq
	mov rbx, 1234
	mov qword [rbp-2720], rbx
	mov rbx, qword [rbp-2720]
	idiv rbx
	mov qword [rbp-2144], rdx
	mov rax, qword [rbp-2144]
	mov rbx, 2345
	mov qword [rbp-384], rbx
	mov rbx, qword [rbp-384]
	imul rbx
	mov qword [rbp-208], rax
	mov rax, qword [rbp-208]
	cdq
	mov rbx, 1234
	mov qword [rbp-3216], rbx
	mov rbx, qword [rbp-3216]
	idiv rbx
	mov qword [rbp-336], rdx
	mov rax, qword [rbp-336]
	mov rbx, 2345
	mov qword [rbp-912], rbx
	mov rbx, qword [rbp-912]
	imul rbx
	mov qword [rbp-2160], rax
	mov rax, qword [rbp-2160]
	cdq
	mov rbx, 1234
	mov qword [rbp-768], rbx
	mov rbx, qword [rbp-768]
	idiv rbx
	mov qword [rbp-80], rdx
	mov rax, qword [rbp-80]
	mov rbx, 2345
	mov qword [rbp-2536], rbx
	mov rbx, qword [rbp-2536]
	imul rbx
	mov qword [rbp-1936], rax
	mov rax, qword [rbp-1936]
	cdq
	mov rbx, 1234
	mov qword [rbp-2216], rbx
	mov rbx, qword [rbp-2216]
	idiv rbx
	mov qword [rbp-232], rdx
	mov rax, qword [rbp-232]
	mov rbx, 2345
	mov qword [rbp-2080], rbx
	mov rbx, qword [rbp-2080]
	imul rbx
	mov qword [rbp-104], rax
	mov rax, qword [rbp-104]
	cdq
	mov rbx, 1234
	mov qword [rbp-3120], rbx
	mov rbx, qword [rbp-3120]
	idiv rbx
	mov qword [rbp-2944], rdx
	mov rax, qword [rbp-2944]
	mov rbx, 2345
	mov qword [rbp-2512], rbx
	mov rbx, qword [rbp-2512]
	imul rbx
	mov qword [rbp-3304], rax
	mov rax, qword [rbp-3304]
	cdq
	mov rbx, 1234
	mov qword [rbp-2816], rbx
	mov rbx, qword [rbp-2816]
	idiv rbx
	mov qword [rbp-1368], rdx
	mov rax, qword [rbp-1368]
	mov rbx, 2345
	mov qword [rbp-656], rbx
	mov rbx, qword [rbp-656]
	imul rbx
	mov qword [rbp-2904], rax
	mov rax, qword [rbp-2904]
	cdq
	mov rbx, 1234
	mov qword [rbp-456], rbx
	mov rbx, qword [rbp-456]
	idiv rbx
	mov qword [rbp-1504], rdx
	mov rax, qword [rbp-1504]
	mov rbx, 2345
	mov qword [rbp-480], rbx
	mov rbx, qword [rbp-480]
	imul rbx
	mov qword [rbp-752], rax
	mov rax, qword [rbp-752]
	cdq
	mov rbx, 1234
	mov qword [rbp-1392], rbx
	mov rbx, qword [rbp-1392]
	idiv rbx
	mov qword [rbp-840], rdx
	mov rax, qword [rbp-840]
	mov rbx, 2345
	mov qword [rbp-928], rbx
	mov rbx, qword [rbp-928]
	imul rbx
	mov qword [rbp-1024], rax
	mov rax, qword [rbp-1024]
	cdq
	mov rbx, 1234
	mov qword [rbp-112], rbx
	mov rbx, qword [rbp-112]
	idiv rbx
	mov qword [rbp-1192], rdx
	mov rax, qword [rbp-1192]
	mov rbx, 2345
	mov qword [rbp-1448], rbx
	mov rbx, qword [rbp-1448]
	imul rbx
	mov qword [rbp-1584], rax
	mov rax, qword [rbp-1584]
	cdq
	mov rbx, 1234
	mov qword [rbp-3328], rbx
	mov rbx, qword [rbp-3328]
	idiv rbx
	mov qword [rbp-2896], rdx
	mov rax, qword [rbp-2896]
	mov rbx, 2345
	mov qword [rbp-1632], rbx
	mov rbx, qword [rbp-1632]
	imul rbx
	mov qword [rbp-1512], rax
	mov rax, qword [rbp-1512]
	cdq
	mov rbx, 1234
	mov qword [rbp-1920], rbx
	mov rbx, qword [rbp-1920]
	idiv rbx
	mov qword [rbp-3240], rdx
	mov rax, qword [rbp-3240]
	mov rbx, 2345
	mov qword [rbp-2000], rbx
	mov rbx, qword [rbp-2000]
	imul rbx
	mov qword [rbp-1112], rax
	mov rax, qword [rbp-1112]
	cdq
	mov rbx, 1234
	mov qword [rbp-2328], rbx
	mov rbx, qword [rbp-2328]
	idiv rbx
	mov qword [rbp-784], rdx
	mov rax, qword [rbp-784]
	mov rbx, 2345
	mov qword [rbp-3208], rbx
	mov rbx, qword [rbp-3208]
	imul rbx
	mov qword [rbp-2184], rax
	mov rax, qword [rbp-2184]
	cdq
	mov rbx, 1234
	mov qword [rbp-2368], rbx
	mov rbx, qword [rbp-2368]
	idiv rbx
	mov qword [rbp-3224], rdx
	mov rax, qword [rbp-3224]
	mov rbx, 2345
	mov qword [rbp-168], rbx
	mov rbx, qword [rbp-168]
	imul rbx
	mov qword [rbp-1240], rax
	mov rax, qword [rbp-1240]
	cdq
	mov rbx, 1234
	mov qword [rbp-1128], rbx
	mov rbx, qword [rbp-1128]
	idiv rbx
	mov qword [rbp-3088], rdx
	mov rax, qword [rbp-3088]
	mov rbx, 2345
	mov qword [rbp-1408], rbx
	mov rbx, qword [rbp-1408]
	imul rbx
	mov qword [rbp-664], rax
	mov rax, qword [rbp-664]
	cdq
	mov rbx, 1234
	mov qword [rbp-464], rbx
	mov rbx, qword [rbp-464]
	idiv rbx
	mov qword [rbp-176], rdx
	mov rax, qword [rbp-176]
	mov rbx, 2345
	mov qword [rbp-184], rbx
	mov rbx, qword [rbp-184]
	imul rbx
	mov qword [rbp-392], rax
	mov rax, qword [rbp-392]
	cdq
	mov rbx, 1234
	mov qword [rbp-3000], rbx
	mov rbx, qword [rbp-3000]
	idiv rbx
	mov qword [rbp-1928], rdx
	mov rax, qword [rbp-1928]
	mov rbx, 2345
	mov qword [rbp-1744], rbx
	mov rbx, qword [rbp-1744]
	imul rbx
	mov qword [rbp-3072], rax
	mov rax, qword [rbp-3072]
	cdq
	mov rbx, 1234
	mov qword [rbp-544], rbx
	mov rbx, qword [rbp-544]
	idiv rbx
	mov qword [rbp-88], rdx
	mov rax, qword [rbp-88]
	mov rbx, 2345
	mov qword [rbp-2824], rbx
	mov rbx, qword [rbp-2824]
	imul rbx
	mov qword [rbp-608], rax
	mov rax, qword [rbp-608]
	cdq
	mov rbx, 1234
	mov qword [rbp-2760], rbx
	mov rbx, qword [rbp-2760]
	idiv rbx
	mov qword [rbp-2968], rdx
	mov rax, qword [rbp-2968]
	mov rbx, 2345
	mov qword [rbp-136], rbx
	mov rbx, qword [rbp-136]
	imul rbx
	mov qword [rbp-688], rax
	mov rax, qword [rbp-688]
	cdq
	mov rbx, 1234
	mov qword [rbp-2264], rbx
	mov rbx, qword [rbp-2264]
	idiv rbx
	mov qword [rbp-696], rdx
	mov rax, qword [rbp-696]
	mov rbx, 2345
	mov qword [rbp-1672], rbx
	mov rbx, qword [rbp-1672]
	imul rbx
	mov qword [rbp-792], rax
	mov rax, qword [rbp-792]
	cdq
	mov rbx, 1234
	mov qword [rbp-2984], rbx
	mov rbx, qword [rbp-2984]
	idiv rbx
	mov qword [rbp-1944], rdx
	mov rax, qword [rbp-1944]
	mov rbx, 2345
	mov qword [rbp-2832], rbx
	mov rbx, qword [rbp-2832]
	imul rbx
	mov qword [rbp-1544], rax
	mov rax, qword [rbp-1544]
	cdq
	mov rbx, 1234
	mov qword [rbp-72], rbx
	mov rbx, qword [rbp-72]
	idiv rbx
	mov qword [rbp-2096], rdx
	mov rax, qword [rbp-2096]
	mov rbx, 2345
	mov qword [rbp-1536], rbx
	mov rbx, qword [rbp-1536]
	imul rbx
	mov qword [rbp-2064], rax
	mov rax, qword [rbp-2064]
	cdq
	mov rbx, 1234
	mov qword [rbp-2120], rbx
	mov rbx, qword [rbp-2120]
	idiv rbx
	mov qword [rbp-2624], rdx
	mov rax, qword [rbp-2624]
	mov rbx, 2345
	mov qword [rbp-408], rbx
	mov rbx, qword [rbp-408]
	imul rbx
	mov qword [rbp-920], rax
	mov rax, qword [rbp-920]
	cdq
	mov rbx, 1234
	mov qword [rbp-2376], rbx
	mov rbx, qword [rbp-2376]
	idiv rbx
	mov qword [rbp-2344], rdx
	mov rax, qword [rbp-2344]
	mov rbx, 2345
	mov qword [rbp-808], rbx
	mov rbx, qword [rbp-808]
	imul rbx
	mov qword [rbp-2552], rax
	mov rax, qword [rbp-2552]
	cdq
	mov rbx, 1234
	mov qword [rbp-672], rbx
	mov rbx, qword [rbp-672]
	idiv rbx
	mov qword [rbp-3096], rdx
	mov rax, qword [rbp-3096]
	mov rbx, 2345
	mov qword [rbp-1256], rbx
	mov rbx, qword [rbp-1256]
	imul rbx
	mov qword [rbp-1296], rax
	mov rax, qword [rbp-1296]
	cdq
	mov rbx, 1234
	mov qword [rbp-1560], rbx
	mov rbx, qword [rbp-1560]
	idiv rbx
	mov qword [rbp-2784], rdx
	mov rax, qword [rbp-2784]
	mov rbx, 2345
	mov qword [rbp-1736], rbx
	mov rbx, qword [rbp-1736]
	imul rbx
	mov qword [rbp-1336], rax
	mov rax, qword [rbp-1336]
	cdq
	mov rbx, 1234
	mov qword [rbp-1056], rbx
	mov rbx, qword [rbp-1056]
	idiv rbx
	mov qword [rbp-1688], rdx
	mov rax, qword [rbp-1688]
	mov rbx, 2345
	mov qword [rbp-1376], rbx
	mov rbx, qword [rbp-1376]
	imul rbx
	mov qword [rbp-1832], rax
	mov rax, qword [rbp-1832]
	cdq
	mov rbx, 1234
	mov qword [rbp-1576], rbx
	mov rbx, qword [rbp-1576]
	idiv rbx
	mov qword [rbp-1912], rdx
	mov rax, qword [rbp-1912]
	mov rbx, 2345
	mov qword [rbp-2248], rbx
	mov rbx, qword [rbp-2248]
	imul rbx
	mov qword [rbp-1592], rax
	mov rax, qword [rbp-1592]
	cdq
	mov rbx, 1234
	mov qword [rbp-3032], rbx
	mov rbx, qword [rbp-3032]
	idiv rbx
	mov qword [rbp-1352], rdx
	mov rax, qword [rbp-1352]
	mov rbx, 2345
	mov qword [rbp-1384], rbx
	mov rbx, qword [rbp-1384]
	imul rbx
	mov qword [rbp-1648], rax
	mov rax, qword [rbp-1648]
	cdq
	mov rbx, 1234
	mov qword [rbp-864], rbx
	mov rbx, qword [rbp-864]
	idiv rbx
	mov qword [rbp-496], rdx
	mov rax, qword [rbp-496]
	mov rbx, 2345
	mov qword [rbp-216], rbx
	mov rbx, qword [rbp-216]
	imul rbx
	mov qword [rbp-1680], rax
	mov rax, qword [rbp-1680]
	cdq
	mov rbx, 1234
	mov qword [rbp-2664], rbx
	mov rbx, qword [rbp-2664]
	idiv rbx
	mov qword [rbp-3128], rdx
	mov rax, qword [rbp-3128]
	cdq
	mov rbx, 11
	mov qword [rbp-2848], rbx
	mov rbx, qword [rbp-2848]
	idiv rbx
	mov qword [rbp-2104], rdx
	mov rbx, qword [rbp-2104]
	mov r10, qword [rbp-1768]
	add r10, rbx
	mov qword [rbp-1768], r10
	l_141:
	mov rbx, qword [rbp-1656]
	inc rbx
	mov qword [rbp-1656], rbx
	jmp l_133
	l_131:
	mov r10, qword [rbp-1080]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-144], rbx
	mov rbx, qword [rbp-144]
	mov r10, qword [rbx + 16]
	mov qword [rbp-2568], r10
	mov r10, qword [rbp-2568]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-1248], rbx
	mov rbx, qword [rbp-1248]
	mov r10, qword [rbx + 16]
	mov qword [rbp-1992], r10
	mov r10, qword [rbp-1992]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-568], rbx
	mov rbx, qword [rbp-568]
	mov r10, qword [rbx + 16]
	mov qword [rbp-96], r10
	mov r10, qword [rbp-96]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-1456], rbx
	mov r10, qword [rbp-1456]
	mov rbx, qword [r10 + 16]
	mov qword [rbp-2920], rbx
	mov rbx, qword [rbp-2920]
	mov r10, qword [rbx + 8]
	mov qword [rbp-1432], r10
	mov rbx, 123
	mov qword [rbp-2384], rbx
	mov rbx, qword [rbp-2384]
	mov r10, qword [rbp-1656]
	add rbx, r10
	mov qword [rbp-2384], rbx
	mov rbx, qword [rbp-2384]
	mov r10, qword [rbp-1432]
	mov qword [r10 + 16], rbx
	mov r10, qword [rbp-1080]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-592], rbx
	mov r10, qword [rbp-592]
	mov rbx, qword [r10 + 16]
	mov qword [rbp-2616], rbx
	mov rbx, qword [rbp-2616]
	mov r10, qword [rbx + 8]
	mov qword [rbp-2152], r10
	mov r10, qword [rbp-2152]
	mov rbx, qword [r10 + 16]
	mov qword [rbp-200], rbx
	mov rbx, qword [rbp-200]
	mov r10, qword [rbx + 8]
	mov qword [rbp-736], r10
	mov r10, qword [rbp-736]
	mov rbx, qword [r10 + 16]
	mov qword [rbp-1464], rbx
	mov r10, qword [rbp-1464]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-2192], rbx
	mov rbx, qword [rbp-2192]
	mov r10, qword [rbx + 16]
	mov qword [rbp-1040], r10
	mov rbx, qword [rbp-1040]
	mov r10, qword [rbx + 8]
	mov qword [rbp-256], r10
	mov rbx, qword [rbp-1768]
	mov r10, qword [rbp-256]
	add rbx, qword [r10 + 16]
	mov qword [rbp-1768], rbx
	l_142:
	mov rbx, qword [rbp-1656]
	inc rbx
	mov qword [rbp-1656], rbx
	jmp l_130
	l_128:
	mov rbx, 2
	mov qword [rbp-48], rbx
	mov rbx, qword [rbp-48]
	mov r10, qword [rbp-2680]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-2680], r10
	mov rdi, qword [rbp-2680]
	call malloc 
	mov qword [rbp-1624], rax
	mov rbx, qword [rbp-48]
	mov r10, qword [rbp-1624]
	mov qword [r10], rbx
	l_143:
	mov rbx, qword [rbp-48]
	cmp rbx, 0
	jg l_144
	l_145:
	mov rbx, qword [rbp-1896]
	mov r10, qword [rbp-448]
	mov r11, qword [rbp-1624]
	mov qword [r10 + rbx * 8], r11
	mov rbx, qword [rbp-1896]
	dec rbx
	mov qword [rbp-1896], rbx
	jmp l_127
	l_144:
	mov rbx, 2
	mov qword [rbp-3112], rbx
	mov rbx, qword [rbp-1696]
	mov r10, qword [rbp-3112]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-1696], rbx
	mov rdi, qword [rbp-1696]
	call malloc 
	mov qword [rbp-2464], rax
	mov rbx, qword [rbp-2464]
	mov r10, qword [rbp-3112]
	mov qword [rbx], r10
	l_146:
	mov rbx, qword [rbp-3112]
	cmp rbx, 0
	jg l_147
	l_148:
	mov rbx, qword [rbp-2464]
	mov r10, qword [rbp-48]
	mov r11, qword [rbp-1624]
	mov qword [r11 + r10 * 8], rbx
	mov rbx, qword [rbp-48]
	dec rbx
	mov qword [rbp-48], rbx
	jmp l_143
	l_147:
	mov rbx, 2
	mov qword [rbp-1960], rbx
	mov rbx, qword [rbp-2792]
	mov r10, qword [rbp-1960]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-2792], rbx
	mov rdi, qword [rbp-2792]
	call malloc 
	mov qword [rbp-2752], rax
	mov rbx, qword [rbp-2752]
	mov r10, qword [rbp-1960]
	mov qword [rbx], r10
	l_149:
	mov rbx, qword [rbp-1960]
	cmp rbx, 0
	jg l_150
	l_151:
	mov rbx, qword [rbp-2752]
	mov r10, qword [rbp-2464]
	mov r11, qword [rbp-3112]
	mov qword [r10 + r11 * 8], rbx
	mov rbx, qword [rbp-3112]
	dec rbx
	mov qword [rbp-3112], rbx
	jmp l_146
	l_150:
	mov rbx, 2
	mov qword [rbp-1304], rbx
	mov rbx, qword [rbp-1304]
	mov r10, qword [rbp-1784]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-1784], r10
	mov rdi, qword [rbp-1784]
	call malloc 
	mov qword [rbp-632], rax
	mov rbx, qword [rbp-1304]
	mov r10, qword [rbp-632]
	mov qword [r10], rbx
	l_152:
	mov rbx, qword [rbp-1304]
	cmp rbx, 0
	jg l_153
	l_154:
	mov rbx, qword [rbp-2752]
	mov r10, qword [rbp-632]
	mov r11, qword [rbp-1960]
	mov qword [rbx + r11 * 8], r10
	mov rbx, qword [rbp-1960]
	dec rbx
	mov qword [rbp-1960], rbx
	jmp l_149
	l_153:
	mov rbx, 2
	mov qword [rbp-3232], rbx
	mov rbx, qword [rbp-3144]
	mov r10, qword [rbp-3232]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-3144], rbx
	mov rdi, qword [rbp-3144]
	call malloc 
	mov qword [rbp-2408], rax
	mov rbx, qword [rbp-2408]
	mov r10, qword [rbp-3232]
	mov qword [rbx], r10
	l_155:
	mov rbx, qword [rbp-3232]
	cmp rbx, 0
	jg l_156
	l_157:
	mov rbx, qword [rbp-632]
	mov r10, qword [rbp-1304]
	mov r11, qword [rbp-2408]
	mov qword [rbx + r10 * 8], r11
	mov rbx, qword [rbp-1304]
	dec rbx
	mov qword [rbp-1304], rbx
	jmp l_152
	l_156:
	mov rbx, 2
	mov qword [rbp-1904], rbx
	mov rbx, qword [rbp-1808]
	mov r10, qword [rbp-1904]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-1808], rbx
	mov rdi, qword [rbp-1808]
	call malloc 
	mov qword [rbp-152], rax
	mov rbx, qword [rbp-152]
	mov r10, qword [rbp-1904]
	mov qword [rbx], r10
	l_158:
	mov rbx, qword [rbp-1904]
	cmp rbx, 0
	jg l_159
	l_160:
	mov rbx, qword [rbp-152]
	mov r10, qword [rbp-2408]
	mov r11, qword [rbp-3232]
	mov qword [r10 + r11 * 8], rbx
	mov rbx, qword [rbp-3232]
	dec rbx
	mov qword [rbp-3232], rbx
	jmp l_155
	l_159:
	mov rbx, 2
	mov qword [rbp-24], rbx
	mov rbx, qword [rbp-24]
	mov r10, qword [rbp-800]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-800], r10
	mov rdi, qword [rbp-800]
	call malloc 
	mov qword [rbp-1528], rax
	mov rbx, qword [rbp-1528]
	mov r10, qword [rbp-24]
	mov qword [rbx], r10
	l_161:
	mov rbx, qword [rbp-24]
	cmp rbx, 0
	jg l_162
	l_163:
	mov rbx, qword [rbp-152]
	mov r10, qword [rbp-1904]
	mov r11, qword [rbp-1528]
	mov qword [rbx + r10 * 8], r11
	mov rbx, qword [rbp-1904]
	dec rbx
	mov qword [rbp-1904], rbx
	jmp l_158
	l_162:
	mov rbx, 2
	mov qword [rbp-2608], rbx
	mov rbx, qword [rbp-1088]
	mov r10, qword [rbp-2608]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-1088], rbx
	mov rdi, qword [rbp-1088]
	call malloc 
	mov qword [rbp-2496], rax
	mov rbx, qword [rbp-2496]
	mov r10, qword [rbp-2608]
	mov qword [rbx], r10
	l_164:
	mov rbx, qword [rbp-2608]
	cmp rbx, 0
	jg l_165
	l_166:
	mov rbx, qword [rbp-2496]
	mov r10, qword [rbp-1528]
	mov r11, qword [rbp-24]
	mov qword [r10 + r11 * 8], rbx
	mov rbx, qword [rbp-24]
	dec rbx
	mov qword [rbp-24], rbx
	jmp l_161
	l_165:
	mov rbx, 2
	mov qword [rbp-904], rbx
	mov rbx, qword [rbp-904]
	mov r10, qword [rbp-1320]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-1320], r10
	mov rdi, qword [rbp-1320]
	call malloc 
	mov qword [rbp-640], rax
	mov rbx, qword [rbp-640]
	mov r10, qword [rbp-904]
	mov qword [rbx], r10
	l_167:
	mov rbx, qword [rbp-904]
	cmp rbx, 0
	jg l_168
	l_169:
	mov rbx, qword [rbp-640]
	mov r10, qword [rbp-2496]
	mov r11, qword [rbp-2608]
	mov qword [r10 + r11 * 8], rbx
	mov rbx, qword [rbp-2608]
	dec rbx
	mov qword [rbp-2608], rbx
	jmp l_164
	l_168:
	mov rbx, qword [rbp-640]
	mov r10, qword [rbp-904]
	mov qword [rbx + r10 * 8], 0
	mov rbx, qword [rbp-904]
	dec rbx
	mov qword [rbp-904], rbx
	jmp l_167
__init:
	l_170:
	push rbp
	mov rbp, rsp
	sub rsp, 128
	mov rbx, 100000
	mov qword [g_6], rbx
	mov rbx, qword [g_6]
	mov r10, rbx
	mov qword [rbp-56], r10
	mov rbx, qword [rbp-56]
	mov r10, qword [rbp-8]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-8], r10
	mov rdi, qword [rbp-8]
	call malloc 
	mov qword [rbp-32], rax
	mov rbx, qword [rbp-56]
	mov r10, qword [rbp-32]
	mov qword [r10], rbx
	l_171:
	mov rbx, qword [rbp-56]
	cmp rbx, 0
	jg l_172
	l_173:
	mov rbx, qword [rbp-32]
	mov r10, rbx
	mov qword [g_2], r10
	mov rbx, qword [g_6]
	mov r10, rbx
	mov qword [rbp-24], r10
	mov rbx, qword [rbp-16]
	mov r10, qword [rbp-24]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-16], rbx
	mov rdi, qword [rbp-16]
	call malloc 
	mov qword [rbp-40], rax
	mov rbx, qword [rbp-40]
	mov r10, qword [rbp-24]
	mov qword [rbx], r10
	l_174:
	mov rbx, qword [rbp-24]
	cmp rbx, 0
	jg l_175
	l_176:
	mov rbx, qword [rbp-40]
	mov r10, rbx
	mov qword [g_1], r10
	mov rbx, qword [g_6]
	mov r10, rbx
	mov qword [rbp-96], r10
	mov rbx, qword [rbp-120]
	mov r10, qword [rbp-96]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-120], rbx
	mov rdi, qword [rbp-120]
	call malloc 
	mov qword [rbp-72], rax
	mov rbx, qword [rbp-72]
	mov r10, qword [rbp-96]
	mov qword [rbx], r10
	l_177:
	mov rbx, qword [rbp-96]
	cmp rbx, 0
	jg l_178
	l_179:
	mov r10, qword [rbp-72]
	mov rbx, r10
	mov qword [g_4], rbx
	mov rbx, qword [g_6]
	mov r10, rbx
	mov qword [rbp-80], r10
	mov rbx, qword [rbp-48]
	mov r10, qword [rbp-80]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-48], rbx
	mov rdi, qword [rbp-48]
	call malloc 
	mov qword [rbp-64], rax
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-64]
	mov qword [r10], rbx
	l_180:
	mov rbx, qword [rbp-80]
	cmp rbx, 0
	jg l_181
	l_182:
	mov rbx, qword [rbp-64]
	mov r10, rbx
	mov qword [g_3], r10
	mov rbx, qword [g_6]
	mov r10, rbx
	mov qword [rbp-104], r10
	mov rbx, qword [rbp-104]
	mov r10, qword [rbp-112]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-112], r10
	mov rdi, qword [rbp-112]
	call malloc 
	mov qword [rbp-88], rax
	mov rbx, qword [rbp-88]
	mov r10, qword [rbp-104]
	mov qword [rbx], r10
	l_183:
	mov rbx, qword [rbp-104]
	cmp rbx, 0
	jg l_184
	l_185:
	mov rbx, qword [rbp-88]
	mov r10, rbx
	mov qword [g_5], r10
	call _main_User_Defined_fihriaifhiahidsafans 
	leave 
	ret
	l_184:
	mov rbx, qword [rbp-88]
	mov r10, qword [rbp-104]
	mov qword [rbx + r10 * 8], 0
	mov rbx, qword [rbp-104]
	dec rbx
	mov qword [rbp-104], rbx
	jmp l_183
	l_181:
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-64]
	mov qword [r10 + rbx * 8], 0
	mov rbx, qword [rbp-80]
	dec rbx
	mov qword [rbp-80], rbx
	jmp l_180
	l_178:
	mov rbx, qword [rbp-72]
	mov r10, qword [rbp-96]
	mov qword [rbx + r10 * 8], 0
	mov rbx, qword [rbp-96]
	dec rbx
	mov qword [rbp-96], rbx
	jmp l_177
	l_175:
	mov rbx, qword [rbp-40]
	mov r10, qword [rbp-24]
	mov qword [rbx + r10 * 8], 0
	mov rbx, qword [rbp-24]
	dec rbx
	mov qword [rbp-24], rbx
	jmp l_174
	l_172:
	mov rbx, qword [rbp-32]
	mov r10, qword [rbp-56]
	mov qword [rbx + r10 * 8], 0
	mov rbx, qword [rbp-56]
	dec rbx
	mov qword [rbp-56], rbx
	jmp l_171
	 section .data
g_6:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_0:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_2:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_1:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_4:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_3:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_5:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_7:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_8:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_9:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_10:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_11:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_12:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_13:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_14:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_15:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_16:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_17:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_18:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_19:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_20:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H

