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
_hex2int_User_Defined_fihriaifhiahidsafans:
	l_0:
	push rbp
	mov rbp, rsp
	sub rsp, 176
	mov qword [rbp-112], rdi
	mov rbx, 0
	mov qword [rbp-88], rbx
	mov rbx, 0
	mov qword [rbp-8], rbx
	l_1:
	mov r10, qword [rbp-112]
	mov rbx, r10
	mov qword [rbp-128], rbx
	mov rdi, qword [rbp-128]
	call __string_length 
	mov qword [rbp-56], rax
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-56]
	cmp rbx, r10
	jl l_2
	l_3:
	mov rax, qword [rbp-88]
	jmp l_4
	l_2:
	mov rbx, qword [rbp-112]
	mov r10, rbx
	mov qword [rbp-48], r10
	mov rsi, qword [rbp-8]
	mov rdi, qword [rbp-48]
	call __string_ord 
	mov qword [rbp-24], rax
	mov r10, qword [rbp-24]
	mov rbx, r10
	mov qword [rbp-160], rbx
	mov rbx, qword [rbp-160]
	cmp rbx, 48
	jl l_5
	l_6:
	mov rbx, qword [rbp-160]
	cmp rbx, 57
	jg l_5
	jmp l_7
	l_5:
	mov rbx, qword [rbp-160]
	cmp rbx, 65
	jl l_8
	l_9:
	mov rbx, qword [rbp-160]
	cmp rbx, 70
	jg l_8
	jmp l_10
	l_8:
	mov rbx, qword [rbp-160]
	cmp rbx, 97
	jl l_11
	l_12:
	mov rbx, qword [rbp-160]
	cmp rbx, 102
	jg l_11
	jmp l_13
	l_11:
	mov rax, 0
	l_4:
	leave 
	ret
	l_13:
	mov rax, qword [rbp-88]
	mov rbx, 16
	mov qword [rbp-104], rbx
	mov rbx, qword [rbp-104]
	imul rbx
	mov qword [rbp-144], rax
	mov rbx, qword [rbp-144]
	mov r10, rbx
	mov qword [rbp-120], r10
	mov rbx, qword [rbp-160]
	mov r10, qword [rbp-120]
	add r10, rbx
	mov qword [rbp-120], r10
	mov rbx, qword [rbp-120]
	mov r10, rbx
	mov qword [rbp-72], r10
	mov rbx, qword [rbp-72]
	sub rbx, 97
	mov qword [rbp-72], rbx
	mov r10, qword [rbp-72]
	mov rbx, r10
	mov qword [rbp-80], rbx
	mov rbx, qword [rbp-80]
	add rbx, 10
	mov qword [rbp-80], rbx
	mov r10, qword [rbp-80]
	mov rbx, r10
	mov qword [rbp-88], rbx
	l_14:
	jmp l_15
	l_10:
	mov rax, qword [rbp-88]
	mov rbx, 16
	mov qword [rbp-40], rbx
	mov rbx, qword [rbp-40]
	imul rbx
	mov qword [rbp-136], rax
	mov rbx, qword [rbp-136]
	mov r10, rbx
	mov qword [rbp-64], r10
	mov rbx, qword [rbp-160]
	mov r10, qword [rbp-64]
	add r10, rbx
	mov qword [rbp-64], r10
	mov rbx, qword [rbp-64]
	mov r10, rbx
	mov qword [rbp-168], r10
	mov rbx, qword [rbp-168]
	sub rbx, 65
	mov qword [rbp-168], rbx
	mov r10, qword [rbp-168]
	mov rbx, r10
	mov qword [rbp-176], rbx
	mov rbx, qword [rbp-176]
	add rbx, 10
	mov qword [rbp-176], rbx
	mov r10, qword [rbp-176]
	mov rbx, r10
	mov qword [rbp-88], rbx
	l_15:
	jmp l_16
	l_7:
	mov rax, qword [rbp-88]
	mov rbx, 16
	mov qword [rbp-152], rbx
	mov rbx, qword [rbp-152]
	imul rbx
	mov qword [rbp-96], rax
	mov rbx, qword [rbp-96]
	mov r10, rbx
	mov qword [rbp-32], r10
	mov rbx, qword [rbp-160]
	mov r10, qword [rbp-32]
	add r10, rbx
	mov qword [rbp-32], r10
	mov rbx, qword [rbp-32]
	mov r10, rbx
	mov qword [rbp-16], r10
	mov rbx, qword [rbp-16]
	sub rbx, 48
	mov qword [rbp-16], rbx
	mov r10, qword [rbp-16]
	mov rbx, r10
	mov qword [rbp-88], rbx
	l_16:
	l_17:
	mov rbx, qword [rbp-8]
	inc rbx
	mov qword [rbp-8], rbx
	jmp l_1
_int2chr_User_Defined_fihriaifhiahidsafans:
	l_18:
	push rbp
	mov rbp, rsp
	sub rsp, 48
	mov qword [rbp-8], rdi
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [rbp-8]
	cmp rbx, 32
	jl l_19
	l_20:
	mov rbx, qword [rbp-8]
	cmp rbx, 126
	jg l_19
	jmp l_21
	l_19:
	mov rax, g_1
	jmp l_22
	l_21:
	mov r10, qword [g_0]
	mov rbx, r10
	mov qword [rbp-16], rbx
	mov rbx, qword [rbp-8]
	mov r10, rbx
	mov qword [rbp-24], r10
	mov rbx, qword [rbp-24]
	sub rbx, 32
	mov qword [rbp-24], rbx
	mov rbx, qword [rbp-8]
	mov r10, rbx
	mov qword [rbp-32], r10
	mov rbx, qword [rbp-32]
	sub rbx, 32
	mov qword [rbp-32], rbx
	mov rdx, qword [rbp-32]
	mov rsi, qword [rbp-24]
	mov rdi, qword [rbp-16]
	call __string_substring 
	mov qword [rbp-40], rax
	mov rax, qword [rbp-40]
	l_22:
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	leave 
	ret
_toStringHex_User_Defined_fihriaifhiahidsafans:
	l_23:
	push rbp
	mov rbp, rsp
	sub rsp, 112
	mov qword [rbp-40], rdi
	mov rbx, g_2
	mov qword [rbp-88], rbx
	mov rbx, 28
	mov qword [rbp-16], rbx
	l_24:
	mov rbx, qword [rbp-16]
	cmp rbx, 0
	jge l_25
	l_26:
	mov rax, qword [rbp-88]
	l_27:
	leave 
	ret
	l_25:
	mov rbx, qword [rbp-40]
	mov r10, rbx
	mov qword [rbp-8], r10
	mov rcx, qword [rbp-16]
	mov rbx, qword [rbp-8]
	sar rbx, cl
	mov qword [rbp-8], rbx
	mov rbx, qword [rbp-8]
	mov r10, rbx
	mov qword [rbp-80], r10
	mov rbx, qword [rbp-80]
	and rbx, 15
	mov qword [rbp-80], rbx
	mov rbx, qword [rbp-80]
	mov r10, rbx
	mov qword [rbp-96], r10
	mov rbx, qword [rbp-96]
	cmp rbx, 10
	jl l_28
	l_29:
	mov rbx, 65
	mov qword [rbp-72], rbx
	mov rbx, qword [rbp-72]
	mov r10, qword [rbp-96]
	add rbx, r10
	mov qword [rbp-72], rbx
	mov rbx, qword [rbp-72]
	mov r10, rbx
	mov qword [rbp-24], r10
	mov rbx, qword [rbp-24]
	sub rbx, 10
	mov qword [rbp-24], rbx
	mov rdi, qword [rbp-24]
	call _int2chr_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-104], rax
	mov rsi, qword [rbp-104]
	mov rdi, qword [rbp-88]
	call __stringConcat 
	mov qword [rbp-64], rax
	mov r10, qword [rbp-64]
	mov rbx, r10
	mov qword [rbp-88], rbx
	jmp l_30
	l_28:
	mov rbx, 48
	mov qword [rbp-56], rbx
	mov rbx, qword [rbp-56]
	mov r10, qword [rbp-96]
	add rbx, r10
	mov qword [rbp-56], rbx
	mov rdi, qword [rbp-56]
	call _int2chr_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-32], rax
	mov rsi, qword [rbp-32]
	mov rdi, qword [rbp-88]
	call __stringConcat 
	mov qword [rbp-48], rax
	mov r10, qword [rbp-48]
	mov rbx, r10
	mov qword [rbp-88], rbx
	l_30:
	l_31:
	mov rbx, qword [rbp-16]
	sub rbx, 4
	mov qword [rbp-16], rbx
	jmp l_24
