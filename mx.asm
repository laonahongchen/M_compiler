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
_main_User_Defined_fihriaifhiahidsafans:
	l_0:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push r12
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_1]
	mov qword [g_1], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_5]
	mov qword [g_5], rax
	mov rax, qword [g_6]
	mov qword [g_6], rax
	mov rax, qword [g_7]
	mov qword [g_7], rax
	mov rax, qword [g_8]
	mov qword [g_8], rax
	mov rax, qword [g_9]
	mov qword [g_9], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	mov rax, qword [g_11]
	mov qword [g_11], rax
	mov rax, qword [g_12]
	mov qword [g_12], rax
	mov rax, qword [g_13]
	mov qword [g_13], rax
	mov rax, qword [g_14]
	mov qword [g_14], rax
	mov rax, qword [g_15]
	mov qword [g_15], rax
	mov rax, qword [g_16]
	mov qword [g_16], rax
	mov rax, qword [g_17]
	mov qword [g_17], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_19]
	mov qword [g_19], rax
	mov rax, qword [g_20]
	mov qword [g_20], rax
	mov rax, qword [g_21]
	mov qword [g_21], rax
	mov rax, qword [g_22]
	mov qword [g_22], rax
	mov r12, 0
	call __getInt 
	mov rsi, rax
	mov rax, 0
	mov qword [g_17], rax
	l_1:
	mov rax, qword [g_17]
	cmp rax, rsi
	jl l_2
	l_3:
	mov rdi, r12
	call __toString 
	mov rdi, rax
	call __println 
	mov rax, 0
	l_4:
	mov rcx, qword [g_0]
	mov qword [g_0], rcx
	mov rcx, qword [g_1]
	mov qword [g_1], rcx
	mov rcx, qword [g_2]
	mov qword [g_2], rcx
	mov rcx, qword [g_3]
	mov qword [g_3], rcx
	mov rcx, qword [g_4]
	mov qword [g_4], rcx
	mov rcx, qword [g_5]
	mov qword [g_5], rcx
	mov rcx, qword [g_6]
	mov qword [g_6], rcx
	mov rcx, qword [g_7]
	mov qword [g_7], rcx
	mov rcx, qword [g_8]
	mov qword [g_8], rcx
	mov rcx, qword [g_9]
	mov qword [g_9], rcx
	mov rcx, qword [g_10]
	mov qword [g_10], rcx
	mov rcx, qword [g_11]
	mov qword [g_11], rcx
	mov rcx, qword [g_12]
	mov qword [g_12], rcx
	mov rcx, qword [g_13]
	mov qword [g_13], rcx
	mov rcx, qword [g_14]
	mov qword [g_14], rcx
	mov rcx, qword [g_15]
	mov qword [g_15], rcx
	mov rcx, qword [g_16]
	mov qword [g_16], rcx
	mov rcx, qword [g_17]
	mov qword [g_17], rcx
	mov rcx, qword [g_18]
	mov qword [g_18], rcx
	mov rcx, qword [g_19]
	mov qword [g_19], rcx
	mov rcx, qword [g_20]
	mov qword [g_20], rcx
	mov rcx, qword [g_21]
	mov qword [g_21], rcx
	mov rcx, qword [g_22]
	mov qword [g_22], rcx
	pop r12
	leave 
	ret
	l_2:
	mov rax, qword [g_9]
	add rax, 1
	mov qword [g_9], rax
	mov rax, qword [g_10]
	add rax, 1
	mov qword [g_10], rax
	mov rax, qword [g_3]
	add rax, 1
	mov qword [g_3], rax
	mov rax, qword [g_9]
	add rax, 1
	mov qword [g_12], rax
	mov rax, qword [g_10]
	add rax, 1
	mov qword [g_4], rax
	mov rax, qword [g_3]
	add rax, 1
	mov qword [g_13], rax
	mov rax, qword [g_9]
	add rax, 1
	mov qword [g_7], rax
	mov rax, qword [g_10]
	add rax, 1
	mov qword [g_6], rax
	mov rax, qword [g_3]
	add rax, 1
	mov qword [g_11], rax
	mov rax, qword [g_9]
	add rax, 1
	mov qword [g_18], rax
	mov rax, qword [g_10]
	mov qword [g_19], rax
	mov rax, qword [g_9]
	mov qword [g_22], rax
	mov rax, qword [g_10]
	mov qword [g_1], rax
	mov rax, qword [g_3]
	mov qword [g_8], rax
	mov rax, qword [g_12]
	mov qword [g_20], rax
	mov rax, qword [g_4]
	mov qword [g_5], rax
	mov rax, qword [g_13]
	mov qword [g_14], rax
	mov rax, qword [g_7]
	mov qword [g_15], rax
	mov rax, qword [g_6]
	mov qword [g_2], rax
	mov rax, qword [g_11]
	mov qword [g_21], rax
	mov rax, qword [g_18]
	mov qword [g_0], rax
	mov rax, qword [g_19]
	mov qword [g_16], rax
	mov rax, qword [g_17]
	cdq
	mov rcx, 10000000
	idiv rcx
	mov rax, rdx
	cmp rax, 0
	jne l_5
	l_6:
	mov rcx, r12
	mov rax, qword [g_9]
	add rcx, rax
	mov rax, rcx
	mov rcx, qword [g_10]
	add rax, rcx
	mov rcx, rax
	mov rax, qword [g_3]
	add rcx, rax
	mov rax, qword [g_12]
	add rcx, rax
	mov rax, rcx
	mov rcx, qword [g_4]
	add rax, rcx
	mov rcx, qword [g_13]
	add rax, rcx
	mov rcx, rax
	mov rax, qword [g_7]
	add rcx, rax
	mov rax, rcx
	mov rcx, qword [g_6]
	add rax, rcx
	mov rcx, rax
	mov rax, qword [g_11]
	add rcx, rax
	mov rax, qword [g_18]
	add rcx, rax
	mov rax, rcx
	mov rcx, qword [g_19]
	add rax, rcx
	mov rcx, qword [g_22]
	add rax, rcx
	mov rcx, rax
	mov rax, qword [g_1]
	add rcx, rax
	mov rax, rcx
	mov rcx, qword [g_8]
	add rax, rcx
	mov rcx, rax
	mov rax, qword [g_20]
	add rcx, rax
	mov rax, rcx
	mov rcx, qword [g_5]
	add rax, rcx
	mov rcx, rax
	mov rax, qword [g_14]
	add rcx, rax
	mov rax, rcx
	mov rcx, qword [g_15]
	add rax, rcx
	mov rcx, rax
	mov rax, qword [g_2]
	add rcx, rax
	mov rax, qword [g_21]
	add rcx, rax
	mov rax, qword [g_0]
	add rcx, rax
	mov rdi, rcx
	mov rax, qword [g_16]
	add rdi, rax
	mov rax, 32767
	mov rcx, 16
	sal rax, cl
	or rax, 32767
	mov rcx, rdi
	and rcx, rax
	mov r12, rcx
	l_5:
	l_7:
	mov rax, qword [g_17]
	add rax, 1
	mov qword [g_17], rax
	jmp l_1
