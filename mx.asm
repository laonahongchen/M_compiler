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
_origin_User_Defined_fihriaifhiahidsafans:
	l_0:
	push rbp
	mov rbp, rsp
	sub rsp, 80
	mov qword [rbp-72], rdi
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [rbp-72]
	mov r10, rbx
	mov qword [rbp-80], r10
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-40]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-40], r10
	mov rdi, qword [rbp-40]
	call malloc 
	mov qword [rbp-8], rax
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-80]
	mov qword [rbx], r10
	l_1:
	mov rbx, qword [rbp-80]
	cmp rbx, 0
	jg l_2
	l_3:
	mov rbx, qword [rbp-8]
	mov r10, rbx
	mov qword [g_1], r10
	mov rbx, 0
	mov qword [g_2], rbx
	l_4:
	mov rbx, qword [rbp-72]
	mov r10, qword [g_2]
	cmp r10, rbx
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
	mov r10, qword [rbp-72]
	mov rbx, r10
	mov qword [rbp-56], rbx
	mov rbx, qword [rbp-56]
	mov r10, qword [rbp-64]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-64], r10
	mov rdi, qword [rbp-64]
	call malloc 
	mov qword [rbp-16], rax
	mov rbx, qword [rbp-56]
	mov r10, qword [rbp-16]
	mov qword [r10], rbx
	l_8:
	mov rbx, qword [rbp-56]
	cmp rbx, 0
	jg l_9
	l_10:
	mov rbx, qword [g_1]
	mov r10, qword [rbp-16]
	mov r11, qword [g_2]
	mov qword [rbx + r11 * 8 + 8], r10
	mov rbx, 0
	mov qword [g_0], rbx
	l_11:
	mov rbx, qword [rbp-72]
	mov r10, qword [g_0]
	cmp r10, rbx
	jl l_12
	l_13:
	l_14:
	mov r10, qword [g_2]
	mov rbx, r10
	mov qword [rbp-24], rbx
	mov rbx, qword [g_2]
	inc rbx
	mov qword [g_2], rbx
	jmp l_4
	l_12:
	mov rbx, qword [g_1]
	mov r10, qword [g_2]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-32], r11
	mov rbx, qword [rbp-32]
	mov r10, qword [g_0]
	mov qword [rbx + r10 * 8 + 8], 0
	l_15:
	mov r10, qword [g_0]
	mov rbx, r10
	mov qword [rbp-48], rbx
	mov rbx, qword [g_0]
	inc rbx
	mov qword [g_0], rbx
	jmp l_11
	l_9:
	mov rbx, qword [rbp-56]
	mov r10, qword [rbp-16]
	mov qword [r10 + rbx * 8], 0
	mov rbx, qword [rbp-56]
	dec rbx
	mov qword [rbp-56], rbx
	jmp l_8
	l_2:
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-80]
	mov qword [rbx + r10 * 8], 0
	mov rbx, qword [rbp-80]
	dec rbx
	mov qword [rbp-80], rbx
	jmp l_1