_rotate_left_User_Defined_fihriaifhiahidsafans:
	l_32:
	push rbp
	mov rbp, rsp
	sub rsp, 192
	mov qword [rbp-104], rdi
	mov qword [rbp-24], rsi
	mov rbx, qword [rbp-24]
	cmp rbx, 1
	je l_33
	l_34:
	mov rbx, qword [rbp-24]
	cmp rbx, 31
	je l_35
	l_36:
	mov rbx, 32
	mov qword [rbp-40], rbx
	mov rbx, qword [rbp-24]
	mov r10, qword [rbp-40]
	sub r10, rbx
	mov qword [rbp-40], r10
	mov rbx, 1
	mov qword [rbp-80], rbx
	mov rcx, qword [rbp-40]
	mov rbx, qword [rbp-80]
	sal rbx, cl
	mov qword [rbp-80], rbx
	mov rbx, qword [rbp-80]
	mov r10, rbx
	mov qword [rbp-16], r10
	mov rbx, qword [rbp-16]
	sub rbx, 1
	mov qword [rbp-16], rbx
	mov r10, qword [rbp-104]
	mov rbx, r10
	mov qword [rbp-88], rbx
	mov rbx, qword [rbp-88]
	mov r10, qword [rbp-16]
	and rbx, r10
	mov qword [rbp-88], rbx
	mov rbx, qword [rbp-88]
	mov r10, rbx
	mov qword [rbp-120], r10
	mov rcx, qword [rbp-24]
	mov rbx, qword [rbp-120]
	sal rbx, cl
	mov qword [rbp-120], rbx
	mov rbx, 32
	mov qword [rbp-48], rbx
	mov rbx, qword [rbp-24]
	mov r10, qword [rbp-48]
	sub r10, rbx
	mov qword [rbp-48], r10
	mov r10, qword [rbp-104]
	mov rbx, r10
	mov qword [rbp-64], rbx
	mov rcx, qword [rbp-48]
	mov rbx, qword [rbp-64]
	sar rbx, cl
	mov qword [rbp-64], rbx
	mov rbx, 1
	mov qword [rbp-128], rbx
	mov rcx, qword [rbp-24]
	mov rbx, qword [rbp-128]
	sal rbx, cl
	mov qword [rbp-128], rbx
	mov rbx, qword [rbp-128]
	mov r10, rbx
	mov qword [rbp-136], r10
	mov rbx, qword [rbp-136]
	sub rbx, 1
	mov qword [rbp-136], rbx
	mov r10, qword [rbp-64]
	mov rbx, r10
	mov qword [rbp-32], rbx
	mov rbx, qword [rbp-32]
	mov r10, qword [rbp-136]
	and rbx, r10
	mov qword [rbp-32], rbx
	mov r10, qword [rbp-120]
	mov rbx, r10
	mov qword [rbp-168], rbx
	mov rbx, qword [rbp-32]
	mov r10, qword [rbp-168]
	or r10, rbx
	mov qword [rbp-168], r10
	mov rax, qword [rbp-168]
	jmp l_37
	l_35:
	mov r10, qword [rbp-104]
	mov rbx, r10
	mov qword [rbp-144], rbx
	mov rbx, qword [rbp-144]
	and rbx, 1
	mov qword [rbp-144], rbx
	mov rbx, qword [rbp-144]
	mov r10, rbx
	mov qword [rbp-112], r10
	mov rcx, 31
	mov rbx, qword [rbp-112]
	sal rbx, cl
	mov qword [rbp-112], rbx
	mov r10, qword [rbp-104]
	mov rbx, r10
	mov qword [rbp-72], rbx
	mov rcx, 1
	mov rbx, qword [rbp-72]
	sar rbx, cl
	mov qword [rbp-72], rbx
	mov r10, qword [rbp-72]
	mov rbx, r10
	mov qword [rbp-56], rbx
	mov rbx, qword [rbp-56]
	and rbx, 2147483647
	mov qword [rbp-56], rbx
	mov r10, qword [rbp-112]
	mov rbx, r10
	mov qword [rbp-152], rbx
	mov rbx, qword [rbp-152]
	mov r10, qword [rbp-56]
	or rbx, r10
	mov qword [rbp-152], rbx
	mov rax, qword [rbp-152]
	jmp l_37
	l_33:
	mov r10, qword [rbp-104]
	mov rbx, r10
	mov qword [rbp-160], rbx
	mov rbx, qword [rbp-160]
	and rbx, 2147483647
	mov qword [rbp-160], rbx
	mov r10, qword [rbp-160]
	mov rbx, r10
	mov qword [rbp-96], rbx
	mov rcx, 1
	mov rbx, qword [rbp-96]
	sal rbx, cl
	mov qword [rbp-96], rbx
	mov r10, qword [rbp-104]
	mov rbx, r10
	mov qword [rbp-184], rbx
	mov rcx, 31
	mov rbx, qword [rbp-184]
	sar rbx, cl
	mov qword [rbp-184], rbx
	mov r10, qword [rbp-184]
	mov rbx, r10
	mov qword [rbp-8], rbx
	mov rbx, qword [rbp-8]
	and rbx, 1
	mov qword [rbp-8], rbx
	mov rbx, qword [rbp-96]
	mov r10, rbx
	mov qword [rbp-176], r10
	mov rbx, qword [rbp-176]
	mov r10, qword [rbp-8]
	or rbx, r10
	mov qword [rbp-176], rbx
	mov rax, qword [rbp-176]
	l_37:
	leave 
	ret