__init:
	l_8:
	push rbp
	mov rbp, rsp
	mov rax, 0
	mov qword [g_17], rax
	mov rax, 0
	mov qword [g_9], rax
	mov rax, 0
	mov qword [g_10], rax
	mov rax, 0
	mov qword [g_3], rax
	mov rax, 0
	mov qword [g_12], rax
	mov rax, 0
	mov qword [g_4], rax
	mov rax, 0
	mov qword [g_13], rax
	mov rax, 0
	mov qword [g_7], rax
	mov rax, 0
	mov qword [g_6], rax
	mov rax, 0
	mov qword [g_11], rax
	mov rax, 0
	mov qword [g_18], rax
	mov rax, 0
	mov qword [g_19], rax
	mov rax, 0
	mov qword [g_22], rax
	mov rax, 0
	mov qword [g_1], rax
	mov rax, 0
	mov qword [g_8], rax
	mov rax, 0
	mov qword [g_20], rax
	mov rax, 0
	mov qword [g_5], rax
	mov rax, 0
	mov qword [g_14], rax
	mov rax, 0
	mov qword [g_15], rax
	mov rax, 0
	mov qword [g_2], rax
	mov rax, 0
	mov qword [g_21], rax
	mov rax, 0
	mov qword [g_0], rax
	mov rax, 0
	mov qword [g_16], rax
	call _main_User_Defined_fihriaifhiahidsafans 
	leave 
	ret
	 section .data
g_17:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_9:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_10:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_3:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_12:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_4:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_13:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_7:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_6:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_11:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_18:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_19:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_22:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_1:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_8:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_20:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_5:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_14:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_15:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_2:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_21:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_0:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_16:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H