_search_User_Defined_fihriaifhiahidsafans:
	l_16:
	push rbp
	mov rbp, rsp
	sub rsp, 96
	mov qword [rbp-72], rdi
	mov qword [rbp-48], rsi
	mov qword [rbp-8], rdx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [rbp-48]
	cmp rbx, 0
	jg l_17
	l_18:
	mov rbx, qword [rbp-48]
	cmp rbx, 0
	jl l_17
	l_19:
	mov rbx, qword [rbp-72]
	cmp rbx, 0
	je l_17
	l_20:
	mov r10, qword [rbp-72]
	mov rbx, r10
	mov qword [rbp-16], rbx
	mov rbx, qword [rbp-16]
	sub rbx, 1
	mov qword [rbp-16], rbx
	mov rbx, qword [g_1]
	mov r10, qword [rbp-16]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-24], r11
	mov r10, qword [rbp-72]
	mov rbx, r10
	mov qword [rbp-32], rbx
	mov rbx, qword [rbp-32]
	sub rbx, 1
	mov qword [rbp-32], rbx
	mov rbx, qword [g_1]
	mov r11, qword [rbp-32]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-80], r10
	mov r10, qword [rbp-24]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-88], rbx
	mov rbx, qword [rbp-88]
	mov r10, qword [rbp-80]
	add rbx, qword [r10 + 16]
	mov qword [rbp-88], rbx
	mov rbx, qword [rbp-72]
	mov r10, rbx
	mov qword [rbp-64], r10
	mov rbx, qword [rbp-64]
	sub rbx, 1
	mov qword [rbp-64], rbx
	mov rbx, qword [g_1]
	mov r11, qword [rbp-64]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-40], r10
	mov rbx, qword [rbp-88]
	mov r10, rbx
	mov qword [rbp-56], r10
	mov rbx, qword [rbp-40]
	mov r10, qword [rbp-56]
	add r10, qword [rbx + 24]
	mov qword [rbp-56], r10
	mov rbx, qword [rbp-56]
	cmp rbx, 15
	je l_17
	jmp l_21
	l_17:
	l_21:
	mov rax, 0
	l_22:
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	leave 
	ret
_main_User_Defined_fihriaifhiahidsafans:
	l_23:
	push rbp
	mov rbp, rsp
	sub rsp, 32
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_3]
	mov qword [rbx + 8], 0
	mov rdi, 3
	call _origin_User_Defined_fihriaifhiahidsafans 
	mov rdx, 0
	mov rsi, 0
	mov rdi, 0
	call _search_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-8], rax
	mov r10, qword [g_3]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-16], rbx
	mov rdi, qword [rbp-16]
	call __toString 
	mov qword [rbp-24], rax
	mov rdi, qword [rbp-24]
	call __println 
	mov rax, 0
	l_24:
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	leave 
	ret
__init:
	l_25:
	push rbp
	mov rbp, rsp
	sub rsp, 48
	mov rbx, 10
	mov qword [rbp-8], rbx
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-32]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-32], r10
	mov rdi, qword [rbp-32]
	call malloc 
	mov qword [rbp-48], rax
	mov rbx, qword [rbp-48]
	mov r10, qword [rbp-8]
	mov qword [rbx], r10
	l_26:
	mov rbx, qword [rbp-8]
	cmp rbx, 0
	jg l_27
	l_28:
	mov rbx, qword [rbp-48]
	mov r10, rbx
	mov qword [g_4], r10
	mov rbx, 1
	mov qword [rbp-24], rbx
	mov rbx, qword [rbp-40]
	mov r10, qword [rbp-24]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-40], rbx
	mov rdi, qword [rbp-40]
	call malloc 
	mov qword [rbp-16], rax
	mov rbx, qword [rbp-16]
	mov r10, qword [rbp-24]
	mov qword [rbx], r10
	l_29:
	mov rbx, qword [rbp-24]
	cmp rbx, 0
	jg l_30
	l_31:
	mov rbx, qword [rbp-16]
	mov r10, rbx
	mov qword [g_3], r10
	call _main_User_Defined_fihriaifhiahidsafans 
	leave 
	ret
	l_30:
	mov rbx, qword [rbp-16]
	mov r10, qword [rbp-24]
	mov qword [rbx + r10 * 8], 0
	mov rbx, qword [rbp-24]
	dec rbx
	mov qword [rbp-24], rbx
	jmp l_29
	l_27:
	mov rbx, qword [rbp-48]
	mov r10, qword [rbp-8]
	mov qword [rbx + r10 * 8], 0
	mov rbx, qword [rbp-8]
	dec rbx
	mov qword [rbp-8], rbx
	jmp l_26
	 section .data
g_1:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_4:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_3:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_2:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_0:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H