_add_User_Defined_fihriaifhiahidsafans:
	l_38:
	push rbp
	mov rbp, rsp
	sub rsp, 144
	mov qword [rbp-56], rdi
	mov qword [rbp-128], rsi
	mov r10, qword [rbp-56]
	mov rbx, r10
	mov qword [rbp-8], rbx
	mov rbx, qword [rbp-8]
	and rbx, 65535
	mov qword [rbp-8], rbx
	mov r10, qword [rbp-128]
	mov rbx, r10
	mov qword [rbp-96], rbx
	mov rbx, qword [rbp-96]
	and rbx, 65535
	mov qword [rbp-96], rbx
	mov rbx, qword [rbp-8]
	mov r10, rbx
	mov qword [rbp-24], r10
	mov rbx, qword [rbp-96]
	mov r10, qword [rbp-24]
	add r10, rbx
	mov qword [rbp-24], r10
	mov r10, qword [rbp-24]
	mov rbx, r10
	mov qword [rbp-72], rbx
	mov rbx, qword [rbp-56]
	mov r10, rbx
	mov qword [rbp-64], r10
	mov rcx, 16
	mov rbx, qword [rbp-64]
	sar rbx, cl
	mov qword [rbp-64], rbx
	mov r10, qword [rbp-64]
	mov rbx, r10
	mov qword [rbp-48], rbx
	mov rbx, qword [rbp-48]
	and rbx, 65535
	mov qword [rbp-48], rbx
	mov rbx, qword [rbp-128]
	mov r10, rbx
	mov qword [rbp-80], r10
	mov rcx, 16
	mov rbx, qword [rbp-80]
	sar rbx, cl
	mov qword [rbp-80], rbx
	mov r10, qword [rbp-80]
	mov rbx, r10
	mov qword [rbp-88], rbx
	mov rbx, qword [rbp-88]
	and rbx, 65535
	mov qword [rbp-88], rbx
	mov r10, qword [rbp-48]
	mov rbx, r10
	mov qword [rbp-32], rbx
	mov rbx, qword [rbp-32]
	mov r10, qword [rbp-88]
	add rbx, r10
	mov qword [rbp-32], rbx
	mov rbx, qword [rbp-72]
	mov r10, rbx
	mov qword [rbp-104], r10
	mov rcx, 16
	mov rbx, qword [rbp-104]
	sar rbx, cl
	mov qword [rbp-104], rbx
	mov rbx, qword [rbp-32]
	mov r10, rbx
	mov qword [rbp-16], r10
	mov rbx, qword [rbp-16]
	mov r10, qword [rbp-104]
	add rbx, r10
	mov qword [rbp-16], rbx
	mov r10, qword [rbp-16]
	mov rbx, r10
	mov qword [rbp-112], rbx
	mov rbx, qword [rbp-112]
	and rbx, 65535
	mov qword [rbp-112], rbx
	mov r10, qword [rbp-112]
	mov rbx, r10
	mov qword [rbp-136], rbx
	mov rbx, qword [rbp-136]
	mov r10, rbx
	mov qword [rbp-144], r10
	mov rcx, 16
	mov rbx, qword [rbp-144]
	sal rbx, cl
	mov qword [rbp-144], rbx
	mov r10, qword [rbp-72]
	mov rbx, r10
	mov qword [rbp-120], rbx
	mov rbx, qword [rbp-120]
	and rbx, 65535
	mov qword [rbp-120], rbx
	mov rbx, qword [rbp-144]
	mov r10, rbx
	mov qword [rbp-40], r10
	mov rbx, qword [rbp-120]
	mov r10, qword [rbp-40]
	or r10, rbx
	mov qword [rbp-40], r10
	mov rax, qword [rbp-40]
	l_39:
	leave 
	ret
_lohi_User_Defined_fihriaifhiahidsafans:
	l_40:
	push rbp
	mov rbp, rsp
	sub rsp, 32
	mov qword [rbp-8], rdi
	mov qword [rbp-32], rsi
	mov rbx, qword [rbp-32]
	mov r10, rbx
	mov qword [rbp-16], r10
	mov rcx, 16
	mov rbx, qword [rbp-16]
	sal rbx, cl
	mov qword [rbp-16], rbx
	mov rbx, qword [rbp-8]
	mov r10, rbx
	mov qword [rbp-24], r10
	mov rbx, qword [rbp-24]
	mov r10, qword [rbp-16]
	or rbx, r10
	mov qword [rbp-24], rbx
	mov rax, qword [rbp-24]
	l_41:
	leave 
	ret
