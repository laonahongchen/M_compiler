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
	push r14
	push r15
	push r13
	push r12
	push rbx
	mov rbx, qword [g_0]
	mov rax, qword [g_1]
	mov qword [g_1], rax
	mov r15, qword [g_2]
	mov r12, qword [g_3]
	mov r14, qword [g_4]
	mov r13, qword [g_5]
	call __getInt 
	mov r12, rax
	mov r9, 1
	l_1:
	cmp r9, r12
	jle l_2
	l_3:
	mov rdi, r14
	call __toString 
	mov rdi, rax
	call __println 
	mov rax, 0
	l_4:
	mov qword [g_0], rbx
	mov rcx, qword [g_1]
	mov qword [g_1], rcx
	mov qword [g_2], r15
	mov qword [g_3], r12
	mov qword [g_4], r14
	mov qword [g_5], r13
	pop rbx
	pop r12
	pop r13
	pop r15
	pop r14
	leave 
	ret
	l_2:
	mov rdi, 1
	l_5:
	cmp rdi, r12
	jle l_6
	l_7:
	l_8:
	inc r9
	jmp l_1
	l_6:
	mov rsi, 1
	l_9:
	cmp rsi, r12
	jle l_10
	l_11:
	l_12:
	inc rdi
	jmp l_5
	l_10:
	mov r8, 1
	l_13:
	cmp r8, r12
	jle l_14
	l_15:
	l_16:
	inc rsi
	jmp l_9
	l_14:
	mov rcx, 1
	l_17:
	cmp rcx, r12
	jle l_18
	l_19:
	l_20:
	inc r8
	jmp l_13
	l_18:
	mov rax, 1
	l_21:
	cmp rax, r12
	jle l_22
	l_23:
	l_24:
	inc rcx
	jmp l_17
	l_22:
	cmp r9, rdi
	je l_25
	l_26:
	cmp r9, rsi
	je l_25
	l_27:
	cmp r9, r8
	je l_25
	l_28:
	cmp r9, rcx
	je l_25
	l_29:
	cmp r9, rax
	je l_25
	l_30:
	cmp r9, r13
	je l_25
	l_31:
	cmp r9, rbx
	je l_25
	l_32:
	mov rdx, qword [g_1]
	cmp r9, rdx
	je l_25
	l_33:
	cmp r9, r15
	je l_25
	l_34:
	cmp rdi, rsi
	je l_25
	l_35:
	cmp rdi, r8
	je l_25
	l_36:
	cmp rdi, rcx
	je l_25
	l_37:
	cmp rdi, rax
	je l_25
	l_38:
	cmp rdi, r13
	je l_25
	l_39:
	cmp rdi, rbx
	je l_25
	l_40:
	mov rdx, qword [g_1]
	cmp rdi, rdx
	je l_25
	l_41:
	cmp rdi, r15
	je l_25
	l_42:
	cmp rsi, r8
	je l_25
	l_43:
	cmp rsi, rcx
	je l_25
	l_44:
	cmp rsi, rax
	je l_25
	l_45:
	cmp rsi, r13
	je l_25
	l_46:
	cmp rsi, rbx
	je l_25
	l_47:
	mov rdx, qword [g_1]
	cmp rsi, rdx
	je l_25
	l_48:
	cmp rsi, r15
	je l_25
	l_49:
	cmp r8, rcx
	je l_25
	l_50:
	cmp r8, rax
	je l_25
	l_51:
	cmp r8, r13
	je l_25
	l_52:
	cmp r8, rbx
	je l_25
	l_53:
	mov rdx, qword [g_1]
	cmp r8, rdx
	je l_25
	l_54:
	cmp r8, r15
	je l_25
	l_55:
	cmp rcx, rax
	je l_25
	l_56:
	cmp rcx, r13
	je l_25
	l_57:
	cmp rcx, rbx
	je l_25
	l_58:
	mov rdx, qword [g_1]
	cmp rcx, rdx
	je l_25
	l_59:
	cmp rcx, r15
	je l_25
	l_60:
	cmp rax, r13
	je l_25
	l_61:
	cmp rax, rbx
	je l_25
	l_62:
	mov rdx, qword [g_1]
	cmp rax, rdx
	je l_25
	l_63:
	cmp rax, r15
	je l_25
	l_64:
	mov rdx, qword [g_1]
	cmp rbx, rdx
	je l_25
	l_65:
	cmp r13, r15
	je l_25
	l_66:
	inc r14
	l_25:
	l_67:
	inc rax
	jmp l_21
__init:
	l_68:
	push rbp
	mov rbp, rsp
	mov rdx, 99
	mov rcx, 100
	mov r8, 101
	mov rsi, 102
	mov rdi, 0
	mov qword [g_0], rcx
	mov qword [g_1], r8
	mov qword [g_2], rsi
	mov qword [g_4], rdi
	mov qword [g_5], rdx
	call _main_User_Defined_fihriaifhiahidsafans 
	mov rdx, qword [g_5]
	mov rdi, qword [g_4]
	mov rsi, qword [g_2]
	mov r8, qword [g_1]
	mov rcx, qword [g_0]
	leave 
	ret
	 section .data
g_3:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_5:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_0:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_1:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_2:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_4:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H