_sha1_User_Defined_fihriaifhiahidsafans:
	l_42:
	push rbp
	mov rbp, rsp
	sub rsp, 944
	mov qword [rbp-704], rdi
	mov qword [rbp-848], rsi
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rbx, qword [g_5]
	mov qword [g_5], rbx
	mov r10, qword [rbp-848]
	mov rbx, r10
	mov qword [rbp-336], rbx
	mov rbx, qword [rbp-336]
	add rbx, 64
	mov qword [rbp-336], rbx
	mov rbx, qword [rbp-336]
	mov r10, rbx
	mov qword [rbp-536], r10
	mov rbx, qword [rbp-536]
	sub rbx, 56
	mov qword [rbp-536], rbx
	mov rax, qword [rbp-536]
	cdq
	mov rbx, 64
	mov qword [rbp-784], rbx
	mov rbx, qword [rbp-784]
	idiv rbx
	mov qword [rbp-544], rax
	mov rbx, qword [rbp-544]
	mov r10, rbx
	mov qword [rbp-440], r10
	mov rbx, qword [rbp-440]
	add rbx, 1
	mov qword [rbp-440], rbx
	mov r10, qword [rbp-440]
	mov rbx, r10
	mov qword [rbp-528], rbx
	mov rbx, qword [g_3]
	mov r10, qword [rbp-528]
	cmp r10, rbx
	jg l_43
	l_44:
	mov rbx, 0
	mov qword [rbp-728], rbx
	l_45:
	mov rbx, qword [rbp-528]
	mov r10, qword [rbp-728]
	cmp r10, rbx
	jl l_46
	l_47:
	mov rbx, 0
	mov qword [rbp-728], rbx
	l_48:
	mov rbx, qword [rbp-848]
	mov r10, qword [rbp-728]
	cmp r10, rbx
	jl l_49
	l_50:
	mov rax, qword [rbp-728]
	cdq
	mov rbx, 64
	mov qword [rbp-872], rbx
	mov rbx, qword [rbp-872]
	idiv rbx
	mov qword [rbp-664], rax
	mov rax, qword [rbp-728]
	cdq
	mov rbx, 64
	mov qword [rbp-184], rbx
	mov rbx, qword [rbp-184]
	idiv rbx
	mov qword [rbp-552], rdx
	mov rax, qword [rbp-552]
	cdq
	mov rbx, 4
	mov qword [rbp-456], rbx
	mov rbx, qword [rbp-456]
	idiv rbx
	mov qword [rbp-328], rax
	mov rbx, qword [g_5]
	mov r10, qword [rbp-664]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-120], r11
	mov rax, qword [rbp-728]
	cdq
	mov rbx, 64
	mov qword [rbp-672], rbx
	mov rbx, qword [rbp-672]
	idiv rbx
	mov qword [rbp-8], rax
	mov rax, qword [rbp-728]
	cdq
	mov rbx, 64
	mov qword [rbp-608], rbx
	mov rbx, qword [rbp-608]
	idiv rbx
	mov qword [rbp-288], rdx
	mov rax, qword [rbp-288]
	cdq
	mov rbx, 4
	mov qword [rbp-568], rbx
	mov rbx, qword [rbp-568]
	idiv rbx
	mov qword [rbp-752], rax
	mov r10, qword [g_5]
	mov r11, qword [rbp-8]
	mov rbx, qword [r10 + r11 * 8 + 8]
	mov qword [rbp-936], rbx
	mov rax, qword [rbp-728]
	cdq
	mov rbx, 4
	mov qword [rbp-480], rbx
	mov rbx, qword [rbp-480]
	idiv rbx
	mov qword [rbp-616], rdx
	mov rbx, 3
	mov qword [rbp-368], rbx
	mov rbx, qword [rbp-368]
	mov r10, qword [rbp-616]
	sub rbx, r10
	mov qword [rbp-368], rbx
	mov rax, qword [rbp-368]
	mov rbx, 8
	mov qword [rbp-136], rbx
	mov rbx, qword [rbp-136]
	imul rbx
	mov qword [rbp-592], rax
	mov rbx, 128
	mov qword [rbp-432], rbx
	mov rcx, qword [rbp-592]
	mov rbx, qword [rbp-432]
	sal rbx, cl
	mov qword [rbp-432], rbx
	mov rbx, qword [rbp-936]
	mov r10, qword [rbp-752]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-272], r11
	mov rbx, qword [rbp-432]
	mov r10, qword [rbp-272]
	or r10, rbx
	mov qword [rbp-272], r10
	mov rbx, qword [rbp-272]
	mov r10, qword [rbp-328]
	mov r11, qword [rbp-120]
	mov qword [r11 + r10 * 8 + 8], rbx
	mov rbx, qword [rbp-528]
	mov r10, rbx
	mov qword [rbp-232], r10
	mov rbx, qword [rbp-232]
	sub rbx, 1
	mov qword [rbp-232], rbx
	mov rbx, qword [g_5]
	mov r10, qword [rbp-232]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-808], r11
	mov r10, qword [rbp-848]
	mov rbx, r10
	mov qword [rbp-192], rbx
	mov rcx, 3
	mov rbx, qword [rbp-192]
	sal rbx, cl
	mov qword [rbp-192], rbx
	mov rbx, qword [rbp-192]
	mov r10, qword [rbp-808]
	mov qword [r10 + 128], rbx
	mov r10, qword [rbp-528]
	mov rbx, r10
	mov qword [rbp-584], rbx
	mov rbx, qword [rbp-584]
	sub rbx, 1
	mov qword [rbp-584], rbx
	mov rbx, qword [rbp-584]
	mov r10, qword [g_5]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-600], r11
	mov rbx, qword [rbp-848]
	mov r10, rbx
	mov qword [rbp-840], r10
	mov rcx, 29
	mov rbx, qword [rbp-840]
	sar rbx, cl
	mov qword [rbp-840], rbx
	mov rbx, qword [rbp-840]
	mov r10, rbx
	mov qword [rbp-320], r10
	mov rbx, qword [rbp-320]
	and rbx, 7
	mov qword [rbp-320], rbx
	mov rbx, qword [rbp-600]
	mov r10, qword [rbp-320]
	mov qword [rbx + 120], r10
	mov rbx, 1732584193
	mov qword [rbp-640], rbx
	mov rsi, 61389
	mov rdi, 43913
	call _lohi_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-224], rax
	mov rbx, qword [rbp-224]
	mov r10, rbx
	mov qword [rbp-488], r10
	mov rsi, 39098
	mov rdi, 56574
	call _lohi_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-176], rax
	mov rbx, qword [rbp-176]
	mov r10, rbx
	mov qword [rbp-816], r10
	mov rbx, 271733878
	mov qword [rbp-888], rbx
	mov rsi, 50130
	mov rdi, 57840
	call _lohi_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-504], rax
	mov rbx, qword [rbp-504]
	mov r10, rbx
	mov qword [rbp-464], r10
	mov rbx, 0
	mov qword [rbp-728], rbx
	l_51:
	mov rbx, qword [rbp-528]
	mov r10, qword [rbp-728]
	cmp r10, rbx
	jl l_52
	l_53:
	mov rbx, qword [rbp-640]
	mov r10, qword [g_4]
	mov qword [r10 + 8], rbx
	mov rbx, qword [rbp-488]
	mov r10, qword [g_4]
	mov qword [r10 + 16], rbx
	mov rbx, qword [g_4]
	mov r10, qword [rbp-816]
	mov qword [rbx + 24], r10
	mov rbx, qword [g_4]
	mov r10, qword [rbp-888]
	mov qword [rbx + 32], r10
	mov rbx, qword [g_4]
	mov r10, qword [rbp-464]
	mov qword [rbx + 40], r10
	mov rax, qword [g_4]
	jmp l_54
	l_52:
	mov rbx, 16
	mov qword [rbp-376], rbx
	l_55:
	mov rbx, qword [rbp-376]
	cmp rbx, 80
	jl l_56
	l_57:
	mov rbx, qword [rbp-640]
	mov r10, rbx
	mov qword [rbp-296], r10
	mov r10, qword [rbp-488]
	mov rbx, r10
	mov qword [rbp-648], rbx
	mov rbx, qword [rbp-816]
	mov r10, rbx
	mov qword [rbp-520], r10
	mov r10, qword [rbp-888]
	mov rbx, r10
	mov qword [rbp-360], rbx
	mov r10, qword [rbp-464]
	mov rbx, r10
	mov qword [rbp-856], rbx
	mov rbx, 0
	mov qword [rbp-376], rbx
	l_58:
	mov rbx, qword [rbp-376]
	cmp rbx, 80
	jl l_59
	l_60:
	mov rsi, qword [rbp-296]
	mov rdi, qword [rbp-640]
	call _add_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-736], rax
	mov r10, qword [rbp-736]
	mov rbx, r10
	mov qword [rbp-640], rbx
	mov rsi, qword [rbp-648]
	mov rdi, qword [rbp-488]
	call _add_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-104], rax
	mov rbx, qword [rbp-104]
	mov r10, rbx
	mov qword [rbp-488], r10
	mov rsi, qword [rbp-520]
	mov rdi, qword [rbp-816]
	call _add_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-680], rax
	mov r10, qword [rbp-680]
	mov rbx, r10
	mov qword [rbp-816], rbx
	mov rsi, qword [rbp-360]
	mov rdi, qword [rbp-888]
	call _add_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-656], rax
	mov rbx, qword [rbp-656]
	mov r10, rbx
	mov qword [rbp-888], r10
	mov rsi, qword [rbp-856]
	mov rdi, qword [rbp-464]
	call _add_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-32], rax
	mov rbx, qword [rbp-32]
	mov r10, rbx
	mov qword [rbp-464], r10
	l_61:
	mov rbx, qword [rbp-728]
	inc rbx
	mov qword [rbp-728], rbx
	jmp l_51
	l_59:
	mov rbx, qword [rbp-376]
	cmp rbx, 20
	jl l_62
	l_63:
	mov rbx, qword [rbp-376]
	cmp rbx, 40
	jl l_64
	l_65:
	mov rbx, qword [rbp-376]
	cmp rbx, 60
	jl l_66
	l_67:
	mov rbx, qword [rbp-648]
	mov r10, rbx
	mov qword [rbp-312], r10
	mov rbx, qword [rbp-312]
	mov r10, qword [rbp-520]
	xor rbx, r10
	mov qword [rbp-312], rbx
	mov rbx, qword [rbp-312]
	mov r10, rbx
	mov qword [rbp-512], r10
	mov rbx, qword [rbp-360]
	mov r10, qword [rbp-512]
	xor r10, rbx
	mov qword [rbp-512], r10
	mov rbx, qword [rbp-512]
	mov r10, rbx
	mov qword [rbp-152], r10
	mov rsi, 51810
	mov rdi, 49622
	call _lohi_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-168], rax
	mov rbx, qword [rbp-168]
	mov r10, rbx
	mov qword [rbp-256], r10
	jmp l_68
	l_66:
	mov rbx, qword [rbp-648]
	mov r10, rbx
	mov qword [rbp-712], r10
	mov rbx, qword [rbp-712]
	mov r10, qword [rbp-520]
	and rbx, r10
	mov qword [rbp-712], rbx
	mov rbx, qword [rbp-648]
	mov r10, rbx
	mov qword [rbp-896], r10
	mov rbx, qword [rbp-360]
	mov r10, qword [rbp-896]
	and r10, rbx
	mov qword [rbp-896], r10
	mov rbx, qword [rbp-712]
	mov r10, rbx
	mov qword [rbp-392], r10
	mov rbx, qword [rbp-896]
	mov r10, qword [rbp-392]
	or r10, rbx
	mov qword [rbp-392], r10
	mov r10, qword [rbp-520]
	mov rbx, r10
	mov qword [rbp-632], rbx
	mov rbx, qword [rbp-632]
	mov r10, qword [rbp-360]
	and rbx, r10
	mov qword [rbp-632], rbx
	mov r10, qword [rbp-392]
	mov rbx, r10
	mov qword [rbp-576], rbx
	mov rbx, qword [rbp-632]
	mov r10, qword [rbp-576]
	or r10, rbx
	mov qword [rbp-576], r10
	mov rbx, qword [rbp-576]
	mov r10, rbx
	mov qword [rbp-152], r10
	mov rsi, 36635
	mov rdi, 48348
	call _lohi_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-696], rax
	mov r10, qword [rbp-696]
	mov rbx, r10
	mov qword [rbp-256], rbx
	l_68:
	jmp l_69
	l_64:
	mov rbx, qword [rbp-648]
	mov r10, rbx
	mov qword [rbp-760], r10
	mov rbx, qword [rbp-760]
	mov r10, qword [rbp-520]
	xor rbx, r10
	mov qword [rbp-760], rbx
	mov rbx, qword [rbp-760]
	mov r10, rbx
	mov qword [rbp-776], r10
	mov rbx, qword [rbp-360]
	mov r10, qword [rbp-776]
	xor r10, rbx
	mov qword [rbp-776], r10
	mov r10, qword [rbp-776]
	mov rbx, r10
	mov qword [rbp-152], rbx
	mov rbx, 1859775393
	mov qword [rbp-256], rbx
	l_69:
	jmp l_70
	l_62:
	mov rbx, qword [rbp-648]
	mov r10, rbx
	mov qword [rbp-720], r10
	mov rbx, qword [rbp-720]
	mov r10, qword [rbp-520]
	and rbx, r10
	mov qword [rbp-720], rbx
	mov rbx, qword [rbp-648]
	mov r10, rbx
	mov qword [rbp-16], r10
	mov rbx, qword [rbp-16]
	not rbx
	mov qword [rbp-16], rbx
	mov rbx, qword [rbp-16]
	mov r10, rbx
	mov qword [rbp-496], r10
	mov rbx, qword [rbp-360]
	mov r10, qword [rbp-496]
	and r10, rbx
	mov qword [rbp-496], r10
	mov rbx, qword [rbp-720]
	mov r10, rbx
	mov qword [rbp-64], r10
	mov rbx, qword [rbp-496]
	mov r10, qword [rbp-64]
	or r10, rbx
	mov qword [rbp-64], r10
	mov r10, qword [rbp-64]
	mov rbx, r10
	mov qword [rbp-152], rbx
	mov rbx, 1518500249
	mov qword [rbp-256], rbx
	l_70:
	mov rsi, 5
	mov rdi, qword [rbp-296]
	call _rotate_left_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-56], rax
	mov rsi, qword [rbp-856]
	mov rdi, qword [rbp-56]
	call _add_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-160], rax
	mov rsi, qword [rbp-256]
	mov rdi, qword [rbp-152]
	call _add_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-400], rax
	mov rsi, qword [rbp-400]
	mov rdi, qword [rbp-160]
	call _add_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-864], rax
	mov rbx, qword [g_5]
	mov r10, qword [rbp-728]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-240], r11
	mov r10, qword [rbp-376]
	mov r11, qword [rbp-240]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-880], rbx
	mov rsi, qword [rbp-880]
	mov rdi, qword [rbp-864]
	call _add_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-448], rax
	mov rbx, qword [rbp-448]
	mov r10, rbx
	mov qword [rbp-264], r10
	mov rbx, qword [rbp-360]
	mov r10, rbx
	mov qword [rbp-856], r10
	mov r10, qword [rbp-520]
	mov rbx, r10
	mov qword [rbp-360], rbx
	mov rsi, 30
	mov rdi, qword [rbp-648]
	call _rotate_left_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-72], rax
	mov rbx, qword [rbp-72]
	mov r10, rbx
	mov qword [rbp-520], r10
	mov r10, qword [rbp-296]
	mov rbx, r10
	mov qword [rbp-648], rbx
	mov rbx, qword [rbp-264]
	mov r10, rbx
	mov qword [rbp-296], r10
	l_71:
	mov rbx, qword [rbp-376]
	inc rbx
	mov qword [rbp-376], rbx
	jmp l_58
	l_56:
	mov r10, qword [g_5]
	mov r11, qword [rbp-728]
	mov rbx, qword [r10 + r11 * 8 + 8]
	mov qword [rbp-768], rbx
	mov r10, qword [rbp-376]
	mov rbx, r10
	mov qword [rbp-352], rbx
	mov rbx, qword [rbp-352]
	sub rbx, 3
	mov qword [rbp-352], rbx
	mov r10, qword [g_5]
	mov r11, qword [rbp-728]
	mov rbx, qword [r10 + r11 * 8 + 8]
	mov qword [rbp-304], rbx
	mov r10, qword [rbp-376]
	mov rbx, r10
	mov qword [rbp-48], rbx
	mov rbx, qword [rbp-48]
	sub rbx, 8
	mov qword [rbp-48], rbx
	mov r10, qword [g_5]
	mov r11, qword [rbp-728]
	mov rbx, qword [r10 + r11 * 8 + 8]
	mov qword [rbp-792], rbx
	mov rbx, qword [rbp-304]
	mov r11, qword [rbp-352]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-144], r10
	mov rbx, qword [rbp-792]
	mov r10, qword [rbp-48]
	mov r11, qword [rbp-144]
	xor r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-144], r11
	mov rbx, qword [rbp-376]
	mov r10, rbx
	mov qword [rbp-384], r10
	mov rbx, qword [rbp-384]
	sub rbx, 14
	mov qword [rbp-384], rbx
	mov rbx, qword [g_5]
	mov r10, qword [rbp-728]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-200], r11
	mov rbx, qword [rbp-144]
	mov r10, rbx
	mov qword [rbp-112], r10
	mov rbx, qword [rbp-112]
	mov r10, qword [rbp-200]
	mov r11, qword [rbp-384]
	xor rbx, qword [r10 + r11 * 8 + 8]
	mov qword [rbp-112], rbx
	mov r10, qword [rbp-376]
	mov rbx, r10
	mov qword [rbp-88], rbx
	mov rbx, qword [rbp-88]
	sub rbx, 16
	mov qword [rbp-88], rbx
	mov rbx, qword [g_5]
	mov r10, qword [rbp-728]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-128], r11
	mov rbx, qword [rbp-112]
	mov r10, rbx
	mov qword [rbp-688], r10
	mov rbx, qword [rbp-88]
	mov r10, qword [rbp-688]
	mov r11, qword [rbp-128]
	xor r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-688], r10
	mov rsi, 1
	mov rdi, qword [rbp-688]
	call _rotate_left_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-560], rax
	mov rbx, qword [rbp-768]
	mov r10, qword [rbp-560]
	mov r11, qword [rbp-376]
	mov qword [rbx + r11 * 8 + 8], r10
	l_72:
	mov rbx, qword [rbp-376]
	inc rbx
	mov qword [rbp-376], rbx
	jmp l_55
	l_49:
	mov rax, qword [rbp-728]
	cdq
	mov rbx, 64
	mov qword [rbp-472], rbx
	mov rbx, qword [rbp-472]
	idiv rbx
	mov qword [rbp-928], rax
	mov rax, qword [rbp-728]
	cdq
	mov rbx, 64
	mov qword [rbp-800], rbx
	mov rbx, qword [rbp-800]
	idiv rbx
	mov qword [rbp-832], rdx
	mov rax, qword [rbp-832]
	cdq
	mov rbx, 4
	mov qword [rbp-40], rbx
	mov rbx, qword [rbp-40]
	idiv rbx
	mov qword [rbp-24], rax
	mov r10, qword [rbp-928]
	mov r11, qword [g_5]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-424], rbx
	mov rax, qword [rbp-728]
	cdq
	mov rbx, 64
	mov qword [rbp-216], rbx
	mov rbx, qword [rbp-216]
	idiv rbx
	mov qword [rbp-344], rax
	mov rax, qword [rbp-728]
	cdq
	mov rbx, 64
	mov qword [rbp-912], rbx
	mov rbx, qword [rbp-912]
	idiv rbx
	mov qword [rbp-824], rdx
	mov rax, qword [rbp-824]
	cdq
	mov rbx, 4
	mov qword [rbp-80], rbx
	mov rbx, qword [rbp-80]
	idiv rbx
	mov qword [rbp-280], rax
	mov rbx, qword [g_5]
	mov r10, qword [rbp-344]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-624], r11
	mov rax, qword [rbp-728]
	cdq
	mov rbx, 4
	mov qword [rbp-744], rbx
	mov rbx, qword [rbp-744]
	idiv rbx
	mov qword [rbp-208], rdx
	mov rbx, 3
	mov qword [rbp-904], rbx
	mov rbx, qword [rbp-904]
	mov r10, qword [rbp-208]
	sub rbx, r10
	mov qword [rbp-904], rbx
	mov rax, qword [rbp-904]
	mov rbx, 8
	mov qword [rbp-416], rbx
	mov rbx, qword [rbp-416]
	imul rbx
	mov qword [rbp-920], rax
	mov r10, qword [rbp-728]
	mov r11, qword [rbp-704]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-96], rbx
	mov rcx, qword [rbp-920]
	mov rbx, qword [rbp-96]
	sal rbx, cl
	mov qword [rbp-96], rbx
	mov r10, qword [rbp-280]
	mov r11, qword [rbp-624]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-248], rbx
	mov rbx, qword [rbp-248]
	mov r10, qword [rbp-96]
	or rbx, r10
	mov qword [rbp-248], rbx
	mov rbx, qword [rbp-424]
	mov r10, qword [rbp-24]
	mov r11, qword [rbp-248]
	mov qword [rbx + r10 * 8 + 8], r11
	l_73:
	mov rbx, qword [rbp-728]
	inc rbx
	mov qword [rbp-728], rbx
	jmp l_48
	l_46:
	mov rbx, 0
	mov qword [rbp-376], rbx
	l_74:
	mov rbx, qword [rbp-376]
	cmp rbx, 80
	jl l_75
	l_76:
	l_77:
	mov rbx, qword [rbp-728]
	inc rbx
	mov qword [rbp-728], rbx
	jmp l_45
	l_75:
	mov r10, qword [g_5]
	mov r11, qword [rbp-728]
	mov rbx, qword [r10 + r11 * 8 + 8]
	mov qword [rbp-408], rbx
	mov rbx, qword [rbp-408]
	mov r10, qword [rbp-376]
	mov qword [rbx + r10 * 8 + 8], 0
	l_78:
	mov rbx, qword [rbp-376]
	inc rbx
	mov qword [rbp-376], rbx
	jmp l_74
	l_43:
	mov rdi, g_6
	call __println 
	mov rax, 0
	l_54:
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rbx, qword [g_5]
	mov qword [g_5], rbx
	leave 
	ret
_computeSHA1_User_Defined_fihriaifhiahidsafans:
	l_79:
	push rbp
	mov rbp, rsp
	sub rsp, 112
	mov qword [rbp-96], rdi
	mov rbx, qword [g_7]
	mov qword [g_7], rbx
	mov rbx, 0
	mov qword [rbp-16], rbx
	l_80:
	mov rbx, qword [rbp-96]
	mov r10, rbx
	mov qword [rbp-64], r10
	mov rdi, qword [rbp-64]
	call __string_length 
	mov qword [rbp-72], rax
	mov rbx, qword [rbp-72]
	mov r10, qword [rbp-16]
	cmp r10, rbx
	jl l_81
	l_82:
	mov rbx, qword [rbp-96]
	mov r10, rbx
	mov qword [rbp-48], r10
	mov rdi, qword [rbp-48]
	call __string_length 
	mov qword [rbp-8], rax
	mov rsi, qword [rbp-8]
	mov rdi, qword [g_7]
	call _sha1_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-104], rax
	mov rbx, qword [rbp-104]
	mov r10, rbx
	mov qword [rbp-80], r10
	mov rbx, 0
	mov qword [rbp-16], rbx
	l_83:
	mov rbx, qword [rbp-80]
	mov r10, rbx
	mov qword [rbp-40], r10
	mov rbx, qword [rbp-40]
	mov r10, qword [rbp-16]
	cmp r10, qword [rbx]
	jl l_84
	l_85:
	mov rdi, g_8
	call __println 
	l_86:
	mov rbx, qword [g_7]
	mov qword [g_7], rbx
	leave 
	ret
	l_84:
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-16]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-24], r11
	mov rdi, qword [rbp-24]
	call _toStringHex_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-32], rax
	mov rdi, qword [rbp-32]
	call __print 
	l_87:
	mov rbx, qword [rbp-16]
	inc rbx
	mov qword [rbp-16], rbx
	jmp l_83
	l_81:
	mov r10, qword [rbp-96]
	mov rbx, r10
	mov qword [rbp-88], rbx
	mov rsi, qword [rbp-16]
	mov rdi, qword [rbp-88]
	call __string_ord 
	mov qword [rbp-56], rax
	mov rbx, qword [rbp-56]
	mov r10, qword [g_7]
	mov r11, qword [rbp-16]
	mov qword [r10 + r11 * 8 + 8], rbx
	l_88:
	mov rbx, qword [rbp-16]
	inc rbx
	mov qword [rbp-16], rbx
	jmp l_80
_nextLetter_User_Defined_fihriaifhiahidsafans:
	l_89:
	push rbp
	mov rbp, rsp
	sub rsp, 32
	mov qword [rbp-24], rdi
	mov rbx, qword [rbp-24]
	cmp rbx, 122
	je l_90
	l_91:
	mov rbx, qword [rbp-24]
	cmp rbx, 90
	je l_92
	l_93:
	mov rbx, qword [rbp-24]
	cmp rbx, 57
	je l_94
	l_95:
	mov r10, qword [rbp-24]
	mov rbx, r10
	mov qword [rbp-16], rbx
	mov rbx, qword [rbp-16]
	add rbx, 1
	mov qword [rbp-16], rbx
	mov rax, qword [rbp-16]
	jmp l_96
	l_94:
	mov rax, 65
	jmp l_96
	l_92:
	mov rax, 97
	jmp l_96
	l_90:
	mov rbx, 1
	mov qword [rbp-8], rbx
	mov rbx, qword [rbp-8]
	neg rbx
	mov qword [rbp-8], rbx
	mov rax, qword [rbp-8]
	l_96:
	leave 
	ret
_nextText_User_Defined_fihriaifhiahidsafans:
	l_97:
	push rbp
	mov rbp, rsp
	sub rsp, 64
	mov qword [rbp-8], rdi
	mov qword [rbp-32], rsi
	mov rbx, qword [rbp-32]
	mov r10, rbx
	mov qword [rbp-40], r10
	mov rbx, qword [rbp-40]
	sub rbx, 1
	mov qword [rbp-40], rbx
	mov rbx, qword [rbp-40]
	mov r10, rbx
	mov qword [rbp-56], r10
	l_98:
	mov rbx, qword [rbp-56]
	cmp rbx, 0
	jge l_99
	l_100:
	l_101:
	mov rax, 0
	l_102:
	jmp l_103
	l_99:
	mov rbx, qword [rbp-8]
	mov r11, qword [rbp-56]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-24], r10
	mov rdi, qword [rbp-24]
	call _nextLetter_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-16], rax
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-16]
	mov r11, qword [rbp-56]
	mov qword [rbx + r11 * 8 + 8], r10
	mov rbx, 1
	mov qword [rbp-48], rbx
	mov rbx, qword [rbp-48]
	neg rbx
	mov qword [rbp-48], rbx
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-48]
	mov r11, qword [rbp-56]
	cmp qword [rbx + r11 * 8 + 8], r10
	je l_104
	l_105:
	l_106:
	mov rax, 1
	l_107:
	l_103:
	leave 
	ret
	l_104:
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-56]
	mov qword [rbx + r10 * 8 + 8], 48
	l_108:
	l_109:
	mov rbx, qword [rbp-56]
	dec rbx
	mov qword [rbp-56], rbx
	jmp l_98
_array_equal_User_Defined_fihriaifhiahidsafans:
	l_110:
	push rbp
	mov rbp, rsp
	sub rsp, 64
	mov qword [rbp-24], rdi
	mov qword [rbp-64], rsi
	mov rbx, qword [rbp-24]
	mov r10, rbx
	mov qword [rbp-32], r10
	mov rbx, qword [rbp-64]
	mov r10, rbx
	mov qword [rbp-48], r10
	mov r10, qword [rbp-32]
	mov rbx, qword [r10]
	mov qword [rbp-8], rbx
	mov rbx, qword [rbp-48]
	mov r10, qword [rbp-8]
	cmp r10, qword [rbx]
	jne l_111
	l_112:
	mov rbx, 0
	mov qword [rbp-16], rbx
	l_113:
	mov r10, qword [rbp-24]
	mov rbx, r10
	mov qword [rbp-40], rbx
	mov rbx, qword [rbp-40]
	mov r10, qword [rbp-16]
	cmp r10, qword [rbx]
	jl l_114
	l_115:
	l_116:
	mov rax, 1
	l_117:
	jmp l_118
	l_114:
	mov rbx, qword [rbp-24]
	mov r10, qword [rbp-16]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-56], r11
	mov rbx, qword [rbp-64]
	mov r10, qword [rbp-16]
	mov r11, qword [rbp-56]
	cmp r11, qword [rbx + r10 * 8 + 8]
	jne l_119
	l_120:
	l_121:
	mov rbx, qword [rbp-16]
	inc rbx
	mov qword [rbp-16], rbx
	jmp l_113
	l_119:
	l_122:
	mov rax, 0
	l_123:
	jmp l_118
	l_111:
	l_124:
	mov rax, 0
	l_125:
	l_118:
	leave 
	ret
_crackSHA1_User_Defined_fihriaifhiahidsafans:
	l_126:
	push rbp
	mov rbp, rsp
	sub rsp, 256
	mov qword [rbp-24], rdi
	mov rbx, qword [g_7]
	mov qword [g_7], rbx
	mov rbx, 5
	mov qword [rbp-240], rbx
	mov rbx, qword [rbp-240]
	mov r10, qword [rbp-64]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-64], r10
	mov rdi, qword [rbp-64]
	call malloc 
	mov qword [rbp-120], rax
	mov rbx, qword [rbp-240]
	mov r10, qword [rbp-120]
	mov qword [r10], rbx
	l_127:
	mov rbx, qword [rbp-240]
	cmp rbx, 0
	jg l_128
	l_129:
	mov r10, qword [rbp-120]
	mov rbx, r10
	mov qword [rbp-72], rbx
	mov r10, qword [rbp-24]
	mov rbx, r10
	mov qword [rbp-192], rbx
	mov rdi, qword [rbp-192]
	call __string_length 
	mov qword [rbp-128], rax
	mov rbx, qword [rbp-128]
	cmp rbx, 40
	jne l_130
	l_131:
	mov rbx, 0
	mov qword [rbp-176], rbx
	l_132:
	mov rbx, qword [rbp-176]
	cmp rbx, 5
	jl l_133
	l_134:
	mov rbx, 0
	mov qword [rbp-176], rbx
	l_135:
	mov rbx, qword [rbp-176]
	cmp rbx, 40
	jl l_136
	l_137:
	mov rbx, 4
	mov qword [rbp-96], rbx
	mov rbx, 1
	mov qword [rbp-48], rbx
	l_138:
	mov rbx, qword [rbp-96]
	mov r10, qword [rbp-48]
	cmp r10, rbx
	jle l_139
	l_140:
	mov rdi, g_9
	call __println 
	jmp l_141
	l_139:
	mov rbx, 0
	mov qword [rbp-176], rbx
	l_142:
	mov rbx, qword [rbp-176]
	mov r10, qword [rbp-48]
	cmp rbx, r10
	jl l_143
	l_144:
	l_145:
	l_146:
	mov rsi, qword [rbp-48]
	mov rdi, qword [g_7]
	call _sha1_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-112], rax
	mov rbx, qword [rbp-112]
	mov r10, rbx
	mov qword [rbp-80], r10
	mov rsi, qword [rbp-72]
	mov rdi, qword [rbp-80]
	call _array_equal_User_Defined_fihriaifhiahidsafans 
	cmp rax, 0
	jne l_147
	l_148:
	mov rsi, qword [rbp-48]
	mov rdi, qword [g_7]
	call _nextText_User_Defined_fihriaifhiahidsafans 
	cmp rax, 0
	jne l_149
	l_150:
	l_151:
	l_152:
	mov rbx, qword [rbp-48]
	inc rbx
	mov qword [rbp-48], rbx
	jmp l_138
	l_149:
	jmp l_145
	l_147:
	mov rbx, 0
	mov qword [rbp-176], rbx
	l_153:
	mov rbx, qword [rbp-176]
	mov r10, qword [rbp-48]
	cmp rbx, r10
	jl l_154
	l_155:
	mov rdi, g_10
	call __println 
	jmp l_141
	l_154:
	mov rbx, qword [rbp-176]
	mov r10, qword [g_7]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-104], r11
	mov rdi, qword [rbp-104]
	call _int2chr_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-208], rax
	mov rdi, qword [rbp-208]
	call __print 
	l_156:
	mov rbx, qword [rbp-176]
	inc rbx
	mov qword [rbp-176], rbx
	jmp l_153
	l_143:
	mov rbx, qword [rbp-176]
	mov r10, qword [g_7]
	mov qword [r10 + rbx * 8 + 8], 48
	l_157:
	mov rbx, qword [rbp-176]
	inc rbx
	mov qword [rbp-176], rbx
	jmp l_142
	l_136:
	mov rax, qword [rbp-176]
	cdq
	mov rbx, 8
	mov qword [rbp-32], rbx
	mov rbx, qword [rbp-32]
	idiv rbx
	mov qword [rbp-16], rax
	mov rax, qword [rbp-176]
	cdq
	mov rbx, 8
	mov qword [rbp-88], rbx
	mov rbx, qword [rbp-88]
	idiv rbx
	mov qword [rbp-144], rax
	mov rbx, qword [rbp-24]
	mov r10, rbx
	mov qword [rbp-248], r10
	mov rbx, qword [rbp-176]
	mov r10, rbx
	mov qword [rbp-224], r10
	mov rbx, qword [rbp-224]
	add rbx, 3
	mov qword [rbp-224], rbx
	mov rdx, qword [rbp-224]
	mov rsi, qword [rbp-176]
	mov rdi, qword [rbp-248]
	call __string_substring 
	mov qword [rbp-8], rax
	mov rdi, qword [rbp-8]
	call _hex2int_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-152], rax
	mov rax, qword [rbp-176]
	cdq
	mov rbx, 4
	mov qword [rbp-168], rbx
	mov rbx, qword [rbp-168]
	idiv rbx
	mov qword [rbp-160], rax
	mov rax, qword [rbp-160]
	cdq
	mov rbx, 2
	mov qword [rbp-56], rbx
	mov rbx, qword [rbp-56]
	idiv rbx
	mov qword [rbp-216], rdx
	mov rbx, 1
	mov qword [rbp-40], rbx
	mov rbx, qword [rbp-40]
	mov r10, qword [rbp-216]
	sub rbx, r10
	mov qword [rbp-40], rbx
	mov rax, qword [rbp-40]
	mov rbx, 16
	mov qword [rbp-136], rbx
	mov rbx, qword [rbp-136]
	imul rbx
	mov qword [rbp-200], rax
	mov r10, qword [rbp-152]
	mov rbx, r10
	mov qword [rbp-232], rbx
	mov rcx, qword [rbp-200]
	mov rbx, qword [rbp-232]
	sal rbx, cl
	mov qword [rbp-232], rbx
	mov rbx, qword [rbp-72]
	mov r11, qword [rbp-144]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-184], r10
	mov rbx, qword [rbp-184]
	mov r10, qword [rbp-232]
	or rbx, r10
	mov qword [rbp-184], rbx
	mov rbx, qword [rbp-72]
	mov r10, qword [rbp-184]
	mov r11, qword [rbp-16]
	mov qword [rbx + r11 * 8 + 8], r10
	l_158:
	mov rbx, qword [rbp-176]
	add rbx, 4
	mov qword [rbp-176], rbx
	jmp l_135
	l_133:
	mov rbx, qword [rbp-72]
	mov r10, qword [rbp-176]
	mov qword [rbx + r10 * 8 + 8], 0
	l_159:
	mov rbx, qword [rbp-176]
	inc rbx
	mov qword [rbp-176], rbx
	jmp l_132
	l_130:
	mov rdi, g_11
	call __println 
	l_141:
	mov rbx, qword [g_7]
	mov qword [g_7], rbx
	leave 
	ret
	l_128:
	mov rbx, qword [rbp-240]
	mov r10, qword [rbp-120]
	mov qword [r10 + rbx * 8], 0
	mov rbx, qword [rbp-240]
	dec rbx
	mov qword [rbp-240], rbx
	jmp l_127
_main_User_Defined_fihriaifhiahidsafans:
	l_160:
	push rbp
	mov rbp, rsp
	sub rsp, 48
	l_161:
	l_162:
	call __getInt 
	mov qword [rbp-24], rax
	mov r10, qword [rbp-24]
	mov rbx, r10
	mov qword [rbp-8], rbx
	mov rbx, qword [rbp-8]
	cmp rbx, 0
	je l_163
	l_164:
	mov rbx, qword [rbp-8]
	cmp rbx, 1
	je l_165
	l_166:
	mov rbx, qword [rbp-8]
	cmp rbx, 2
	jne l_167
	l_168:
	call __getString 
	mov qword [rbp-16], rax
	mov r10, qword [rbp-16]
	mov rbx, r10
	mov qword [rbp-40], rbx
	mov rdi, qword [rbp-40]
	call _crackSHA1_User_Defined_fihriaifhiahidsafans 
	l_167:
	jmp l_169
	l_165:
	call __getString 
	mov qword [rbp-32], rax
	mov r10, qword [rbp-32]
	mov rbx, r10
	mov qword [rbp-40], rbx
	mov rdi, qword [rbp-40]
	call _computeSHA1_User_Defined_fihriaifhiahidsafans 
	l_169:
	jmp l_161
	l_163:
	l_170:
	mov rax, 0
	l_171:
	leave 
	ret
__init:
	l_172:
	push rbp
	mov rbp, rsp
	sub rsp, 128
	mov rbx, g_12
	mov qword [g_0], rbx
	mov rbx, 100
	mov qword [g_3], rbx
	mov rbx, qword [g_3]
	mov r10, rbx
	mov qword [rbp-8], r10
	mov rbx, qword [rbp-8]
	sub rbx, 1
	mov qword [rbp-8], rbx
	mov rax, qword [rbp-8]
	mov rbx, 64
	mov qword [rbp-96], rbx
	mov rbx, qword [rbp-96]
	imul rbx
	mov qword [rbp-48], rax
	mov rbx, qword [rbp-48]
	mov r10, rbx
	mov qword [rbp-112], r10
	mov rbx, qword [rbp-112]
	sub rbx, 16
	mov qword [rbp-112], rbx
	mov r10, qword [rbp-112]
	mov rbx, r10
	mov qword [g_13], rbx
	mov rbx, qword [g_3]
	mov r10, rbx
	mov qword [rbp-104], r10
	mov rbx, qword [rbp-104]
	mov r10, qword [rbp-88]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-88], r10
	mov rdi, qword [rbp-88]
	call malloc 
	mov qword [rbp-32], rax
	mov rbx, qword [rbp-104]
	mov r10, qword [rbp-32]
	mov qword [r10], rbx
	l_173:
	mov rbx, qword [rbp-104]
	cmp rbx, 0
	jg l_174
	l_175:
	mov r10, qword [rbp-32]
	mov rbx, r10
	mov qword [g_5], rbx
	mov rbx, qword [g_13]
	mov r10, rbx
	mov qword [rbp-120], r10
	mov rbx, qword [rbp-120]
	mov r10, qword [rbp-128]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-128], r10
	mov rdi, qword [rbp-128]
	call malloc 
	mov qword [rbp-64], rax
	mov rbx, qword [rbp-120]
	mov r10, qword [rbp-64]
	mov qword [r10], rbx
	l_176:
	mov rbx, qword [rbp-120]
	cmp rbx, 0
	jg l_177
	l_178:
	mov r10, qword [rbp-64]
	mov rbx, r10
	mov qword [g_7], rbx
	mov rbx, 5
	mov qword [rbp-16], rbx
	mov rbx, qword [rbp-24]
	mov r10, qword [rbp-16]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-24], rbx
	mov rdi, qword [rbp-24]
	call malloc 
	mov qword [rbp-56], rax
	mov rbx, qword [rbp-16]
	mov r10, qword [rbp-56]
	mov qword [r10], rbx
	l_179:
	mov rbx, qword [rbp-16]
	cmp rbx, 0
	jg l_180
	l_181:
	mov rbx, qword [rbp-56]
	mov r10, rbx
	mov qword [g_4], r10
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	call _main_User_Defined_fihriaifhiahidsafans 
	leave 
	ret
	l_180:
	mov rbx, qword [rbp-56]
	mov r10, qword [rbp-16]
	mov qword [rbx + r10 * 8], 0
	mov rbx, qword [rbp-16]
	dec rbx
	mov qword [rbp-16], rbx
	jmp l_179
	l_177:
	mov rbx, qword [rbp-120]
	mov r10, qword [rbp-64]
	mov qword [r10 + rbx * 8], 0
	mov rbx, qword [rbp-120]
	dec rbx
	mov qword [rbp-120], rbx
	jmp l_176
	l_174:
	mov rbx, 80
	mov qword [rbp-40], rbx
	mov rbx, qword [rbp-72]
	mov r10, qword [rbp-40]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-72], rbx
	mov rdi, qword [rbp-72]
	call malloc 
	mov qword [rbp-80], rax
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-40]
	mov qword [rbx], r10
	l_182:
	mov rbx, qword [rbp-40]
	cmp rbx, 0
	jg l_183
	l_184:
	mov rbx, qword [rbp-104]
	mov r10, qword [rbp-80]
	mov r11, qword [rbp-32]
	mov qword [r11 + rbx * 8], r10
	mov rbx, qword [rbp-104]
	dec rbx
	mov qword [rbp-104], rbx
	jmp l_173
	l_183:
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-40]
	mov qword [rbx + r10 * 8], 0
	mov rbx, qword [rbp-40]
	dec rbx
	mov qword [rbp-40], rbx
	jmp l_182
	 section .data
g_0:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_3:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_13:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_5:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_7:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_4:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_1:
	dq 0
	db 00H
g_2:
	dq 0
	db 00H
g_6:
	dq 18
	db 6EH, 43H, 68H, 75H, 6EH, 6BH, 20H, 3EH, 20H, 4DH, 41H, 58H, 43H, 48H, 55H, 4EH, 4BH, 21H, 00H
g_8:
	dq 0
	db 00H
g_11:
	dq 13
	db 49H, 6EH, 76H, 61H, 6CH, 69H, 64H, 20H, 69H, 6EH, 70H, 75H, 74H, 00H
g_10:
	dq 0
	db 00H
g_9:
	dq 10
	db 4EH, 6FH, 74H, 20H, 46H, 6FH, 75H, 6EH, 64H, 21H, 00H
g_12:
	dq 95
	db 20H, 21H, 22H, 23H, 24H, 25H, 26H, 27H, 28H, 29H, 2AH, 2BH, 2CH, 2DH, 2EH, 2FH, 30H, 31H, 32H, 33H, 34H, 35H, 36H, 37H, 38H, 39H, 3AH, 3BH, 3CH, 3DH, 3EH, 3FH, 40H, 41H, 42H, 43H, 44H, 45H, 46H, 47H, 48H, 49H, 4AH, 4BH, 4CH, 4DH, 4EH, 4FH, 50H, 51H, 52H, 53H, 54H, 55H, 56H, 57H, 58H, 59H, 5AH, 5BH, 5CH, 5DH, 5EH, 5FH, 60H, 61H, 62H, 63H, 64H, 65H, 66H, 67H, 68H, 69H, 6AH, 6BH, 6CH, 6DH, 6EH, 6FH, 70H, 71H, 72H, 73H, 74H, 75H, 76H, 77H, 78H, 79H, 7AH, 7BH, 7CH, 7DH, 7EH, 00H

