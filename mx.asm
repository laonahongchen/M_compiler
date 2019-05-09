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
_tak_User_Defined_fihriaifhiahidsafans:
	l_0:
	push rbp
	mov rbp, rsp
	sub rsp, 4440
	push r15
	push r13
	push rbx
	push r14
	push r12
	mov rax, rdi
	mov qword [rbp-288], rax
	mov rax, rsi
	mov qword [rbp-1736], rax
	mov rax, rdx
	mov qword [rbp-3264], rax
	mov rax, qword [rbp-1736]
	mov rcx, qword [rbp-288]
	cmp rax, rcx
	jl l_1
	l_2:
	mov rax, qword [rbp-3264]
	jmp l_3
	l_1:
	mov rax, qword [rbp-288]
	sub rax, 1
	mov qword [rbp-2600], rax
	mov rax, qword [rbp-1736]
	mov qword [rbp-2232], rax
	mov rax, qword [rbp-3264]
	mov qword [rbp-3416], rax
	l_4:
	mov rcx, qword [rbp-2232]
	mov rax, qword [rbp-2600]
	cmp rcx, rax
	jl l_5
	l_6:
	mov rax, qword [rbp-3416]
	jmp l_7
	l_5:
	mov rax, qword [rbp-2600]
	sub rax, 1
	mov qword [rbp-3464], rax
	mov rax, qword [rbp-2232]
	mov qword [rbp-456], rax
	mov rax, qword [rbp-3416]
	mov qword [rbp-2608], rax
	l_8:
	mov rcx, qword [rbp-456]
	mov rax, qword [rbp-3464]
	cmp rcx, rax
	jl l_9
	l_10:
	mov rax, qword [rbp-2608]
	jmp l_11
	l_9:
	mov rax, qword [rbp-3464]
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-456]
	mov qword [rbp-2432], rax
	mov rax, qword [rbp-2608]
	mov rbx, rax
	l_12:
	mov rax, qword [rbp-2432]
	cmp rax, r14
	jl l_13
	l_14:
	mov rax, rbx
	jmp l_15
	l_13:
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-2432]
	mov r12, rax
	mov r15, rbx
	l_16:
	cmp r12, r13
	jl l_17
	l_18:
	mov rax, r15
	jmp l_19
	l_17:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2616], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1216], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1216]
	mov rsi, rax
	mov rax, qword [rbp-2616]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_19:
	mov qword [rbp-1576], rax
	mov rax, qword [rbp-2432]
	sub rax, 1
	mov r12, rax
	mov r13, rbx
	mov r15, r14
	l_20:
	cmp r13, r12
	jl l_21
	l_22:
	mov rax, r15
	jmp l_23
	l_21:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1336], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2448], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2448]
	mov rsi, rax
	mov rax, qword [rbp-1336]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_23:
	mov qword [rbp-992], rax
	mov rax, rbx
	sub rax, 1
	mov rbx, rax
	mov r12, r14
	mov rax, qword [rbp-2432]
	mov r15, rax
	l_24:
	cmp r12, rbx
	jl l_25
	l_26:
	mov rax, r15
	jmp l_27
	l_25:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_27:
	mov rcx, rax
	mov rdx, qword [rbp-1576]
	mov rbx, rdx
	mov rdx, qword [rbp-992]
	mov r14, rdx
	mov r12, rcx
	l_28:
	cmp r14, rbx
	jl l_29
	l_30:
	jmp l_31
	l_29:
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_31:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_15:
	mov qword [rbp-2048], rax
	mov rax, qword [rbp-456]
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-2608]
	mov qword [rbp-1560], rax
	mov rax, qword [rbp-3464]
	mov rbx, rax
	l_32:
	mov rax, qword [rbp-1560]
	cmp rax, r14
	jl l_33
	l_34:
	mov rax, rbx
	jmp l_35
	l_33:
	mov rax, r14
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-1560]
	mov r13, rax
	mov r15, rbx
	l_36:
	cmp r13, r12
	jl l_37
	l_38:
	mov rax, r15
	jmp l_39
	l_37:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3784], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4408], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-4408]
	mov rsi, rax
	mov rax, qword [rbp-3784]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_39:
	mov qword [rbp-1952], rax
	mov rax, qword [rbp-1560]
	sub rax, 1
	mov r13, rax
	mov r15, rbx
	mov r12, r14
	l_40:
	cmp r15, r13
	jl l_41
	l_42:
	mov rax, r12
	jmp l_43
	l_41:
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-312], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1520], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1520]
	mov rsi, rax
	mov rax, qword [rbp-312]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_43:
	mov qword [rbp-880], rax
	mov rax, rbx
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-1560]
	mov r15, rax
	l_44:
	cmp r14, rbx
	jl l_45
	l_46:
	mov rax, r15
	jmp l_47
	l_45:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_47:
	mov rdx, rax
	mov rcx, qword [rbp-1952]
	mov r14, rcx
	mov rcx, qword [rbp-880]
	mov r13, rcx
	mov r15, rdx
	l_48:
	cmp r13, r14
	jl l_49
	l_50:
	jmp l_51
	l_49:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_51:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_35:
	mov qword [rbp-2880], rax
	mov rax, qword [rbp-2608]
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-3464]
	mov qword [rbp-920], rax
	mov rax, qword [rbp-456]
	mov rbx, rax
	l_52:
	mov rax, qword [rbp-920]
	cmp rax, r12
	jl l_53
	l_54:
	mov rax, rbx
	jmp l_55
	l_53:
	mov rax, r12
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-920]
	mov r13, rax
	mov r15, rbx
	l_56:
	cmp r13, r14
	jl l_57
	l_58:
	mov rax, r15
	jmp l_59
	l_57:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2184], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-128], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-128]
	mov rsi, rax
	mov rax, qword [rbp-2184]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_59:
	mov qword [rbp-2120], rax
	mov rax, qword [rbp-920]
	sub rax, 1
	mov r13, rax
	mov r14, rbx
	mov r15, r12
	l_60:
	cmp r14, r13
	jl l_61
	l_62:
	mov rax, r15
	jmp l_63
	l_61:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4016], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4032], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-4032]
	mov rsi, rax
	mov rax, qword [rbp-4016]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_63:
	mov qword [rbp-4128], rax
	mov rax, rbx
	sub rax, 1
	mov r14, rax
	mov r13, r12
	mov rax, qword [rbp-920]
	mov r12, rax
	l_64:
	cmp r13, r14
	jl l_65
	l_66:
	mov rax, r12
	jmp l_67
	l_65:
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_67:
	mov rdx, rax
	mov rcx, qword [rbp-2120]
	mov r15, rcx
	mov rcx, qword [rbp-4128]
	mov r12, rcx
	mov r14, rdx
	l_68:
	cmp r12, r15
	jl l_69
	l_70:
	jmp l_71
	l_69:
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_71:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_55:
	mov rdx, rax
	mov rcx, qword [rbp-2048]
	mov r13, rcx
	mov rcx, qword [rbp-2880]
	mov r14, rcx
	mov rcx, rdx
	mov qword [rbp-2648], rcx
	l_72:
	cmp r14, r13
	jl l_73
	l_74:
	jmp l_75
	l_73:
	mov rcx, r13
	sub rcx, 1
	mov rbx, rcx
	mov r15, r14
	mov rcx, qword [rbp-2648]
	mov r12, rcx
	l_76:
	cmp r15, rbx
	jl l_77
	l_78:
	jmp l_79
	l_77:
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2520], rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1704], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1704]
	mov rsi, rax
	mov rax, qword [rbp-2520]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_79:
	mov qword [rbp-200], rax
	mov rax, r14
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-2648]
	mov r12, rax
	mov r15, r13
	l_80:
	cmp r12, rbx
	jl l_81
	l_82:
	mov rax, r15
	jmp l_83
	l_81:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1544], rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2480], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2480]
	mov rsi, rax
	mov rax, qword [rbp-1544]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_83:
	mov qword [rbp-728], rax
	mov rax, qword [rbp-2648]
	sub rax, 1
	mov rbx, rax
	mov r15, r14
	l_84:
	cmp r13, rbx
	jl l_85
	l_86:
	mov rax, r15
	jmp l_87
	l_85:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_87:
	mov rdx, rax
	mov rcx, qword [rbp-200]
	mov r14, rcx
	mov rcx, qword [rbp-728]
	mov rbx, rcx
	mov r13, rdx
	l_88:
	cmp rbx, r14
	jl l_89
	l_90:
	jmp l_91
	l_89:
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_91:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_75:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_11:
	mov qword [rbp-2528], rax
	mov rax, qword [rbp-2232]
	sub rax, 1
	mov qword [rbp-2176], rax
	mov rax, qword [rbp-3416]
	mov qword [rbp-1712], rax
	mov rax, qword [rbp-2600]
	mov qword [rbp-2552], rax
	l_92:
	mov rax, qword [rbp-1712]
	mov rcx, qword [rbp-2176]
	cmp rax, rcx
	jl l_93
	l_94:
	mov rax, qword [rbp-2552]
	jmp l_95
	l_93:
	mov rax, qword [rbp-2176]
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-1712]
	mov qword [rbp-4192], rax
	mov rax, qword [rbp-2552]
	mov r14, rax
	l_96:
	mov rax, qword [rbp-4192]
	cmp rax, rbx
	jl l_97
	l_98:
	mov rax, r14
	jmp l_99
	l_97:
	mov rax, rbx
	sub rax, 1
	mov r15, rax
	mov rax, qword [rbp-4192]
	mov r12, rax
	mov r13, r14
	l_100:
	cmp r12, r15
	jl l_101
	l_102:
	mov rax, r13
	jmp l_103
	l_101:
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1872], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2040], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2040]
	mov rsi, rax
	mov rax, qword [rbp-1872]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_103:
	mov qword [rbp-1152], rax
	mov rax, qword [rbp-4192]
	sub rax, 1
	mov r15, rax
	mov r12, r14
	mov r13, rbx
	l_104:
	cmp r12, r15
	jl l_105
	l_106:
	mov rax, r13
	jmp l_107
	l_105:
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1880], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3736], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3736]
	mov rsi, rax
	mov rax, qword [rbp-1880]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_107:
	mov qword [rbp-48], rax
	mov rax, r14
	sub rax, 1
	mov r14, rax
	mov r13, rbx
	mov rax, qword [rbp-4192]
	mov r15, rax
	l_108:
	cmp r13, r14
	jl l_109
	l_110:
	mov rax, r15
	jmp l_111
	l_109:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_111:
	mov rdx, rax
	mov rcx, qword [rbp-1152]
	mov r14, rcx
	mov rcx, qword [rbp-48]
	mov rbx, rcx
	mov r15, rdx
	l_112:
	cmp rbx, r14
	jl l_113
	l_114:
	jmp l_115
	l_113:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_115:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_99:
	mov qword [rbp-3256], rax
	mov rax, qword [rbp-1712]
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-2552]
	mov qword [rbp-4112], rax
	mov rax, qword [rbp-2176]
	mov r12, rax
	l_116:
	mov rax, qword [rbp-4112]
	cmp rax, rbx
	jl l_117
	l_118:
	mov rax, r12
	jmp l_119
	l_117:
	mov rax, rbx
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-4112]
	mov r14, rax
	mov r15, r12
	l_120:
	cmp r14, r13
	jl l_121
	l_122:
	mov rax, r15
	jmp l_123
	l_121:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3672], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3896], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3896]
	mov rsi, rax
	mov rax, qword [rbp-3672]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_123:
	mov qword [rbp-112], rax
	mov rax, qword [rbp-4112]
	sub rax, 1
	mov r14, rax
	mov r13, r12
	mov r15, rbx
	l_124:
	cmp r13, r14
	jl l_125
	l_126:
	mov rax, r15
	jmp l_127
	l_125:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1176], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2128], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2128]
	mov rsi, rax
	mov rax, qword [rbp-1176]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_127:
	mov qword [rbp-320], rax
	mov rax, r12
	sub rax, 1
	mov r13, rax
	mov r15, rbx
	mov rax, qword [rbp-4112]
	mov rbx, rax
	l_128:
	cmp r15, r13
	jl l_129
	l_130:
	mov rax, rbx
	jmp l_131
	l_129:
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_131:
	mov rdx, rax
	mov rcx, qword [rbp-112]
	mov rbx, rcx
	mov rcx, qword [rbp-320]
	mov r14, rcx
	mov r13, rdx
	l_132:
	cmp r14, rbx
	jl l_133
	l_134:
	jmp l_135
	l_133:
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_135:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_119:
	mov qword [rbp-3960], rax
	mov rax, qword [rbp-2552]
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-2176]
	mov qword [rbp-2968], rax
	mov rax, qword [rbp-1712]
	mov rbx, rax
	l_136:
	mov rax, qword [rbp-2968]
	cmp rax, r14
	jl l_137
	l_138:
	mov rax, rbx
	jmp l_139
	l_137:
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-2968]
	mov r15, rax
	mov r12, rbx
	l_140:
	cmp r15, r13
	jl l_141
	l_142:
	mov rax, r12
	jmp l_143
	l_141:
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3728], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1112], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1112]
	mov rsi, rax
	mov rax, qword [rbp-3728]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_143:
	mov qword [rbp-4080], rax
	mov rax, qword [rbp-2968]
	sub rax, 1
	mov r13, rax
	mov r15, rbx
	mov r12, r14
	l_144:
	cmp r15, r13
	jl l_145
	l_146:
	mov rax, r12
	jmp l_147
	l_145:
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3336], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4280], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-4280]
	mov rsi, rax
	mov rax, qword [rbp-3336]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_147:
	mov qword [rbp-1912], rax
	mov rax, rbx
	sub rax, 1
	mov rbx, rax
	mov r15, r14
	mov rax, qword [rbp-2968]
	mov r12, rax
	l_148:
	cmp r15, rbx
	jl l_149
	l_150:
	mov rax, r12
	jmp l_151
	l_149:
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_151:
	mov rdx, rax
	mov rcx, qword [rbp-4080]
	mov r12, rcx
	mov rcx, qword [rbp-1912]
	mov r13, rcx
	mov r15, rdx
	l_152:
	cmp r13, r12
	jl l_153
	l_154:
	jmp l_155
	l_153:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_155:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_139:
	mov rdx, rax
	mov rcx, qword [rbp-3256]
	mov r14, rcx
	mov rcx, qword [rbp-3960]
	mov r13, rcx
	mov rcx, rdx
	mov qword [rbp-2936], rcx
	l_156:
	cmp r13, r14
	jl l_157
	l_158:
	jmp l_159
	l_157:
	mov rcx, r14
	sub rcx, 1
	mov r12, rcx
	mov r15, r13
	mov rcx, qword [rbp-2936]
	mov rbx, rcx
	l_160:
	cmp r15, r12
	jl l_161
	l_162:
	jmp l_163
	l_161:
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-328], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3752], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3752]
	mov rsi, rax
	mov rax, qword [rbp-328]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_163:
	mov qword [rbp-3576], rax
	mov rax, r13
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-2936]
	mov r15, rax
	mov r12, r14
	l_164:
	cmp r15, rbx
	jl l_165
	l_166:
	mov rax, r12
	jmp l_167
	l_165:
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4360], rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3928], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3928]
	mov rsi, rax
	mov rax, qword [rbp-4360]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_167:
	mov qword [rbp-56], rax
	mov rax, qword [rbp-2936]
	sub rax, 1
	mov r12, rax
	mov rbx, r14
	l_168:
	cmp rbx, r12
	jl l_169
	l_170:
	mov rax, r13
	jmp l_171
	l_169:
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_171:
	mov rdx, rax
	mov rcx, qword [rbp-3576]
	mov r14, rcx
	mov rcx, qword [rbp-56]
	mov r13, rcx
	mov rbx, rdx
	l_172:
	cmp r13, r14
	jl l_173
	l_174:
	jmp l_175
	l_173:
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_175:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_159:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_95:
	mov qword [rbp-4184], rax
	mov rax, qword [rbp-3416]
	sub rax, 1
	mov qword [rbp-3512], rax
	mov rax, qword [rbp-2600]
	mov qword [rbp-560], rax
	mov rax, qword [rbp-2232]
	mov qword [rbp-192], rax
	l_176:
	mov rax, qword [rbp-560]
	mov rcx, qword [rbp-3512]
	cmp rax, rcx
	jl l_177
	l_178:
	mov rax, qword [rbp-192]
	jmp l_179
	l_177:
	mov rax, qword [rbp-3512]
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-560]
	mov qword [rbp-960], rax
	mov rax, qword [rbp-192]
	mov rbx, rax
	l_180:
	mov rax, qword [rbp-960]
	cmp rax, r12
	jl l_181
	l_182:
	mov rax, rbx
	jmp l_183
	l_181:
	mov rax, r12
	sub rax, 1
	mov r15, rax
	mov rax, qword [rbp-960]
	mov r14, rax
	mov r13, rbx
	l_184:
	cmp r14, r15
	jl l_185
	l_186:
	mov rax, r13
	jmp l_187
	l_185:
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2560], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1720], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1720]
	mov rsi, rax
	mov rax, qword [rbp-2560]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_187:
	mov qword [rbp-1288], rax
	mov rax, qword [rbp-960]
	sub rax, 1
	mov r13, rax
	mov r14, rbx
	mov r15, r12
	l_188:
	cmp r14, r13
	jl l_189
	l_190:
	mov rax, r15
	jmp l_191
	l_189:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1840], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4000], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-4000]
	mov rsi, rax
	mov rax, qword [rbp-1840]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_191:
	mov qword [rbp-2008], rax
	mov rax, rbx
	sub rax, 1
	mov r14, rax
	mov rbx, r12
	mov rax, qword [rbp-960]
	mov r15, rax
	l_192:
	cmp rbx, r14
	jl l_193
	l_194:
	mov rax, r15
	jmp l_195
	l_193:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_195:
	mov rdx, rax
	mov rcx, qword [rbp-1288]
	mov r14, rcx
	mov rcx, qword [rbp-2008]
	mov r12, rcx
	mov r15, rdx
	l_196:
	cmp r12, r14
	jl l_197
	l_198:
	jmp l_199
	l_197:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_199:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_183:
	mov qword [rbp-1488], rax
	mov rax, qword [rbp-560]
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-192]
	mov qword [rbp-3968], rax
	mov rax, qword [rbp-3512]
	mov r13, rax
	l_200:
	mov rax, qword [rbp-3968]
	cmp rax, r14
	jl l_201
	l_202:
	mov rax, r13
	jmp l_203
	l_201:
	mov rax, r14
	sub rax, 1
	mov r15, rax
	mov rax, qword [rbp-3968]
	mov r12, rax
	mov rbx, r13
	l_204:
	cmp r12, r15
	jl l_205
	l_206:
	mov rax, rbx
	jmp l_207
	l_205:
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1304], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1832], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1832]
	mov rsi, rax
	mov rax, qword [rbp-1304]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_207:
	mov qword [rbp-3176], rax
	mov rax, qword [rbp-3968]
	sub rax, 1
	mov r15, rax
	mov r12, r13
	mov rbx, r14
	l_208:
	cmp r12, r15
	jl l_209
	l_210:
	mov rax, rbx
	jmp l_211
	l_209:
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1504], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3688], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3688]
	mov rsi, rax
	mov rax, qword [rbp-1504]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_211:
	mov qword [rbp-1192], rax
	mov rax, r13
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-3968]
	mov r13, rax
	l_212:
	cmp r14, rbx
	jl l_213
	l_214:
	mov rax, r13
	jmp l_215
	l_213:
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_215:
	mov rdx, rax
	mov rcx, qword [rbp-3176]
	mov r12, rcx
	mov rcx, qword [rbp-1192]
	mov r13, rcx
	mov r14, rdx
	l_216:
	cmp r13, r12
	jl l_217
	l_218:
	jmp l_219
	l_217:
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_219:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_203:
	mov qword [rbp-2440], rax
	mov rax, qword [rbp-192]
	sub rax, 1
	mov r15, rax
	mov rax, qword [rbp-3512]
	mov qword [rbp-1040], rax
	mov rax, qword [rbp-560]
	mov rbx, rax
	l_220:
	mov rax, qword [rbp-1040]
	cmp rax, r15
	jl l_221
	l_222:
	mov rax, rbx
	jmp l_223
	l_221:
	mov rax, r15
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-1040]
	mov r12, rax
	mov r14, rbx
	l_224:
	cmp r12, r13
	jl l_225
	l_226:
	mov rax, r14
	jmp l_227
	l_225:
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-856], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3352], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3352]
	mov rsi, rax
	mov rax, qword [rbp-856]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_227:
	mov qword [rbp-1984], rax
	mov rax, qword [rbp-1040]
	sub rax, 1
	mov r12, rax
	mov r13, rbx
	mov r14, r15
	l_228:
	cmp r13, r12
	jl l_229
	l_230:
	mov rax, r14
	jmp l_231
	l_229:
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4336], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3112], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3112]
	mov rsi, rax
	mov rax, qword [rbp-4336]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_231:
	mov qword [rbp-976], rax
	mov rax, rbx
	sub rax, 1
	mov r13, rax
	mov rbx, r15
	mov rax, qword [rbp-1040]
	mov r15, rax
	l_232:
	cmp rbx, r13
	jl l_233
	l_234:
	mov rax, r15
	jmp l_235
	l_233:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_235:
	mov rdx, rax
	mov rcx, qword [rbp-1984]
	mov r13, rcx
	mov rcx, qword [rbp-976]
	mov r14, rcx
	mov r15, rdx
	l_236:
	cmp r14, r13
	jl l_237
	l_238:
	jmp l_239
	l_237:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_239:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_223:
	mov rdx, rax
	mov rcx, qword [rbp-1488]
	mov r12, rcx
	mov rcx, qword [rbp-2440]
	mov r14, rcx
	mov rcx, rdx
	mov qword [rbp-664], rcx
	l_240:
	cmp r14, r12
	jl l_241
	l_242:
	jmp l_243
	l_241:
	mov rcx, r12
	sub rcx, 1
	mov r15, rcx
	mov rbx, r14
	mov rcx, qword [rbp-664]
	mov r13, rcx
	l_244:
	cmp rbx, r15
	jl l_245
	l_246:
	jmp l_247
	l_245:
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3432], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-96], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-96]
	mov rsi, rax
	mov rax, qword [rbp-3432]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_247:
	mov qword [rbp-2800], rax
	mov rax, r14
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-664]
	mov r13, rax
	mov r15, r12
	l_248:
	cmp r13, rbx
	jl l_249
	l_250:
	mov rax, r15
	jmp l_251
	l_249:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3128], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2424], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2424]
	mov rsi, rax
	mov rax, qword [rbp-3128]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_251:
	mov qword [rbp-3320], rax
	mov rax, qword [rbp-664]
	sub rax, 1
	mov rbx, rax
	mov r13, r12
	mov r15, r14
	l_252:
	cmp r13, rbx
	jl l_253
	l_254:
	mov rax, r15
	jmp l_255
	l_253:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_255:
	mov rcx, rax
	mov rdx, qword [rbp-2800]
	mov r13, rdx
	mov rdx, qword [rbp-3320]
	mov rbx, rdx
	mov r15, rcx
	l_256:
	cmp rbx, r13
	jl l_257
	l_258:
	jmp l_259
	l_257:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_259:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_243:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_179:
	mov rcx, rax
	mov rdx, qword [rbp-2528]
	mov qword [rbp-4144], rdx
	mov rdx, qword [rbp-4184]
	mov qword [rbp-3664], rdx
	mov qword [rbp-3072], rcx
	l_260:
	mov rdx, qword [rbp-3664]
	mov rcx, qword [rbp-4144]
	cmp rdx, rcx
	jl l_261
	l_262:
	jmp l_263
	l_261:
	mov rcx, qword [rbp-4144]
	sub rcx, 1
	mov r14, rcx
	mov rcx, qword [rbp-3664]
	mov r12, rcx
	mov rcx, qword [rbp-3072]
	mov qword [rbp-3904], rcx
	l_264:
	cmp r12, r14
	jl l_265
	l_266:
	jmp l_267
	l_265:
	mov rcx, r14
	sub rcx, 1
	mov rbx, rcx
	mov r13, r12
	mov rcx, qword [rbp-3904]
	mov r15, rcx
	l_268:
	cmp r13, rbx
	jl l_269
	l_270:
	jmp l_271
	l_269:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-528], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2584], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2584]
	mov rsi, rax
	mov rax, qword [rbp-528]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_271:
	mov qword [rbp-2976], rax
	mov rax, r12
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-3904]
	mov r13, rax
	mov r15, r14
	l_272:
	cmp r13, rbx
	jl l_273
	l_274:
	mov rax, r15
	jmp l_275
	l_273:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3424], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2384], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2384]
	mov rsi, rax
	mov rax, qword [rbp-3424]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_275:
	mov qword [rbp-3800], rax
	mov rax, qword [rbp-3904]
	sub rax, 1
	mov rbx, rax
	mov r13, r14
	mov r15, r12
	l_276:
	cmp r13, rbx
	jl l_277
	l_278:
	mov rax, r15
	jmp l_279
	l_277:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_279:
	mov rcx, rax
	mov rdx, qword [rbp-2976]
	mov r13, rdx
	mov rdx, qword [rbp-3800]
	mov r14, rdx
	mov rbx, rcx
	l_280:
	cmp r14, r13
	jl l_281
	l_282:
	jmp l_283
	l_281:
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_283:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_267:
	mov qword [rbp-2928], rax
	mov rax, qword [rbp-3664]
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-3072]
	mov qword [rbp-4104], rax
	mov rax, qword [rbp-4144]
	mov r13, rax
	l_284:
	mov rax, qword [rbp-4104]
	cmp rax, r14
	jl l_285
	l_286:
	mov rax, r13
	jmp l_287
	l_285:
	mov rax, r14
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-4104]
	mov r15, rax
	mov r12, r13
	l_288:
	cmp r15, rbx
	jl l_289
	l_290:
	mov rax, r12
	jmp l_291
	l_289:
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3952], rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3120], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3120]
	mov rsi, rax
	mov rax, qword [rbp-3952]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_291:
	mov qword [rbp-4208], rax
	mov rax, qword [rbp-4104]
	sub rax, 1
	mov r15, rax
	mov r12, r13
	mov rbx, r14
	l_292:
	cmp r12, r15
	jl l_293
	l_294:
	mov rax, rbx
	jmp l_295
	l_293:
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1072], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1240], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1240]
	mov rsi, rax
	mov rax, qword [rbp-1072]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_295:
	mov qword [rbp-336], rax
	mov rax, r13
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-4104]
	mov r15, rax
	l_296:
	cmp r14, r12
	jl l_297
	l_298:
	mov rax, r15
	jmp l_299
	l_297:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_299:
	mov rdx, rax
	mov rcx, qword [rbp-4208]
	mov r14, rcx
	mov rcx, qword [rbp-336]
	mov r15, rcx
	mov rbx, rdx
	l_300:
	cmp r15, r14
	jl l_301
	l_302:
	jmp l_303
	l_301:
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_303:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_287:
	mov qword [rbp-1472], rax
	mov rax, qword [rbp-3072]
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-4144]
	mov qword [rbp-592], rax
	mov rax, qword [rbp-3664]
	mov r14, rax
	l_304:
	mov rax, qword [rbp-592]
	cmp rax, rbx
	jl l_305
	l_306:
	mov rax, r14
	jmp l_307
	l_305:
	mov rax, rbx
	sub rax, 1
	mov r15, rax
	mov rax, qword [rbp-592]
	mov r13, rax
	mov r12, r14
	l_308:
	cmp r13, r15
	jl l_309
	l_310:
	mov rax, r12
	jmp l_311
	l_309:
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4296], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3280], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3280]
	mov rsi, rax
	mov rax, qword [rbp-4296]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_311:
	mov qword [rbp-2328], rax
	mov rax, qword [rbp-592]
	sub rax, 1
	mov r13, rax
	mov r12, r14
	mov r15, rbx
	l_312:
	cmp r12, r13
	jl l_313
	l_314:
	mov rax, r15
	jmp l_315
	l_313:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2024], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1648], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1648]
	mov rsi, rax
	mov rax, qword [rbp-2024]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_315:
	mov qword [rbp-2792], rax
	mov rax, r14
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-592]
	mov r13, rax
	l_316:
	cmp rbx, r12
	jl l_317
	l_318:
	mov rax, r13
	jmp l_319
	l_317:
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_319:
	mov rdx, rax
	mov rcx, qword [rbp-2328]
	mov rbx, rcx
	mov rcx, qword [rbp-2792]
	mov r13, rcx
	mov r14, rdx
	l_320:
	cmp r13, rbx
	jl l_321
	l_322:
	jmp l_323
	l_321:
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_323:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_307:
	mov rcx, rax
	mov rdx, qword [rbp-2928]
	mov r12, rdx
	mov rdx, qword [rbp-1472]
	mov r14, rdx
	mov qword [rbp-1728], rcx
	l_324:
	cmp r14, r12
	jl l_325
	l_326:
	jmp l_327
	l_325:
	mov rcx, r12
	sub rcx, 1
	mov rbx, rcx
	mov r13, r14
	mov rcx, qword [rbp-1728]
	mov r15, rcx
	l_328:
	cmp r13, rbx
	jl l_329
	l_330:
	jmp l_331
	l_329:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1992], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2456], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2456]
	mov rsi, rax
	mov rax, qword [rbp-1992]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_331:
	mov qword [rbp-2952], rax
	mov rax, r14
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-1728]
	mov r13, rax
	mov r15, r12
	l_332:
	cmp r13, rbx
	jl l_333
	l_334:
	mov rax, r15
	jmp l_335
	l_333:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2808], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1464], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1464]
	mov rsi, rax
	mov rax, qword [rbp-2808]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_335:
	mov qword [rbp-3232], rax
	mov rax, qword [rbp-1728]
	sub rax, 1
	mov rbx, rax
	mov r15, r14
	l_336:
	cmp r12, rbx
	jl l_337
	l_338:
	mov rax, r15
	jmp l_339
	l_337:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_339:
	mov rdx, rax
	mov rcx, qword [rbp-2952]
	mov rbx, rcx
	mov rcx, qword [rbp-3232]
	mov r13, rcx
	mov r14, rdx
	l_340:
	cmp r13, rbx
	jl l_341
	l_342:
	jmp l_343
	l_341:
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_343:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_327:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_263:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_7:
	mov qword [rbp-3944], rax
	mov rax, qword [rbp-1736]
	sub rax, 1
	mov qword [rbp-3568], rax
	mov rax, qword [rbp-3264]
	mov qword [rbp-464], rax
	mov rax, qword [rbp-288]
	mov qword [rbp-1976], rax
	l_344:
	mov rax, qword [rbp-464]
	mov rcx, qword [rbp-3568]
	cmp rax, rcx
	jl l_345
	l_346:
	mov rax, qword [rbp-1976]
	jmp l_347
	l_345:
	mov rax, qword [rbp-3568]
	sub rax, 1
	mov qword [rbp-3520], rax
	mov rax, qword [rbp-464]
	mov qword [rbp-2960], rax
	mov rax, qword [rbp-1976]
	mov qword [rbp-168], rax
	l_348:
	mov rax, qword [rbp-2960]
	mov rcx, qword [rbp-3520]
	cmp rax, rcx
	jl l_349
	l_350:
	mov rax, qword [rbp-168]
	jmp l_351
	l_349:
	mov rax, qword [rbp-3520]
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-2960]
	mov qword [rbp-776], rax
	mov rax, qword [rbp-168]
	mov rbx, rax
	l_352:
	mov rax, qword [rbp-776]
	cmp rax, r14
	jl l_353
	l_354:
	mov rax, rbx
	jmp l_355
	l_353:
	mov rax, r14
	sub rax, 1
	mov r15, rax
	mov rax, qword [rbp-776]
	mov r12, rax
	mov r13, rbx
	l_356:
	cmp r12, r15
	jl l_357
	l_358:
	mov rax, r13
	jmp l_359
	l_357:
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-488], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1632], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1632]
	mov rsi, rax
	mov rax, qword [rbp-488]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_359:
	mov qword [rbp-3712], rax
	mov rax, qword [rbp-776]
	sub rax, 1
	mov r12, rax
	mov r13, rbx
	mov r15, r14
	l_360:
	cmp r13, r12
	jl l_361
	l_362:
	mov rax, r15
	jmp l_363
	l_361:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2168], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-264], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-264]
	mov rsi, rax
	mov rax, qword [rbp-2168]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_363:
	mov qword [rbp-1624], rax
	mov rax, rbx
	sub rax, 1
	mov r13, rax
	mov r12, r14
	mov rax, qword [rbp-776]
	mov r15, rax
	l_364:
	cmp r12, r13
	jl l_365
	l_366:
	mov rax, r15
	jmp l_367
	l_365:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_367:
	mov rcx, rax
	mov rdx, qword [rbp-3712]
	mov rbx, rdx
	mov rdx, qword [rbp-1624]
	mov r12, rdx
	mov r13, rcx
	l_368:
	cmp r12, rbx
	jl l_369
	l_370:
	jmp l_371
	l_369:
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_371:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_355:
	mov qword [rbp-1536], rax
	mov rax, qword [rbp-2960]
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-168]
	mov qword [rbp-576], rax
	mov rax, qword [rbp-3520]
	mov r14, rax
	l_372:
	mov rax, qword [rbp-576]
	cmp rax, rbx
	jl l_373
	l_374:
	mov rax, r14
	jmp l_375
	l_373:
	mov rax, rbx
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-576]
	mov r15, rax
	mov r13, r14
	l_376:
	cmp r15, r12
	jl l_377
	l_378:
	mov rax, r13
	jmp l_379
	l_377:
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3880], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2296], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2296]
	mov rsi, rax
	mov rax, qword [rbp-3880]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_379:
	mov qword [rbp-952], rax
	mov rax, qword [rbp-576]
	sub rax, 1
	mov r13, rax
	mov r12, r14
	mov r15, rbx
	l_380:
	cmp r12, r13
	jl l_381
	l_382:
	mov rax, r15
	jmp l_383
	l_381:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2568], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4344], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-4344]
	mov rsi, rax
	mov rax, qword [rbp-2568]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_383:
	mov qword [rbp-3472], rax
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov r12, rbx
	mov rax, qword [rbp-576]
	mov rbx, rax
	l_384:
	cmp r12, r13
	jl l_385
	l_386:
	mov rax, rbx
	jmp l_387
	l_385:
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_387:
	mov rcx, rax
	mov rdx, qword [rbp-952]
	mov r14, rdx
	mov rdx, qword [rbp-3472]
	mov rbx, rdx
	mov r12, rcx
	l_388:
	cmp rbx, r14
	jl l_389
	l_390:
	jmp l_391
	l_389:
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_391:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_375:
	mov qword [rbp-3704], rax
	mov rax, qword [rbp-168]
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-3520]
	mov qword [rbp-3816], rax
	mov rax, qword [rbp-2960]
	mov r14, rax
	l_392:
	mov rax, qword [rbp-3816]
	cmp rax, r12
	jl l_393
	l_394:
	mov rax, r14
	jmp l_395
	l_393:
	mov rax, r12
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-3816]
	mov rbx, rax
	mov r15, r14
	l_396:
	cmp rbx, r13
	jl l_397
	l_398:
	mov rax, r15
	jmp l_399
	l_397:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3368], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1048], rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1048]
	mov rsi, rax
	mov rax, qword [rbp-3368]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_399:
	mov qword [rbp-1392], rax
	mov rax, qword [rbp-3816]
	sub rax, 1
	mov r15, rax
	mov rbx, r14
	mov r13, r12
	l_400:
	cmp rbx, r15
	jl l_401
	l_402:
	mov rax, r13
	jmp l_403
	l_401:
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1000], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1864], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1864]
	mov rsi, rax
	mov rax, qword [rbp-1000]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_403:
	mov qword [rbp-640], rax
	mov rax, r14
	sub rax, 1
	mov r14, rax
	mov rbx, r12
	mov rax, qword [rbp-3816]
	mov r13, rax
	l_404:
	cmp rbx, r14
	jl l_405
	l_406:
	mov rax, r13
	jmp l_407
	l_405:
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_407:
	mov rdx, rax
	mov rcx, qword [rbp-1392]
	mov r14, rcx
	mov rcx, qword [rbp-640]
	mov r15, rcx
	mov r13, rdx
	l_408:
	cmp r15, r14
	jl l_409
	l_410:
	jmp l_411
	l_409:
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_411:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_395:
	mov rdx, rax
	mov rcx, qword [rbp-1536]
	mov r13, rcx
	mov rcx, qword [rbp-3704]
	mov r12, rcx
	mov rcx, rdx
	mov qword [rbp-904], rcx
	l_412:
	cmp r12, r13
	jl l_413
	l_414:
	jmp l_415
	l_413:
	mov rcx, r13
	sub rcx, 1
	mov rbx, rcx
	mov r14, r12
	mov rcx, qword [rbp-904]
	mov r15, rcx
	l_416:
	cmp r14, rbx
	jl l_417
	l_418:
	jmp l_419
	l_417:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-64], rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2264], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2264]
	mov rsi, rax
	mov rax, qword [rbp-64]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_419:
	mov qword [rbp-936], rax
	mov rax, r12
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-904]
	mov r14, rax
	mov r15, r13
	l_420:
	cmp r14, rbx
	jl l_421
	l_422:
	mov rax, r15
	jmp l_423
	l_421:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4272], rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3792], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3792]
	mov rsi, rax
	mov rax, qword [rbp-4272]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_423:
	mov qword [rbp-2984], rax
	mov rax, qword [rbp-904]
	sub rax, 1
	mov rbx, rax
	mov r14, r13
	mov r15, r12
	l_424:
	cmp r14, rbx
	jl l_425
	l_426:
	mov rax, r15
	jmp l_427
	l_425:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_427:
	mov rdx, rax
	mov rcx, qword [rbp-936]
	mov r14, rcx
	mov rcx, qword [rbp-2984]
	mov rbx, rcx
	mov r15, rdx
	l_428:
	cmp rbx, r14
	jl l_429
	l_430:
	jmp l_431
	l_429:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_431:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_415:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_351:
	mov qword [rbp-3168], rax
	mov rax, qword [rbp-464]
	sub rax, 1
	mov qword [rbp-1016], rax
	mov rax, qword [rbp-1976]
	mov qword [rbp-1320], rax
	mov rax, qword [rbp-3568]
	mov qword [rbp-2872], rax
	l_432:
	mov rax, qword [rbp-1320]
	mov rcx, qword [rbp-1016]
	cmp rax, rcx
	jl l_433
	l_434:
	mov rax, qword [rbp-2872]
	jmp l_435
	l_433:
	mov rax, qword [rbp-1016]
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-1320]
	mov qword [rbp-536], rax
	mov rax, qword [rbp-2872]
	mov r14, rax
	l_436:
	mov rax, qword [rbp-536]
	cmp rax, rbx
	jl l_437
	l_438:
	mov rax, r14
	jmp l_439
	l_437:
	mov rax, rbx
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-536]
	mov r13, rax
	mov r15, r14
	l_440:
	cmp r13, r12
	jl l_441
	l_442:
	mov rax, r15
	jmp l_443
	l_441:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2312], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-160], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-160]
	mov rsi, rax
	mov rax, qword [rbp-2312]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_443:
	mov qword [rbp-120], rax
	mov rax, qword [rbp-536]
	sub rax, 1
	mov r13, rax
	mov r12, r14
	mov r15, rbx
	l_444:
	cmp r12, r13
	jl l_445
	l_446:
	mov rax, r15
	jmp l_447
	l_445:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4072], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3544], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3544]
	mov rsi, rax
	mov rax, qword [rbp-4072]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_447:
	mov qword [rbp-1600], rax
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-536]
	mov r14, rax
	l_448:
	cmp rbx, r13
	jl l_449
	l_450:
	mov rax, r14
	jmp l_451
	l_449:
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_451:
	mov rdx, rax
	mov rcx, qword [rbp-120]
	mov r12, rcx
	mov rcx, qword [rbp-1600]
	mov rbx, rcx
	mov r13, rdx
	l_452:
	cmp rbx, r12
	jl l_453
	l_454:
	jmp l_455
	l_453:
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_455:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_439:
	mov qword [rbp-808], rax
	mov rax, qword [rbp-1320]
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-2872]
	mov qword [rbp-4024], rax
	mov rax, qword [rbp-1016]
	mov rbx, rax
	l_456:
	mov rax, qword [rbp-4024]
	cmp rax, r14
	jl l_457
	l_458:
	mov rax, rbx
	jmp l_459
	l_457:
	mov rax, r14
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-4024]
	mov r15, rax
	mov r13, rbx
	l_460:
	cmp r15, r12
	jl l_461
	l_462:
	mov rax, r13
	jmp l_463
	l_461:
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3528], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4224], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-4224]
	mov rsi, rax
	mov rax, qword [rbp-3528]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_463:
	mov qword [rbp-984], rax
	mov rax, qword [rbp-4024]
	sub rax, 1
	mov r13, rax
	mov r12, rbx
	mov r15, r14
	l_464:
	cmp r12, r13
	jl l_465
	l_466:
	mov rax, r15
	jmp l_467
	l_465:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2760], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-240], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-240]
	mov rsi, rax
	mov rax, qword [rbp-2760]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_467:
	mov qword [rbp-4256], rax
	mov rax, rbx
	sub rax, 1
	mov rbx, rax
	mov r13, r14
	mov rax, qword [rbp-4024]
	mov r15, rax
	l_468:
	cmp r13, rbx
	jl l_469
	l_470:
	mov rax, r15
	jmp l_471
	l_469:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_471:
	mov rdx, rax
	mov rcx, qword [rbp-984]
	mov r14, rcx
	mov rcx, qword [rbp-4256]
	mov rbx, rcx
	mov r12, rdx
	l_472:
	cmp rbx, r14
	jl l_473
	l_474:
	jmp l_475
	l_473:
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_475:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_459:
	mov qword [rbp-3096], rax
	mov rax, qword [rbp-2872]
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-1016]
	mov qword [rbp-2720], rax
	mov rax, qword [rbp-1320]
	mov rbx, rax
	l_476:
	mov rax, qword [rbp-2720]
	cmp rax, r14
	jl l_477
	l_478:
	mov rax, rbx
	jmp l_479
	l_477:
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-2720]
	mov r12, rax
	mov r15, rbx
	l_480:
	cmp r12, r13
	jl l_481
	l_482:
	mov rax, r15
	jmp l_483
	l_481:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-784], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3496], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3496]
	mov rsi, rax
	mov rax, qword [rbp-784]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_483:
	mov qword [rbp-520], rax
	mov rax, qword [rbp-2720]
	sub rax, 1
	mov r12, rax
	mov r15, rbx
	mov r13, r14
	l_484:
	cmp r15, r12
	jl l_485
	l_486:
	mov rax, r13
	jmp l_487
	l_485:
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-408], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1408], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1408]
	mov rsi, rax
	mov rax, qword [rbp-408]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_487:
	mov qword [rbp-3648], rax
	mov rax, rbx
	sub rax, 1
	mov rbx, rax
	mov r15, r14
	mov rax, qword [rbp-2720]
	mov r12, rax
	l_488:
	cmp r15, rbx
	jl l_489
	l_490:
	mov rax, r12
	jmp l_491
	l_489:
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_491:
	mov rdx, rax
	mov rcx, qword [rbp-520]
	mov r14, rcx
	mov rcx, qword [rbp-3648]
	mov r12, rcx
	mov rbx, rdx
	l_492:
	cmp r12, r14
	jl l_493
	l_494:
	jmp l_495
	l_493:
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_495:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_479:
	mov rdx, rax
	mov rcx, qword [rbp-808]
	mov r12, rcx
	mov rcx, qword [rbp-3096]
	mov rbx, rcx
	mov rcx, rdx
	mov qword [rbp-2696], rcx
	l_496:
	cmp rbx, r12
	jl l_497
	l_498:
	jmp l_499
	l_497:
	mov rcx, r12
	sub rcx, 1
	mov r13, rcx
	mov r14, rbx
	mov rcx, qword [rbp-2696]
	mov r15, rcx
	l_500:
	cmp r14, r13
	jl l_501
	l_502:
	jmp l_503
	l_501:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-184], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4216], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-4216]
	mov rsi, rax
	mov rax, qword [rbp-184]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_503:
	mov qword [rbp-672], rax
	mov rax, rbx
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-2696]
	mov r13, rax
	mov r15, r12
	l_504:
	cmp r13, r14
	jl l_505
	l_506:
	mov rax, r15
	jmp l_507
	l_505:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1224], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2360], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2360]
	mov rsi, rax
	mov rax, qword [rbp-1224]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_507:
	mov qword [rbp-2336], rax
	mov rax, qword [rbp-2696]
	sub rax, 1
	mov r14, rax
	mov r13, r12
	mov r15, rbx
	l_508:
	cmp r13, r14
	jl l_509
	l_510:
	mov rax, r15
	jmp l_511
	l_509:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_511:
	mov rdx, rax
	mov rcx, qword [rbp-672]
	mov rbx, rcx
	mov rcx, qword [rbp-2336]
	mov r12, rcx
	mov r15, rdx
	l_512:
	cmp r12, rbx
	jl l_513
	l_514:
	jmp l_515
	l_513:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_515:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_499:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_435:
	mov qword [rbp-4288], rax
	mov rax, qword [rbp-1976]
	sub rax, 1
	mov qword [rbp-4096], rax
	mov rax, qword [rbp-3568]
	mov qword [rbp-3976], rax
	mov rax, qword [rbp-464]
	mov qword [rbp-3144], rax
	l_516:
	mov rax, qword [rbp-3976]
	mov rcx, qword [rbp-4096]
	cmp rax, rcx
	jl l_517
	l_518:
	mov rax, qword [rbp-3144]
	jmp l_519
	l_517:
	mov rax, qword [rbp-4096]
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-3976]
	mov qword [rbp-2472], rax
	mov rax, qword [rbp-3144]
	mov r14, rax
	l_520:
	mov rax, qword [rbp-2472]
	cmp rax, r12
	jl l_521
	l_522:
	mov rax, r14
	jmp l_523
	l_521:
	mov rax, r12
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-2472]
	mov r13, rax
	mov r15, r14
	l_524:
	cmp r13, rbx
	jl l_525
	l_526:
	mov rax, r15
	jmp l_527
	l_525:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-864], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2368], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2368]
	mov rsi, rax
	mov rax, qword [rbp-864]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_527:
	mov qword [rbp-2320], rax
	mov rax, qword [rbp-2472]
	sub rax, 1
	mov rbx, rax
	mov r13, r14
	mov r15, r12
	l_528:
	cmp r13, rbx
	jl l_529
	l_530:
	mov rax, r15
	jmp l_531
	l_529:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1208], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3288], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3288]
	mov rsi, rax
	mov rax, qword [rbp-1208]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_531:
	mov qword [rbp-2104], rax
	mov rax, r14
	sub rax, 1
	mov rbx, rax
	mov r13, r12
	mov rax, qword [rbp-2472]
	mov r15, rax
	l_532:
	cmp r13, rbx
	jl l_533
	l_534:
	mov rax, r15
	jmp l_535
	l_533:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_535:
	mov rdx, rax
	mov rcx, qword [rbp-2320]
	mov r14, rcx
	mov rcx, qword [rbp-2104]
	mov r13, rcx
	mov r15, rdx
	l_536:
	cmp r13, r14
	jl l_537
	l_538:
	jmp l_539
	l_537:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_539:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_523:
	mov qword [rbp-440], rax
	mov rax, qword [rbp-3976]
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-3144]
	mov qword [rbp-2352], rax
	mov rax, qword [rbp-4096]
	mov r13, rax
	l_540:
	mov rax, qword [rbp-2352]
	cmp rax, rbx
	jl l_541
	l_542:
	mov rax, r13
	jmp l_543
	l_541:
	mov rax, rbx
	sub rax, 1
	mov r15, rax
	mov rax, qword [rbp-2352]
	mov r12, rax
	mov r14, r13
	l_544:
	cmp r12, r15
	jl l_545
	l_546:
	mov rax, r14
	jmp l_547
	l_545:
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3456], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-136], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-136]
	mov rsi, rax
	mov rax, qword [rbp-3456]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_547:
	mov qword [rbp-1800], rax
	mov rax, qword [rbp-2352]
	sub rax, 1
	mov r14, rax
	mov r12, r13
	mov r15, rbx
	l_548:
	cmp r12, r14
	jl l_549
	l_550:
	mov rax, r15
	jmp l_551
	l_549:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2136], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3152], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3152]
	mov rsi, rax
	mov rax, qword [rbp-2136]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_551:
	mov qword [rbp-1232], rax
	mov rax, r13
	sub rax, 1
	mov r14, rax
	mov r12, rbx
	mov rax, qword [rbp-2352]
	mov r13, rax
	l_552:
	cmp r12, r14
	jl l_553
	l_554:
	mov rax, r13
	jmp l_555
	l_553:
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_555:
	mov rdx, rax
	mov rcx, qword [rbp-1800]
	mov r12, rcx
	mov rcx, qword [rbp-1232]
	mov r14, rcx
	mov r15, rdx
	l_556:
	cmp r14, r12
	jl l_557
	l_558:
	jmp l_559
	l_557:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_559:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_543:
	mov qword [rbp-2704], rax
	mov rax, qword [rbp-3144]
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-4096]
	mov qword [rbp-4176], rax
	mov rax, qword [rbp-3976]
	mov r14, rax
	l_560:
	mov rax, qword [rbp-4176]
	cmp rax, rbx
	jl l_561
	l_562:
	mov rax, r14
	jmp l_563
	l_561:
	mov rax, rbx
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-4176]
	mov r13, rax
	mov r15, r14
	l_564:
	cmp r13, r12
	jl l_565
	l_566:
	mov rax, r15
	jmp l_567
	l_565:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3848], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3680], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3680]
	mov rsi, rax
	mov rax, qword [rbp-3848]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_567:
	mov qword [rbp-472], rax
	mov rax, qword [rbp-4176]
	sub rax, 1
	mov r12, rax
	mov r15, r14
	mov r13, rbx
	l_568:
	cmp r15, r12
	jl l_569
	l_570:
	mov rax, r13
	jmp l_571
	l_569:
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-648], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1368], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1368]
	mov rsi, rax
	mov rax, qword [rbp-648]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_571:
	mov qword [rbp-2032], rax
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov r14, rbx
	mov rax, qword [rbp-4176]
	mov r15, rax
	l_572:
	cmp r14, r13
	jl l_573
	l_574:
	mov rax, r15
	jmp l_575
	l_573:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_575:
	mov rcx, rax
	mov rdx, qword [rbp-472]
	mov rbx, rdx
	mov rdx, qword [rbp-2032]
	mov r13, rdx
	mov r15, rcx
	l_576:
	cmp r13, rbx
	jl l_577
	l_578:
	jmp l_579
	l_577:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_579:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_563:
	mov rdx, rax
	mov rcx, qword [rbp-440]
	mov r15, rcx
	mov rcx, qword [rbp-2704]
	mov r12, rcx
	mov rcx, rdx
	mov qword [rbp-40], rcx
	l_580:
	cmp r12, r15
	jl l_581
	l_582:
	jmp l_583
	l_581:
	mov rcx, r15
	sub rcx, 1
	mov r13, rcx
	mov r14, r12
	mov rcx, qword [rbp-40]
	mov rbx, rcx
	l_584:
	cmp r14, r13
	jl l_585
	l_586:
	jmp l_587
	l_585:
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-816], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1768], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1768]
	mov rsi, rax
	mov rax, qword [rbp-816]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_587:
	mov qword [rbp-2768], rax
	mov rax, r12
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-40]
	mov r13, rax
	mov r14, r15
	l_588:
	cmp r13, rbx
	jl l_589
	l_590:
	mov rax, r14
	jmp l_591
	l_589:
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2416], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3408], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3408]
	mov rsi, rax
	mov rax, qword [rbp-2416]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_591:
	mov qword [rbp-1032], rax
	mov rax, qword [rbp-40]
	sub rax, 1
	mov rbx, rax
	mov r13, r15
	mov r15, r12
	l_592:
	cmp r13, rbx
	jl l_593
	l_594:
	mov rax, r15
	jmp l_595
	l_593:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_595:
	mov rcx, rax
	mov rdx, qword [rbp-2768]
	mov r14, rdx
	mov rdx, qword [rbp-1032]
	mov r12, rdx
	mov rbx, rcx
	l_596:
	cmp r12, r14
	jl l_597
	l_598:
	jmp l_599
	l_597:
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_599:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_583:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_519:
	mov rdx, rax
	mov rcx, qword [rbp-3168]
	mov qword [rbp-4120], rcx
	mov rcx, qword [rbp-4288]
	mov qword [rbp-496], rcx
	mov rcx, rdx
	mov qword [rbp-4368], rcx
	l_600:
	mov rcx, qword [rbp-496]
	mov rdx, qword [rbp-4120]
	cmp rcx, rdx
	jl l_601
	l_602:
	jmp l_603
	l_601:
	mov rcx, qword [rbp-4120]
	sub rcx, 1
	mov rbx, rcx
	mov rcx, qword [rbp-496]
	mov r14, rcx
	mov rcx, qword [rbp-4368]
	mov qword [rbp-72], rcx
	l_604:
	cmp r14, rbx
	jl l_605
	l_606:
	jmp l_607
	l_605:
	mov rcx, rbx
	sub rcx, 1
	mov r12, rcx
	mov r13, r14
	mov rcx, qword [rbp-72]
	mov r15, rcx
	l_608:
	cmp r13, r12
	jl l_609
	l_610:
	jmp l_611
	l_609:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1960], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-216], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-216]
	mov rsi, rax
	mov rax, qword [rbp-1960]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_611:
	mov qword [rbp-2000], rax
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-72]
	mov r15, rax
	mov r12, rbx
	l_612:
	cmp r15, r13
	jl l_613
	l_614:
	mov rax, r12
	jmp l_615
	l_613:
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-608], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2832], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2832]
	mov rsi, rax
	mov rax, qword [rbp-608]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_615:
	mov qword [rbp-2152], rax
	mov rax, qword [rbp-72]
	sub rax, 1
	mov r13, rax
	mov r15, r14
	l_616:
	cmp rbx, r13
	jl l_617
	l_618:
	mov rax, r15
	jmp l_619
	l_617:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_619:
	mov rcx, rax
	mov rdx, qword [rbp-2000]
	mov rbx, rdx
	mov rdx, qword [rbp-2152]
	mov r14, rdx
	mov r12, rcx
	l_620:
	cmp r14, rbx
	jl l_621
	l_622:
	jmp l_623
	l_621:
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_623:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_607:
	mov qword [rbp-4312], rax
	mov rax, qword [rbp-496]
	sub rax, 1
	mov r15, rax
	mov rax, qword [rbp-4368]
	mov qword [rbp-3768], rax
	mov rax, qword [rbp-4120]
	mov r12, rax
	l_624:
	mov rax, qword [rbp-3768]
	cmp rax, r15
	jl l_625
	l_626:
	mov rax, r12
	jmp l_627
	l_625:
	mov rax, r15
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-3768]
	mov r14, rax
	mov r13, r12
	l_628:
	cmp r14, rbx
	jl l_629
	l_630:
	mov rax, r13
	jmp l_631
	l_629:
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3296], rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-344], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-344]
	mov rsi, rax
	mov rax, qword [rbp-3296]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_631:
	mov qword [rbp-1552], rax
	mov rax, qword [rbp-3768]
	sub rax, 1
	mov r13, rax
	mov rbx, r12
	mov r14, r15
	l_632:
	cmp rbx, r13
	jl l_633
	l_634:
	mov rax, r14
	jmp l_635
	l_633:
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1688], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3400], rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3400]
	mov rsi, rax
	mov rax, qword [rbp-1688]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_635:
	mov qword [rbp-2056], rax
	mov rax, r12
	sub rax, 1
	mov rbx, rax
	mov r14, r15
	mov rax, qword [rbp-3768]
	mov r15, rax
	l_636:
	cmp r14, rbx
	jl l_637
	l_638:
	mov rax, r15
	jmp l_639
	l_637:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_639:
	mov rdx, rax
	mov rcx, qword [rbp-1552]
	mov rbx, rcx
	mov rcx, qword [rbp-2056]
	mov r13, rcx
	mov r12, rdx
	l_640:
	cmp r13, rbx
	jl l_641
	l_642:
	jmp l_643
	l_641:
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_643:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_627:
	mov qword [rbp-4424], rax
	mov rax, qword [rbp-4368]
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-4120]
	mov qword [rbp-1200], rax
	mov rax, qword [rbp-496]
	mov r14, rax
	l_644:
	mov rax, qword [rbp-1200]
	cmp rax, rbx
	jl l_645
	l_646:
	mov rax, r14
	jmp l_647
	l_645:
	mov rax, rbx
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-1200]
	mov r13, rax
	mov r15, r14
	l_648:
	cmp r13, r12
	jl l_649
	l_650:
	mov rax, r15
	jmp l_651
	l_649:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2112], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2816], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2816]
	mov rsi, rax
	mov rax, qword [rbp-2112]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_651:
	mov qword [rbp-656], rax
	mov rax, qword [rbp-1200]
	sub rax, 1
	mov r15, rax
	mov r13, r14
	mov r12, rbx
	l_652:
	cmp r13, r15
	jl l_653
	l_654:
	mov rax, r12
	jmp l_655
	l_653:
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-248], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2736], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2736]
	mov rsi, rax
	mov rax, qword [rbp-248]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_655:
	mov qword [rbp-3440], rax
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov r14, rbx
	mov rax, qword [rbp-1200]
	mov r15, rax
	l_656:
	cmp r14, r13
	jl l_657
	l_658:
	mov rax, r15
	jmp l_659
	l_657:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_659:
	mov rdx, rax
	mov rcx, qword [rbp-656]
	mov r14, rcx
	mov rcx, qword [rbp-3440]
	mov r13, rcx
	mov rbx, rdx
	l_660:
	cmp r13, r14
	jl l_661
	l_662:
	jmp l_663
	l_661:
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_663:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_647:
	mov rdx, rax
	mov rcx, qword [rbp-4312]
	mov rbx, rcx
	mov rcx, qword [rbp-4424]
	mov r14, rcx
	mov rcx, rdx
	mov qword [rbp-2392], rcx
	l_664:
	cmp r14, rbx
	jl l_665
	l_666:
	jmp l_667
	l_665:
	mov rcx, rbx
	sub rcx, 1
	mov r13, rcx
	mov r15, r14
	mov rcx, qword [rbp-2392]
	mov r12, rcx
	l_668:
	cmp r15, r13
	jl l_669
	l_670:
	jmp l_671
	l_669:
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3240], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3216], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3216]
	mov rsi, rax
	mov rax, qword [rbp-3240]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_671:
	mov qword [rbp-3024], rax
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-2392]
	mov r15, rax
	mov r12, rbx
	l_672:
	cmp r15, r13
	jl l_673
	l_674:
	mov rax, r12
	jmp l_675
	l_673:
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2344], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3480], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3480]
	mov rsi, rax
	mov rax, qword [rbp-2344]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_675:
	mov qword [rbp-144], rax
	mov rax, qword [rbp-2392]
	sub rax, 1
	mov r12, rax
	mov r13, rbx
	mov r15, r14
	l_676:
	cmp r13, r12
	jl l_677
	l_678:
	mov rax, r15
	jmp l_679
	l_677:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_679:
	mov rdx, rax
	mov rcx, qword [rbp-3024]
	mov r13, rcx
	mov rcx, qword [rbp-144]
	mov rbx, rcx
	mov r14, rdx
	l_680:
	cmp rbx, r13
	jl l_681
	l_682:
	jmp l_683
	l_681:
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_683:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_667:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_603:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_347:
	mov qword [rbp-16], rax
	mov rax, qword [rbp-3264]
	sub rax, 1
	mov qword [rbp-1848], rax
	mov rax, qword [rbp-288]
	mov qword [rbp-712], rax
	mov rax, qword [rbp-1736]
	mov qword [rbp-2544], rax
	l_684:
	mov rax, qword [rbp-712]
	mov rcx, qword [rbp-1848]
	cmp rax, rcx
	jl l_685
	l_686:
	mov rax, qword [rbp-2544]
	jmp l_687
	l_685:
	mov rax, qword [rbp-1848]
	sub rax, 1
	mov qword [rbp-2280], rax
	mov rax, qword [rbp-712]
	mov qword [rbp-3856], rax
	mov rax, qword [rbp-2544]
	mov qword [rbp-1008], rax
	l_688:
	mov rcx, qword [rbp-3856]
	mov rax, qword [rbp-2280]
	cmp rcx, rax
	jl l_689
	l_690:
	mov rax, qword [rbp-1008]
	jmp l_691
	l_689:
	mov rax, qword [rbp-2280]
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-3856]
	mov qword [rbp-2016], rax
	mov rax, qword [rbp-1008]
	mov rbx, rax
	l_692:
	mov rax, qword [rbp-2016]
	cmp rax, r14
	jl l_693
	l_694:
	mov rax, rbx
	jmp l_695
	l_693:
	mov rax, r14
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-2016]
	mov r13, rax
	mov r15, rbx
	l_696:
	cmp r13, r12
	jl l_697
	l_698:
	mov rax, r15
	jmp l_699
	l_697:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1568], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1680], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1680]
	mov rsi, rax
	mov rax, qword [rbp-1568]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_699:
	mov qword [rbp-416], rax
	mov rax, qword [rbp-2016]
	sub rax, 1
	mov r12, rax
	mov r13, rbx
	mov r15, r14
	l_700:
	cmp r13, r12
	jl l_701
	l_702:
	mov rax, r15
	jmp l_703
	l_701:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3824], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1064], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1064]
	mov rsi, rax
	mov rax, qword [rbp-3824]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_703:
	mov qword [rbp-2240], rax
	mov rax, rbx
	sub rax, 1
	mov rbx, rax
	mov r13, r14
	mov rax, qword [rbp-2016]
	mov r14, rax
	l_704:
	cmp r13, rbx
	jl l_705
	l_706:
	mov rax, r14
	jmp l_707
	l_705:
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_707:
	mov rcx, rax
	mov rdx, qword [rbp-416]
	mov rbx, rdx
	mov rdx, qword [rbp-2240]
	mov r12, rdx
	mov r15, rcx
	l_708:
	cmp r12, rbx
	jl l_709
	l_710:
	jmp l_711
	l_709:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_711:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_695:
	mov qword [rbp-704], rax
	mov rax, qword [rbp-3856]
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-1008]
	mov qword [rbp-2632], rax
	mov rax, qword [rbp-2280]
	mov rbx, rax
	l_712:
	mov rax, qword [rbp-2632]
	cmp rax, r14
	jl l_713
	l_714:
	mov rax, rbx
	jmp l_715
	l_713:
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-2632]
	mov r12, rax
	mov r15, rbx
	l_716:
	cmp r12, r13
	jl l_717
	l_718:
	mov rax, r15
	jmp l_719
	l_717:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2488], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4232], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-4232]
	mov rsi, rax
	mov rax, qword [rbp-2488]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_719:
	mov qword [rbp-2464], rax
	mov rax, qword [rbp-2632]
	sub rax, 1
	mov r13, rax
	mov r15, rbx
	mov r12, r14
	l_720:
	cmp r15, r13
	jl l_721
	l_722:
	mov rax, r12
	jmp l_723
	l_721:
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-384], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1096], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1096]
	mov rsi, rax
	mov rax, qword [rbp-384]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_723:
	mov qword [rbp-544], rax
	mov rax, rbx
	sub rax, 1
	mov r12, rax
	mov rbx, r14
	mov rax, qword [rbp-2632]
	mov r15, rax
	l_724:
	cmp rbx, r12
	jl l_725
	l_726:
	mov rax, r15
	jmp l_727
	l_725:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_727:
	mov rdx, rax
	mov rcx, qword [rbp-2464]
	mov r13, rcx
	mov rcx, qword [rbp-544]
	mov r15, rcx
	mov rbx, rdx
	l_728:
	cmp r15, r13
	jl l_729
	l_730:
	jmp l_731
	l_729:
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_731:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_715:
	mov qword [rbp-1024], rax
	mov rax, qword [rbp-1008]
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-2280]
	mov qword [rbp-3080], rax
	mov rax, qword [rbp-3856]
	mov rbx, rax
	l_732:
	mov rax, qword [rbp-3080]
	cmp rax, r13
	jl l_733
	l_734:
	mov rax, rbx
	jmp l_735
	l_733:
	mov rax, r13
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-3080]
	mov r15, rax
	mov r12, rbx
	l_736:
	cmp r15, r14
	jl l_737
	l_738:
	mov rax, r12
	jmp l_739
	l_737:
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-912], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1752], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1752]
	mov rsi, rax
	mov rax, qword [rbp-912]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_739:
	mov qword [rbp-1592], rax
	mov rax, qword [rbp-3080]
	sub rax, 1
	mov r12, rax
	mov r14, rbx
	mov r15, r13
	l_740:
	cmp r14, r12
	jl l_741
	l_742:
	mov rax, r15
	jmp l_743
	l_741:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-88], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3304], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3304]
	mov rsi, rax
	mov rax, qword [rbp-88]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_743:
	mov qword [rbp-1584], rax
	mov rax, rbx
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-3080]
	mov r15, rax
	l_744:
	cmp r13, r12
	jl l_745
	l_746:
	mov rax, r15
	jmp l_747
	l_745:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_747:
	mov rdx, rax
	mov rcx, qword [rbp-1592]
	mov r14, rcx
	mov rcx, qword [rbp-1584]
	mov r15, rcx
	mov r12, rdx
	l_748:
	cmp r15, r14
	jl l_749
	l_750:
	jmp l_751
	l_749:
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_751:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_735:
	mov rdx, rax
	mov rcx, qword [rbp-704]
	mov r12, rcx
	mov rcx, qword [rbp-1024]
	mov r14, rcx
	mov rcx, rdx
	mov qword [rbp-2512], rcx
	l_752:
	cmp r14, r12
	jl l_753
	l_754:
	jmp l_755
	l_753:
	mov rcx, r12
	sub rcx, 1
	mov r15, rcx
	mov rbx, r14
	mov rcx, qword [rbp-2512]
	mov r13, rcx
	l_756:
	cmp rbx, r15
	jl l_757
	l_758:
	jmp l_759
	l_757:
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2192], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1936], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1936]
	mov rsi, rax
	mov rax, qword [rbp-2192]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_759:
	mov qword [rbp-4136], rax
	mov rax, r14
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-2512]
	mov r13, rax
	mov r15, r12
	l_760:
	cmp r13, rbx
	jl l_761
	l_762:
	mov rax, r15
	jmp l_763
	l_761:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-176], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1456], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1456]
	mov rsi, rax
	mov rax, qword [rbp-176]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_763:
	mov qword [rbp-2904], rax
	mov rax, qword [rbp-2512]
	sub rax, 1
	mov rbx, rax
	mov r15, r14
	l_764:
	cmp r12, rbx
	jl l_765
	l_766:
	mov rax, r15
	jmp l_767
	l_765:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_767:
	mov rdx, rax
	mov rcx, qword [rbp-4136]
	mov r13, rcx
	mov rcx, qword [rbp-2904]
	mov rbx, rcx
	mov r15, rdx
	l_768:
	cmp rbx, r13
	jl l_769
	l_770:
	jmp l_771
	l_769:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_771:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_755:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_691:
	mov qword [rbp-4416], rax
	mov rax, qword [rbp-712]
	sub rax, 1
	mov qword [rbp-1080], rax
	mov rax, qword [rbp-2544]
	mov qword [rbp-480], rax
	mov rax, qword [rbp-1848]
	mov qword [rbp-1528], rax
	l_772:
	mov rcx, qword [rbp-480]
	mov rax, qword [rbp-1080]
	cmp rcx, rax
	jl l_773
	l_774:
	mov rax, qword [rbp-1528]
	jmp l_775
	l_773:
	mov rax, qword [rbp-1080]
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-480]
	mov qword [rbp-2688], rax
	mov rax, qword [rbp-1528]
	mov r13, rax
	l_776:
	mov rax, qword [rbp-2688]
	cmp rax, r14
	jl l_777
	l_778:
	mov rax, r13
	jmp l_779
	l_777:
	mov rax, r14
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-2688]
	mov r15, rax
	mov r12, r13
	l_780:
	cmp r15, rbx
	jl l_781
	l_782:
	mov rax, r12
	jmp l_783
	l_781:
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2752], rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1432], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1432]
	mov rsi, rax
	mov rax, qword [rbp-2752]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_783:
	mov qword [rbp-2536], rax
	mov rax, qword [rbp-2688]
	sub rax, 1
	mov r12, rax
	mov rbx, r13
	mov r15, r14
	l_784:
	cmp rbx, r12
	jl l_785
	l_786:
	mov rax, r15
	jmp l_787
	l_785:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3088], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3200], rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3200]
	mov rsi, rax
	mov rax, qword [rbp-3088]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_787:
	mov qword [rbp-584], rax
	mov rax, r13
	sub rax, 1
	mov rbx, rax
	mov r12, r14
	mov rax, qword [rbp-2688]
	mov r13, rax
	l_788:
	cmp r12, rbx
	jl l_789
	l_790:
	mov rax, r13
	jmp l_791
	l_789:
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_791:
	mov rdx, rax
	mov rcx, qword [rbp-2536]
	mov rbx, rcx
	mov rcx, qword [rbp-584]
	mov r13, rcx
	mov r12, rdx
	l_792:
	cmp r13, rbx
	jl l_793
	l_794:
	jmp l_795
	l_793:
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_795:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_779:
	mov qword [rbp-3912], rax
	mov rax, qword [rbp-480]
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-1528]
	mov qword [rbp-2912], rax
	mov rax, qword [rbp-1080]
	mov r14, rax
	l_796:
	mov rax, qword [rbp-2912]
	cmp rax, r12
	jl l_797
	l_798:
	mov rax, r14
	jmp l_799
	l_797:
	mov rax, r12
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-2912]
	mov rbx, rax
	mov r15, r14
	l_800:
	cmp rbx, r13
	jl l_801
	l_802:
	mov rax, r15
	jmp l_803
	l_801:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-80], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3920], rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3920]
	mov rsi, rax
	mov rax, qword [rbp-80]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_803:
	mov qword [rbp-4040], rax
	mov rax, qword [rbp-2912]
	sub rax, 1
	mov r13, rax
	mov rbx, r14
	mov r15, r12
	l_804:
	cmp rbx, r13
	jl l_805
	l_806:
	mov rax, r15
	jmp l_807
	l_805:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1136], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1120], rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1120]
	mov rsi, rax
	mov rax, qword [rbp-1136]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_807:
	mov qword [rbp-840], rax
	mov rax, r14
	sub rax, 1
	mov r14, rax
	mov rbx, r12
	mov rax, qword [rbp-2912]
	mov r13, rax
	l_808:
	cmp rbx, r14
	jl l_809
	l_810:
	mov rax, r13
	jmp l_811
	l_809:
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_811:
	mov rdx, rax
	mov rcx, qword [rbp-4040]
	mov r14, rcx
	mov rcx, qword [rbp-840]
	mov r12, rcx
	mov rbx, rdx
	l_812:
	cmp r12, r14
	jl l_813
	l_814:
	jmp l_815
	l_813:
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_815:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_799:
	mov qword [rbp-1328], rax
	mov rax, qword [rbp-1528]
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-1080]
	mov qword [rbp-1352], rax
	mov rax, qword [rbp-480]
	mov r13, rax
	l_816:
	mov rax, qword [rbp-1352]
	cmp rax, rbx
	jl l_817
	l_818:
	mov rax, r13
	jmp l_819
	l_817:
	mov rax, rbx
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-1352]
	mov r15, rax
	mov r12, r13
	l_820:
	cmp r15, r14
	jl l_821
	l_822:
	mov rax, r12
	jmp l_823
	l_821:
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2208], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2272], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2272]
	mov rsi, rax
	mov rax, qword [rbp-2208]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_823:
	mov qword [rbp-1784], rax
	mov rax, qword [rbp-1352]
	sub rax, 1
	mov r15, rax
	mov r12, r13
	mov r14, rbx
	l_824:
	cmp r12, r15
	jl l_825
	l_826:
	mov rax, r14
	jmp l_827
	l_825:
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3640], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-736], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-736]
	mov rsi, rax
	mov rax, qword [rbp-3640]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_827:
	mov qword [rbp-800], rax
	mov rax, r13
	sub rax, 1
	mov r13, rax
	mov r14, rbx
	mov rax, qword [rbp-1352]
	mov rbx, rax
	l_828:
	cmp r14, r13
	jl l_829
	l_830:
	mov rax, rbx
	jmp l_831
	l_829:
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_831:
	mov rdx, rax
	mov rcx, qword [rbp-1784]
	mov r14, rcx
	mov rcx, qword [rbp-800]
	mov r13, rcx
	mov r15, rdx
	l_832:
	cmp r13, r14
	jl l_833
	l_834:
	jmp l_835
	l_833:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_835:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_819:
	mov rcx, rax
	mov rdx, qword [rbp-3912]
	mov r12, rdx
	mov rdx, qword [rbp-1328]
	mov rbx, rdx
	mov qword [rbp-1904], rcx
	l_836:
	cmp rbx, r12
	jl l_837
	l_838:
	jmp l_839
	l_837:
	mov rcx, r12
	sub rcx, 1
	mov r15, rcx
	mov r14, rbx
	mov rcx, qword [rbp-1904]
	mov r13, rcx
	l_840:
	cmp r14, r15
	jl l_841
	l_842:
	jmp l_843
	l_841:
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-24], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4376], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-4376]
	mov rsi, rax
	mov rax, qword [rbp-24]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_843:
	mov qword [rbp-1512], rax
	mov rax, rbx
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-1904]
	mov r14, rax
	mov r15, r12
	l_844:
	cmp r14, r13
	jl l_845
	l_846:
	mov rax, r15
	jmp l_847
	l_845:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2680], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3776], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3776]
	mov rsi, rax
	mov rax, qword [rbp-2680]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_847:
	mov qword [rbp-3584], rax
	mov rax, qword [rbp-1904]
	sub rax, 1
	mov r14, rax
	mov r13, r12
	mov r15, rbx
	l_848:
	cmp r13, r14
	jl l_849
	l_850:
	mov rax, r15
	jmp l_851
	l_849:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_851:
	mov rcx, rax
	mov rdx, qword [rbp-1512]
	mov r14, rdx
	mov rdx, qword [rbp-3584]
	mov r13, rdx
	mov r15, rcx
	l_852:
	cmp r13, r14
	jl l_853
	l_854:
	jmp l_855
	l_853:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_855:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_839:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_775:
	mov qword [rbp-104], rax
	mov rax, qword [rbp-2544]
	sub rax, 1
	mov qword [rbp-1808], rax
	mov rax, qword [rbp-1848]
	mov qword [rbp-568], rax
	mov rax, qword [rbp-712]
	mov qword [rbp-1760], rax
	l_856:
	mov rcx, qword [rbp-568]
	mov rax, qword [rbp-1808]
	cmp rcx, rax
	jl l_857
	l_858:
	mov rax, qword [rbp-1760]
	jmp l_859
	l_857:
	mov rax, qword [rbp-1808]
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-568]
	mov qword [rbp-272], rax
	mov rax, qword [rbp-1760]
	mov r14, rax
	l_860:
	mov rax, qword [rbp-272]
	cmp rax, rbx
	jl l_861
	l_862:
	mov rax, r14
	jmp l_863
	l_861:
	mov rax, rbx
	sub rax, 1
	mov r15, rax
	mov rax, qword [rbp-272]
	mov r12, rax
	mov r13, r14
	l_864:
	cmp r12, r15
	jl l_865
	l_866:
	mov rax, r13
	jmp l_867
	l_865:
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-928], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2064], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2064]
	mov rsi, rax
	mov rax, qword [rbp-928]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_867:
	mov qword [rbp-752], rax
	mov rax, qword [rbp-272]
	sub rax, 1
	mov r13, rax
	mov r12, r14
	mov r15, rbx
	l_868:
	cmp r12, r13
	jl l_869
	l_870:
	mov rax, r15
	jmp l_871
	l_869:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-368], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2744], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2744]
	mov rsi, rax
	mov rax, qword [rbp-368]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_871:
	mov qword [rbp-3184], rax
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov r12, rbx
	mov rax, qword [rbp-272]
	mov r15, rax
	l_872:
	cmp r12, r13
	jl l_873
	l_874:
	mov rax, r15
	jmp l_875
	l_873:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_875:
	mov rdx, rax
	mov rcx, qword [rbp-752]
	mov r14, rcx
	mov rcx, qword [rbp-3184]
	mov rbx, rcx
	mov r13, rdx
	l_876:
	cmp rbx, r14
	jl l_877
	l_878:
	jmp l_879
	l_877:
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_879:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_863:
	mov qword [rbp-2160], rax
	mov rax, qword [rbp-568]
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-1760]
	mov qword [rbp-624], rax
	mov rax, qword [rbp-1808]
	mov rbx, rax
	l_880:
	mov rax, qword [rbp-624]
	cmp rax, r12
	jl l_881
	l_882:
	mov rax, rbx
	jmp l_883
	l_881:
	mov rax, r12
	sub rax, 1
	mov r15, rax
	mov rax, qword [rbp-624]
	mov r13, rax
	mov r14, rbx
	l_884:
	cmp r13, r15
	jl l_885
	l_886:
	mov rax, r14
	jmp l_887
	l_885:
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3624], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4248], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-4248]
	mov rsi, rax
	mov rax, qword [rbp-3624]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_887:
	mov qword [rbp-848], rax
	mov rax, qword [rbp-624]
	sub rax, 1
	mov r15, rax
	mov r14, rbx
	mov r13, r12
	l_888:
	cmp r14, r15
	jl l_889
	l_890:
	mov rax, r13
	jmp l_891
	l_889:
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-432], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3840], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3840]
	mov rsi, rax
	mov rax, qword [rbp-432]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_891:
	mov qword [rbp-1656], rax
	mov rax, rbx
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-624]
	mov r15, rax
	l_892:
	cmp r12, r14
	jl l_893
	l_894:
	mov rax, r15
	jmp l_895
	l_893:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_895:
	mov rdx, rax
	mov rcx, qword [rbp-848]
	mov rbx, rcx
	mov rcx, qword [rbp-1656]
	mov r13, rcx
	mov r15, rdx
	l_896:
	cmp r13, rbx
	jl l_897
	l_898:
	jmp l_899
	l_897:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_899:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_883:
	mov qword [rbp-1360], rax
	mov rax, qword [rbp-1760]
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-1808]
	mov qword [rbp-1696], rax
	mov rax, qword [rbp-568]
	mov r14, rax
	l_900:
	mov rax, qword [rbp-1696]
	cmp rax, r12
	jl l_901
	l_902:
	mov rax, r14
	jmp l_903
	l_901:
	mov rax, r12
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-1696]
	mov r13, rax
	mov r15, r14
	l_904:
	cmp r13, rbx
	jl l_905
	l_906:
	mov rax, r15
	jmp l_907
	l_905:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3312], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1056], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1056]
	mov rsi, rax
	mov rax, qword [rbp-3312]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_907:
	mov qword [rbp-760], rax
	mov rax, qword [rbp-1696]
	sub rax, 1
	mov r15, rax
	mov rbx, r14
	mov r13, r12
	l_908:
	cmp rbx, r15
	jl l_909
	l_910:
	mov rax, r13
	jmp l_911
	l_909:
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1480], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1400], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1400]
	mov rsi, rax
	mov rax, qword [rbp-1480]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_911:
	mov qword [rbp-1344], rax
	mov rax, r14
	sub rax, 1
	mov rbx, rax
	mov r13, r12
	mov rax, qword [rbp-1696]
	mov r14, rax
	l_912:
	cmp r13, rbx
	jl l_913
	l_914:
	mov rax, r14
	jmp l_915
	l_913:
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_915:
	mov rdx, rax
	mov rcx, qword [rbp-760]
	mov r13, rcx
	mov rcx, qword [rbp-1344]
	mov r14, rcx
	mov rbx, rdx
	l_916:
	cmp r14, r13
	jl l_917
	l_918:
	jmp l_919
	l_917:
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_919:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_903:
	mov rdx, rax
	mov rcx, qword [rbp-2160]
	mov r14, rcx
	mov rcx, qword [rbp-1360]
	mov rbx, rcx
	mov rcx, rdx
	mov qword [rbp-1920], rcx
	l_920:
	cmp rbx, r14
	jl l_921
	l_922:
	jmp l_923
	l_921:
	mov rcx, r14
	sub rcx, 1
	mov r13, rcx
	mov r12, rbx
	mov rcx, qword [rbp-1920]
	mov r15, rcx
	l_924:
	cmp r12, r13
	jl l_925
	l_926:
	jmp l_927
	l_925:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2096], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1312], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1312]
	mov rsi, rax
	mov rax, qword [rbp-2096]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_927:
	mov qword [rbp-2672], rax
	mov rax, rbx
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-1920]
	mov r15, rax
	mov r12, r14
	l_928:
	cmp r15, r13
	jl l_929
	l_930:
	mov rax, r12
	jmp l_931
	l_929:
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3056], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3560], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3560]
	mov rsi, rax
	mov rax, qword [rbp-3056]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_931:
	mov qword [rbp-3208], rax
	mov rax, qword [rbp-1920]
	sub rax, 1
	mov r12, rax
	mov r15, rbx
	l_932:
	cmp r14, r12
	jl l_933
	l_934:
	mov rax, r15
	jmp l_935
	l_933:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_935:
	mov rcx, rax
	mov rdx, qword [rbp-2672]
	mov r14, rdx
	mov rdx, qword [rbp-3208]
	mov r13, rdx
	mov r12, rcx
	l_936:
	cmp r13, r14
	jl l_937
	l_938:
	jmp l_939
	l_937:
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_939:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_923:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_859:
	mov rdx, rax
	mov rcx, qword [rbp-4416]
	mov qword [rbp-448], rcx
	mov rcx, qword [rbp-104]
	mov qword [rbp-4384], rcx
	mov rcx, rdx
	mov qword [rbp-1440], rcx
	l_940:
	mov rcx, qword [rbp-4384]
	mov rdx, qword [rbp-448]
	cmp rcx, rdx
	jl l_941
	l_942:
	jmp l_943
	l_941:
	mov rcx, qword [rbp-448]
	sub rcx, 1
	mov r14, rcx
	mov rcx, qword [rbp-4384]
	mov rbx, rcx
	mov rcx, qword [rbp-1440]
	mov qword [rbp-1280], rcx
	l_944:
	cmp rbx, r14
	jl l_945
	l_946:
	jmp l_947
	l_945:
	mov rcx, r14
	sub rcx, 1
	mov r13, rcx
	mov r15, rbx
	mov rcx, qword [rbp-1280]
	mov r12, rcx
	l_948:
	cmp r15, r13
	jl l_949
	l_950:
	jmp l_951
	l_949:
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3392], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3192], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3192]
	mov rsi, rax
	mov rax, qword [rbp-3392]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_951:
	mov qword [rbp-896], rax
	mov rax, rbx
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-1280]
	mov r12, rax
	mov r15, r14
	l_952:
	cmp r12, r13
	jl l_953
	l_954:
	mov rax, r15
	jmp l_955
	l_953:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4048], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1776], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1776]
	mov rsi, rax
	mov rax, qword [rbp-4048]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_955:
	mov qword [rbp-680], rax
	mov rax, qword [rbp-1280]
	sub rax, 1
	mov r12, rax
	mov r13, r14
	mov r14, rbx
	l_956:
	cmp r13, r12
	jl l_957
	l_958:
	mov rax, r14
	jmp l_959
	l_957:
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_959:
	mov rdx, rax
	mov rcx, qword [rbp-896]
	mov r14, rcx
	mov rcx, qword [rbp-680]
	mov r15, rcx
	mov r12, rdx
	l_960:
	cmp r15, r14
	jl l_961
	l_962:
	jmp l_963
	l_961:
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_963:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_947:
	mov qword [rbp-3632], rax
	mov rax, qword [rbp-4384]
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-1440]
	mov qword [rbp-2256], rax
	mov rax, qword [rbp-448]
	mov r14, rax
	l_964:
	mov rax, qword [rbp-2256]
	cmp rax, r12
	jl l_965
	l_966:
	mov rax, r14
	jmp l_967
	l_965:
	mov rax, r12
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-2256]
	mov rbx, rax
	mov r15, r14
	l_968:
	cmp rbx, r13
	jl l_969
	l_970:
	mov rax, r15
	jmp l_971
	l_969:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2216], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3032], rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3032]
	mov rsi, rax
	mov rax, qword [rbp-2216]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_971:
	mov qword [rbp-1160], rax
	mov rax, qword [rbp-2256]
	sub rax, 1
	mov r15, rax
	mov r13, r14
	mov rbx, r12
	l_972:
	cmp r13, r15
	jl l_973
	l_974:
	mov rax, rbx
	jmp l_975
	l_973:
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3592], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3832], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3832]
	mov rsi, rax
	mov rax, qword [rbp-3592]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_975:
	mov qword [rbp-1744], rax
	mov rax, r14
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-2256]
	mov r13, rax
	l_976:
	cmp r12, rbx
	jl l_977
	l_978:
	mov rax, r13
	jmp l_979
	l_977:
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_979:
	mov rdx, rax
	mov rcx, qword [rbp-1160]
	mov rbx, rcx
	mov rcx, qword [rbp-1744]
	mov r14, rcx
	mov r15, rdx
	l_980:
	cmp r14, rbx
	jl l_981
	l_982:
	jmp l_983
	l_981:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_983:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_967:
	mov qword [rbp-1248], rax
	mov rax, qword [rbp-1440]
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-448]
	mov qword [rbp-4304], rax
	mov rax, qword [rbp-4384]
	mov r14, rax
	l_984:
	mov rax, qword [rbp-4304]
	cmp rax, rbx
	jl l_985
	l_986:
	mov rax, r14
	jmp l_987
	l_985:
	mov rax, rbx
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-4304]
	mov r13, rax
	mov r15, r14
	l_988:
	cmp r13, r12
	jl l_989
	l_990:
	mov rax, r15
	jmp l_991
	l_989:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2896], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2944], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2944]
	mov rsi, rax
	mov rax, qword [rbp-2896]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_991:
	mov qword [rbp-3328], rax
	mov rax, qword [rbp-4304]
	sub rax, 1
	mov r13, rax
	mov r12, r14
	mov r15, rbx
	l_992:
	cmp r12, r13
	jl l_993
	l_994:
	mov rax, r15
	jmp l_995
	l_993:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1856], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2824], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2824]
	mov rsi, rax
	mov rax, qword [rbp-1856]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_995:
	mov qword [rbp-4328], rax
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov r12, rbx
	mov rax, qword [rbp-4304]
	mov rbx, rax
	l_996:
	cmp r12, r13
	jl l_997
	l_998:
	mov rax, rbx
	jmp l_999
	l_997:
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_999:
	mov rdx, rax
	mov rcx, qword [rbp-3328]
	mov r14, rcx
	mov rcx, qword [rbp-4328]
	mov r12, rcx
	mov r15, rdx
	l_1000:
	cmp r12, r14
	jl l_1001
	l_1002:
	jmp l_1003
	l_1001:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1003:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_987:
	mov rdx, rax
	mov rcx, qword [rbp-3632]
	mov rbx, rcx
	mov rcx, qword [rbp-1248]
	mov r14, rcx
	mov rcx, rdx
	mov qword [rbp-3504], rcx
	l_1004:
	cmp r14, rbx
	jl l_1005
	l_1006:
	jmp l_1007
	l_1005:
	mov rcx, rbx
	sub rcx, 1
	mov r12, rcx
	mov r15, r14
	mov rcx, qword [rbp-3504]
	mov r13, rcx
	l_1008:
	cmp r15, r12
	jl l_1009
	l_1010:
	jmp l_1011
	l_1009:
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1376], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3616], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3616]
	mov rsi, rax
	mov rax, qword [rbp-1376]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1011:
	mov qword [rbp-1968], rax
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-3504]
	mov r12, rax
	mov r15, rbx
	l_1012:
	cmp r12, r13
	jl l_1013
	l_1014:
	mov rax, r15
	jmp l_1015
	l_1013:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2592], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-224], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-224]
	mov rsi, rax
	mov rax, qword [rbp-2592]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1015:
	mov qword [rbp-2624], rax
	mov rax, qword [rbp-3504]
	sub rax, 1
	mov r13, rax
	mov r12, rbx
	mov r15, r14
	l_1016:
	cmp r12, r13
	jl l_1017
	l_1018:
	mov rax, r15
	jmp l_1019
	l_1017:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1019:
	mov rcx, rax
	mov rdx, qword [rbp-1968]
	mov r13, rdx
	mov rdx, qword [rbp-2624]
	mov r14, rdx
	mov r15, rcx
	l_1020:
	cmp r14, r13
	jl l_1021
	l_1022:
	jmp l_1023
	l_1021:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1023:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1007:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_943:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_687:
	mov rcx, rax
	mov rdx, qword [rbp-3944]
	mov qword [rbp-968], rdx
	mov rdx, qword [rbp-16]
	mov qword [rbp-1896], rdx
	mov qword [rbp-3160], rcx
	l_1024:
	mov rcx, qword [rbp-1896]
	mov rdx, qword [rbp-968]
	cmp rcx, rdx
	jl l_1025
	l_1026:
	jmp l_1027
	l_1025:
	mov rcx, qword [rbp-968]
	sub rcx, 1
	mov qword [rbp-512], rcx
	mov rcx, qword [rbp-1896]
	mov qword [rbp-3600], rcx
	mov rcx, qword [rbp-3160]
	mov qword [rbp-4264], rcx
	l_1028:
	mov rdx, qword [rbp-3600]
	mov rcx, qword [rbp-512]
	cmp rdx, rcx
	jl l_1029
	l_1030:
	jmp l_1031
	l_1029:
	mov rcx, qword [rbp-512]
	sub rcx, 1
	mov r12, rcx
	mov rcx, qword [rbp-3600]
	mov r13, rcx
	mov rcx, qword [rbp-4264]
	mov qword [rbp-208], rcx
	l_1032:
	cmp r13, r12
	jl l_1033
	l_1034:
	jmp l_1035
	l_1033:
	mov rcx, r12
	sub rcx, 1
	mov r14, rcx
	mov r15, r13
	mov rcx, qword [rbp-208]
	mov rbx, rcx
	l_1036:
	cmp r15, r14
	jl l_1037
	l_1038:
	jmp l_1039
	l_1037:
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4160], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3656], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3656]
	mov rsi, rax
	mov rax, qword [rbp-4160]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1039:
	mov qword [rbp-792], rax
	mov rax, r13
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-208]
	mov r15, rax
	mov rbx, r12
	l_1040:
	cmp r15, r14
	jl l_1041
	l_1042:
	mov rax, rbx
	jmp l_1043
	l_1041:
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4056], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1416], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1416]
	mov rsi, rax
	mov rax, qword [rbp-4056]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1043:
	mov qword [rbp-1168], rax
	mov rax, qword [rbp-208]
	sub rax, 1
	mov r14, rax
	mov rbx, r12
	l_1044:
	cmp rbx, r14
	jl l_1045
	l_1046:
	mov rax, r13
	jmp l_1047
	l_1045:
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1047:
	mov rcx, rax
	mov rdx, qword [rbp-792]
	mov r12, rdx
	mov rdx, qword [rbp-1168]
	mov rbx, rdx
	mov r15, rcx
	l_1048:
	cmp rbx, r12
	jl l_1049
	l_1050:
	jmp l_1051
	l_1049:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1051:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1035:
	mov qword [rbp-3272], rax
	mov rax, qword [rbp-3600]
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-4264]
	mov qword [rbp-4088], rax
	mov rax, qword [rbp-512]
	mov r12, rax
	l_1052:
	mov rax, qword [rbp-4088]
	cmp rax, r14
	jl l_1053
	l_1054:
	mov rax, r12
	jmp l_1055
	l_1053:
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-4088]
	mov r15, rax
	mov rbx, r12
	l_1056:
	cmp r15, r13
	jl l_1057
	l_1058:
	mov rax, rbx
	jmp l_1059
	l_1057:
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4168], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1792], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1792]
	mov rsi, rax
	mov rax, qword [rbp-4168]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1059:
	mov qword [rbp-3552], rax
	mov rax, qword [rbp-4088]
	sub rax, 1
	mov r13, rax
	mov r15, r12
	mov rbx, r14
	l_1060:
	cmp r15, r13
	jl l_1061
	l_1062:
	mov rax, rbx
	jmp l_1063
	l_1061:
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1128], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4008], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-4008]
	mov rsi, rax
	mov rax, qword [rbp-1128]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1063:
	mov qword [rbp-152], rax
	mov rax, r12
	sub rax, 1
	mov rbx, rax
	mov r13, r14
	mov rax, qword [rbp-4088]
	mov r15, rax
	l_1064:
	cmp r13, rbx
	jl l_1065
	l_1066:
	mov rax, r15
	jmp l_1067
	l_1065:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1067:
	mov rdx, rax
	mov rcx, qword [rbp-3552]
	mov r12, rcx
	mov rcx, qword [rbp-152]
	mov rbx, rcx
	mov r14, rdx
	l_1068:
	cmp rbx, r12
	jl l_1069
	l_1070:
	jmp l_1071
	l_1069:
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1071:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1055:
	mov qword [rbp-2776], rax
	mov rax, qword [rbp-4264]
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-512]
	mov qword [rbp-3808], rax
	mov rax, qword [rbp-3600]
	mov r12, rax
	l_1072:
	mov rax, qword [rbp-3808]
	cmp rax, r14
	jl l_1073
	l_1074:
	mov rax, r12
	jmp l_1075
	l_1073:
	mov rax, r14
	sub rax, 1
	mov r15, rax
	mov rax, qword [rbp-3808]
	mov r13, rax
	mov rbx, r12
	l_1076:
	cmp r13, r15
	jl l_1077
	l_1078:
	mov rax, rbx
	jmp l_1079
	l_1077:
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1272], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2728], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2728]
	mov rsi, rax
	mov rax, qword [rbp-1272]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1079:
	mov qword [rbp-2496], rax
	mov rax, qword [rbp-3808]
	sub rax, 1
	mov rbx, rax
	mov r13, r12
	mov r15, r14
	l_1080:
	cmp r13, rbx
	jl l_1081
	l_1082:
	mov rax, r15
	jmp l_1083
	l_1081:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2656], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-352], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-352]
	mov rsi, rax
	mov rax, qword [rbp-2656]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1083:
	mov qword [rbp-3344], rax
	mov rax, r12
	sub rax, 1
	mov rbx, rax
	mov r13, r14
	mov rax, qword [rbp-3808]
	mov r14, rax
	l_1084:
	cmp r13, rbx
	jl l_1085
	l_1086:
	mov rax, r14
	jmp l_1087
	l_1085:
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1087:
	mov rdx, rax
	mov rcx, qword [rbp-2496]
	mov r15, rcx
	mov rcx, qword [rbp-3344]
	mov r14, rcx
	mov r12, rdx
	l_1088:
	cmp r14, r15
	jl l_1089
	l_1090:
	jmp l_1091
	l_1089:
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1091:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1075:
	mov rcx, rax
	mov rdx, qword [rbp-3272]
	mov r13, rdx
	mov rdx, qword [rbp-2776]
	mov r14, rdx
	mov qword [rbp-688], rcx
	l_1092:
	cmp r14, r13
	jl l_1093
	l_1094:
	jmp l_1095
	l_1093:
	mov rcx, r13
	sub rcx, 1
	mov rbx, rcx
	mov r12, r14
	mov rcx, qword [rbp-688]
	mov r15, rcx
	l_1096:
	cmp r12, rbx
	jl l_1097
	l_1098:
	jmp l_1099
	l_1097:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3448], rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2664], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2664]
	mov rsi, rax
	mov rax, qword [rbp-3448]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1099:
	mov qword [rbp-1664], rax
	mov rax, r14
	sub rax, 1
	mov r15, rax
	mov rax, qword [rbp-688]
	mov rbx, rax
	mov r12, r13
	l_1100:
	cmp rbx, r15
	jl l_1101
	l_1102:
	mov rax, r12
	jmp l_1103
	l_1101:
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3744], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2888], rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2888]
	mov rsi, rax
	mov rax, qword [rbp-3744]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1103:
	mov qword [rbp-1816], rax
	mov rax, qword [rbp-688]
	sub rax, 1
	mov rbx, rax
	mov r12, r13
	mov r13, r14
	l_1104:
	cmp r12, rbx
	jl l_1105
	l_1106:
	mov rax, r13
	jmp l_1107
	l_1105:
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1107:
	mov rdx, rax
	mov rcx, qword [rbp-1664]
	mov r12, rcx
	mov rcx, qword [rbp-1816]
	mov rbx, rcx
	mov r13, rdx
	l_1108:
	cmp rbx, r12
	jl l_1109
	l_1110:
	jmp l_1111
	l_1109:
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1111:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1095:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1031:
	mov qword [rbp-504], rax
	mov rax, qword [rbp-1896]
	sub rax, 1
	mov qword [rbp-2576], rax
	mov rax, qword [rbp-3160]
	mov qword [rbp-296], rax
	mov rax, qword [rbp-968]
	mov qword [rbp-600], rax
	l_1112:
	mov rcx, qword [rbp-296]
	mov rax, qword [rbp-2576]
	cmp rcx, rax
	jl l_1113
	l_1114:
	mov rax, qword [rbp-600]
	jmp l_1115
	l_1113:
	mov rax, qword [rbp-2576]
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-296]
	mov qword [rbp-1296], rax
	mov rax, qword [rbp-600]
	mov r14, rax
	l_1116:
	mov rax, qword [rbp-1296]
	cmp rax, rbx
	jl l_1117
	l_1118:
	mov rax, r14
	jmp l_1119
	l_1117:
	mov rax, rbx
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-1296]
	mov r13, rax
	mov r15, r14
	l_1120:
	cmp r13, r12
	jl l_1121
	l_1122:
	mov rax, r15
	jmp l_1123
	l_1121:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2288], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-616], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-616]
	mov rsi, rax
	mov rax, qword [rbp-2288]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1123:
	mov qword [rbp-1888], rax
	mov rax, qword [rbp-1296]
	sub rax, 1
	mov r12, rax
	mov r13, r14
	mov r15, rbx
	l_1124:
	cmp r13, r12
	jl l_1125
	l_1126:
	mov rax, r15
	jmp l_1127
	l_1125:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3720], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3760], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3760]
	mov rsi, rax
	mov rax, qword [rbp-3720]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1127:
	mov qword [rbp-824], rax
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-1296]
	mov r12, rax
	l_1128:
	cmp rbx, r13
	jl l_1129
	l_1130:
	mov rax, r12
	jmp l_1131
	l_1129:
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1131:
	mov rdx, rax
	mov rcx, qword [rbp-1888]
	mov r13, rcx
	mov rcx, qword [rbp-824]
	mov r14, rcx
	mov r15, rdx
	l_1132:
	cmp r14, r13
	jl l_1133
	l_1134:
	jmp l_1135
	l_1133:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1135:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1119:
	mov qword [rbp-3248], rax
	mov rax, qword [rbp-296]
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-600]
	mov qword [rbp-232], rax
	mov rax, qword [rbp-2576]
	mov rbx, rax
	l_1136:
	mov rax, qword [rbp-232]
	cmp rax, r14
	jl l_1137
	l_1138:
	mov rax, rbx
	jmp l_1139
	l_1137:
	mov rax, r14
	sub rax, 1
	mov r15, rax
	mov rax, qword [rbp-232]
	mov r12, rax
	mov r13, rbx
	l_1140:
	cmp r12, r15
	jl l_1141
	l_1142:
	mov rax, r13
	jmp l_1143
	l_1141:
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2400], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1824], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1824]
	mov rsi, rax
	mov rax, qword [rbp-2400]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1143:
	mov qword [rbp-3936], rax
	mov rax, qword [rbp-232]
	sub rax, 1
	mov r13, rax
	mov r15, rbx
	mov r12, r14
	l_1144:
	cmp r15, r13
	jl l_1145
	l_1146:
	mov rax, r12
	jmp l_1147
	l_1145:
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2920], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1608], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1608]
	mov rsi, rax
	mov rax, qword [rbp-2920]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1147:
	mov qword [rbp-376], rax
	mov rax, rbx
	sub rax, 1
	mov r13, rax
	mov r12, r14
	mov rax, qword [rbp-232]
	mov rbx, rax
	l_1148:
	cmp r12, r13
	jl l_1149
	l_1150:
	mov rax, rbx
	jmp l_1151
	l_1149:
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1151:
	mov rcx, rax
	mov rdx, qword [rbp-3936]
	mov rbx, rdx
	mov rdx, qword [rbp-376]
	mov r14, rdx
	mov r13, rcx
	l_1152:
	cmp r14, rbx
	jl l_1153
	l_1154:
	jmp l_1155
	l_1153:
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1155:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1139:
	mov qword [rbp-2144], rax
	mov rax, qword [rbp-600]
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-2576]
	mov qword [rbp-4400], rax
	mov rax, qword [rbp-296]
	mov r12, rax
	l_1156:
	mov rax, qword [rbp-4400]
	cmp rax, r13
	jl l_1157
	l_1158:
	mov rax, r12
	jmp l_1159
	l_1157:
	mov rax, r13
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-4400]
	mov rbx, rax
	mov r15, r12
	l_1160:
	cmp rbx, r14
	jl l_1161
	l_1162:
	mov rax, r15
	jmp l_1163
	l_1161:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3888], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3224], rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3224]
	mov rsi, rax
	mov rax, qword [rbp-3888]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1163:
	mov qword [rbp-3000], rax
	mov rax, qword [rbp-4400]
	sub rax, 1
	mov r15, rax
	mov rbx, r12
	mov r14, r13
	l_1164:
	cmp rbx, r15
	jl l_1165
	l_1166:
	mov rax, r14
	jmp l_1167
	l_1165:
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-32], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1384], rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1384]
	mov rsi, rax
	mov rax, qword [rbp-32]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1167:
	mov qword [rbp-3872], rax
	mov rax, r12
	sub rax, 1
	mov rbx, rax
	mov r12, r13
	mov rax, qword [rbp-4400]
	mov r13, rax
	l_1168:
	cmp r12, rbx
	jl l_1169
	l_1170:
	mov rax, r13
	jmp l_1171
	l_1169:
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1171:
	mov rdx, rax
	mov rcx, qword [rbp-3000]
	mov r13, rcx
	mov rcx, qword [rbp-3872]
	mov r15, rcx
	mov r14, rdx
	l_1172:
	cmp r15, r13
	jl l_1173
	l_1174:
	jmp l_1175
	l_1173:
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1175:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1159:
	mov rdx, rax
	mov rcx, qword [rbp-3248]
	mov r12, rcx
	mov rcx, qword [rbp-2144]
	mov r14, rcx
	mov rcx, rdx
	mov qword [rbp-1104], rcx
	l_1176:
	cmp r14, r12
	jl l_1177
	l_1178:
	jmp l_1179
	l_1177:
	mov rcx, r12
	sub rcx, 1
	mov r13, rcx
	mov rbx, r14
	mov rcx, qword [rbp-1104]
	mov r15, rcx
	l_1180:
	cmp rbx, r13
	jl l_1181
	l_1182:
	jmp l_1183
	l_1181:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1672], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-744], rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-744]
	mov rsi, rax
	mov rax, qword [rbp-1672]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1183:
	mov qword [rbp-1448], rax
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-1104]
	mov r15, rax
	mov rbx, r12
	l_1184:
	cmp r15, r13
	jl l_1185
	l_1186:
	mov rax, rbx
	jmp l_1187
	l_1185:
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2072], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2856], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2856]
	mov rsi, rax
	mov rax, qword [rbp-2072]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1187:
	mov qword [rbp-4064], rax
	mov rax, qword [rbp-1104]
	sub rax, 1
	mov r13, rax
	mov rbx, r12
	l_1188:
	cmp rbx, r13
	jl l_1189
	l_1190:
	mov rax, r14
	jmp l_1191
	l_1189:
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1191:
	mov rdx, rax
	mov rcx, qword [rbp-1448]
	mov r12, rcx
	mov rcx, qword [rbp-4064]
	mov rbx, rcx
	mov r15, rdx
	l_1192:
	cmp rbx, r12
	jl l_1193
	l_1194:
	jmp l_1195
	l_1193:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1195:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1179:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1115:
	mov qword [rbp-2992], rax
	mov rax, qword [rbp-3160]
	sub rax, 1
	mov qword [rbp-4320], rax
	mov rax, qword [rbp-968]
	mov qword [rbp-2784], rax
	mov rax, qword [rbp-1896]
	mov qword [rbp-3008], rax
	l_1196:
	mov rax, qword [rbp-2784]
	mov rcx, qword [rbp-4320]
	cmp rax, rcx
	jl l_1197
	l_1198:
	mov rax, qword [rbp-3008]
	jmp l_1199
	l_1197:
	mov rax, qword [rbp-4320]
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-2784]
	mov qword [rbp-1184], rax
	mov rax, qword [rbp-3008]
	mov r12, rax
	l_1200:
	mov rax, qword [rbp-1184]
	cmp rax, r14
	jl l_1201
	l_1202:
	mov rax, r12
	jmp l_1203
	l_1201:
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-1184]
	mov rbx, rax
	mov r15, r12
	l_1204:
	cmp rbx, r13
	jl l_1205
	l_1206:
	mov rax, r15
	jmp l_1207
	l_1205:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3696], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-424], rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-424]
	mov rsi, rax
	mov rax, qword [rbp-3696]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1207:
	mov qword [rbp-2840], rax
	mov rax, qword [rbp-1184]
	sub rax, 1
	mov rbx, rax
	mov r15, r12
	mov r13, r14
	l_1208:
	cmp r15, rbx
	jl l_1209
	l_1210:
	mov rax, r13
	jmp l_1211
	l_1209:
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1928], rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-552], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-552]
	mov rsi, rax
	mov rax, qword [rbp-1928]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1211:
	mov qword [rbp-360], rax
	mov rax, r12
	sub rax, 1
	mov rbx, rax
	mov r12, r14
	mov rax, qword [rbp-1184]
	mov r15, rax
	l_1212:
	cmp r12, rbx
	jl l_1213
	l_1214:
	mov rax, r15
	jmp l_1215
	l_1213:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1215:
	mov rdx, rax
	mov rcx, qword [rbp-2840]
	mov r14, rcx
	mov rcx, qword [rbp-360]
	mov rbx, rcx
	mov r15, rdx
	l_1216:
	cmp rbx, r14
	jl l_1217
	l_1218:
	jmp l_1219
	l_1217:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1219:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1203:
	mov qword [rbp-2200], rax
	mov rax, qword [rbp-2784]
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-3008]
	mov qword [rbp-3376], rax
	mov rax, qword [rbp-4320]
	mov r12, rax
	l_1220:
	mov rax, qword [rbp-3376]
	cmp rax, rbx
	jl l_1221
	l_1222:
	mov rax, r12
	jmp l_1223
	l_1221:
	mov rax, rbx
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-3376]
	mov r15, rax
	mov r14, r12
	l_1224:
	cmp r15, r13
	jl l_1225
	l_1226:
	mov rax, r14
	jmp l_1227
	l_1225:
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3536], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1616], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1616]
	mov rsi, rax
	mov rax, qword [rbp-3536]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1227:
	mov qword [rbp-256], rax
	mov rax, qword [rbp-3376]
	sub rax, 1
	mov r15, rax
	mov r14, r12
	mov r13, rbx
	l_1228:
	cmp r14, r15
	jl l_1229
	l_1230:
	mov rax, r13
	jmp l_1231
	l_1229:
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3040], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-888], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-888]
	mov rsi, rax
	mov rax, qword [rbp-3040]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1231:
	mov qword [rbp-4200], rax
	mov rax, r12
	sub rax, 1
	mov r13, rax
	mov r14, rbx
	mov rax, qword [rbp-3376]
	mov r15, rax
	l_1232:
	cmp r14, r13
	jl l_1233
	l_1234:
	mov rax, r15
	jmp l_1235
	l_1233:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1235:
	mov rdx, rax
	mov rcx, qword [rbp-256]
	mov r13, rcx
	mov rcx, qword [rbp-4200]
	mov r12, rcx
	mov r14, rdx
	l_1236:
	cmp r12, r13
	jl l_1237
	l_1238:
	jmp l_1239
	l_1237:
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1239:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1223:
	mov qword [rbp-1640], rax
	mov rax, qword [rbp-3008]
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-4320]
	mov qword [rbp-696], rax
	mov rax, qword [rbp-2784]
	mov r12, rax
	l_1240:
	mov rax, qword [rbp-696]
	cmp rax, r13
	jl l_1241
	l_1242:
	mov rax, r12
	jmp l_1243
	l_1241:
	mov rax, r13
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-696]
	mov r14, rax
	mov r15, r12
	l_1244:
	cmp r14, rbx
	jl l_1245
	l_1246:
	mov rax, r15
	jmp l_1247
	l_1245:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3136], rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2376], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2376]
	mov rsi, rax
	mov rax, qword [rbp-3136]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1247:
	mov qword [rbp-832], rax
	mov rax, qword [rbp-696]
	sub rax, 1
	mov r15, rax
	mov rbx, r12
	mov r14, r13
	l_1248:
	cmp rbx, r15
	jl l_1249
	l_1250:
	mov rax, r14
	jmp l_1251
	l_1249:
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3608], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-392], rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-392]
	mov rsi, rax
	mov rax, qword [rbp-3608]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1251:
	mov qword [rbp-2304], rax
	mov rax, r12
	sub rax, 1
	mov r12, rax
	mov r14, r13
	mov rax, qword [rbp-696]
	mov r15, rax
	l_1252:
	cmp r14, r12
	jl l_1253
	l_1254:
	mov rax, r15
	jmp l_1255
	l_1253:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1255:
	mov rcx, rax
	mov rdx, qword [rbp-832]
	mov r13, rdx
	mov rdx, qword [rbp-2304]
	mov rbx, rdx
	mov r15, rcx
	l_1256:
	cmp rbx, r13
	jl l_1257
	l_1258:
	jmp l_1259
	l_1257:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1259:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1243:
	mov rdx, rax
	mov rcx, qword [rbp-2200]
	mov r12, rcx
	mov rcx, qword [rbp-1640]
	mov r14, rcx
	mov rcx, rdx
	mov qword [rbp-2408], rcx
	l_1260:
	cmp r14, r12
	jl l_1261
	l_1262:
	jmp l_1263
	l_1261:
	mov rcx, r12
	sub rcx, 1
	mov rbx, rcx
	mov r13, r14
	mov rcx, qword [rbp-2408]
	mov r15, rcx
	l_1264:
	cmp r13, rbx
	jl l_1265
	l_1266:
	jmp l_1267
	l_1265:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1424], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-304], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-304]
	mov rsi, rax
	mov rax, qword [rbp-1424]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1267:
	mov qword [rbp-944], rax
	mov rax, r14
	sub rax, 1
	mov r15, rax
	mov rax, qword [rbp-2408]
	mov rbx, rax
	mov r13, r12
	l_1268:
	cmp rbx, r15
	jl l_1269
	l_1270:
	mov rax, r13
	jmp l_1271
	l_1269:
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1256], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1088], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1088]
	mov rsi, rax
	mov rax, qword [rbp-1256]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1271:
	mov qword [rbp-1944], rax
	mov rax, qword [rbp-2408]
	sub rax, 1
	mov rbx, rax
	mov r13, r12
	mov r15, r14
	l_1272:
	cmp r13, rbx
	jl l_1273
	l_1274:
	mov rax, r15
	jmp l_1275
	l_1273:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1275:
	mov rdx, rax
	mov rcx, qword [rbp-944]
	mov rbx, rcx
	mov rcx, qword [rbp-1944]
	mov r13, rcx
	mov r15, rdx
	l_1276:
	cmp r13, rbx
	jl l_1277
	l_1278:
	jmp l_1279
	l_1277:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1279:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1263:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1199:
	mov rcx, rax
	mov rdx, qword [rbp-504]
	mov qword [rbp-2864], rdx
	mov rdx, qword [rbp-2992]
	mov qword [rbp-3992], rdx
	mov qword [rbp-2640], rcx
	l_1280:
	mov rcx, qword [rbp-3992]
	mov rdx, qword [rbp-2864]
	cmp rcx, rdx
	jl l_1281
	l_1282:
	jmp l_1283
	l_1281:
	mov rcx, qword [rbp-2864]
	sub rcx, 1
	mov r15, rcx
	mov rcx, qword [rbp-3992]
	mov rbx, rcx
	mov rcx, qword [rbp-2640]
	mov qword [rbp-1496], rcx
	l_1284:
	cmp rbx, r15
	jl l_1285
	l_1286:
	jmp l_1287
	l_1285:
	mov rcx, r15
	sub rcx, 1
	mov r14, rcx
	mov r13, rbx
	mov rcx, qword [rbp-1496]
	mov r12, rcx
	l_1288:
	cmp r13, r14
	jl l_1289
	l_1290:
	jmp l_1291
	l_1289:
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-872], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2712], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-2712]
	mov rsi, rax
	mov rax, qword [rbp-872]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1291:
	mov qword [rbp-2088], rax
	mov rax, rbx
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-1496]
	mov r13, rax
	mov r14, r15
	l_1292:
	cmp r13, r12
	jl l_1293
	l_1294:
	mov rax, r14
	jmp l_1295
	l_1293:
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-280], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-4352], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-4352]
	mov rsi, rax
	mov rax, qword [rbp-280]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1295:
	mov qword [rbp-1144], rax
	mov rax, qword [rbp-1496]
	sub rax, 1
	mov r14, rax
	mov r13, r15
	mov r12, rbx
	l_1296:
	cmp r13, r14
	jl l_1297
	l_1298:
	mov rax, r12
	jmp l_1299
	l_1297:
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1299:
	mov rdx, rax
	mov rcx, qword [rbp-2088]
	mov r14, rcx
	mov rcx, qword [rbp-1144]
	mov r13, rcx
	mov rbx, rdx
	l_1300:
	cmp r13, r14
	jl l_1301
	l_1302:
	jmp l_1303
	l_1301:
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1303:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1287:
	mov qword [rbp-2848], rax
	mov rax, qword [rbp-3992]
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-2640]
	mov qword [rbp-2248], rax
	mov rax, qword [rbp-2864]
	mov r12, rax
	l_1304:
	mov rax, qword [rbp-2248]
	cmp rax, r14
	jl l_1305
	l_1306:
	mov rax, r12
	jmp l_1307
	l_1305:
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-2248]
	mov r15, rax
	mov rbx, r12
	l_1308:
	cmp r15, r13
	jl l_1309
	l_1310:
	mov rax, rbx
	jmp l_1311
	l_1309:
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3016], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3104], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3104]
	mov rsi, rax
	mov rax, qword [rbp-3016]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1311:
	mov qword [rbp-4240], rax
	mov rax, qword [rbp-2248]
	sub rax, 1
	mov rbx, rax
	mov r13, r12
	mov r15, r14
	l_1312:
	cmp r13, rbx
	jl l_1313
	l_1314:
	mov rax, r15
	jmp l_1315
	l_1313:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-720], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-8], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-8]
	mov rsi, rax
	mov rax, qword [rbp-720]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1315:
	mov qword [rbp-2080], rax
	mov rax, r12
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-2248]
	mov r13, rax
	l_1316:
	cmp r14, rbx
	jl l_1317
	l_1318:
	mov rax, r13
	jmp l_1319
	l_1317:
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1319:
	mov rdx, rax
	mov rcx, qword [rbp-4240]
	mov r12, rcx
	mov rcx, qword [rbp-2080]
	mov r14, rcx
	mov r15, rdx
	l_1320:
	cmp r14, r12
	jl l_1321
	l_1322:
	jmp l_1323
	l_1321:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1323:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1307:
	mov qword [rbp-1264], rax
	mov rax, qword [rbp-2640]
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-2864]
	mov qword [rbp-632], rax
	mov rax, qword [rbp-3992]
	mov r14, rax
	l_1324:
	mov rax, qword [rbp-632]
	cmp rax, r12
	jl l_1325
	l_1326:
	mov rax, r14
	jmp l_1327
	l_1325:
	mov rax, r12
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-632]
	mov r13, rax
	mov r15, r14
	l_1328:
	cmp r13, rbx
	jl l_1329
	l_1330:
	mov rax, r15
	jmp l_1331
	l_1329:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3488], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3984], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3984]
	mov rsi, rax
	mov rax, qword [rbp-3488]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1331:
	mov qword [rbp-768], rax
	mov rax, qword [rbp-632]
	sub rax, 1
	mov rbx, rax
	mov r15, r14
	mov r13, r12
	l_1332:
	cmp r15, rbx
	jl l_1333
	l_1334:
	mov rax, r13
	jmp l_1335
	l_1333:
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3384], rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-400], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-400]
	mov rsi, rax
	mov rax, qword [rbp-3384]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1335:
	mov qword [rbp-2224], rax
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov r15, r12
	mov rax, qword [rbp-632]
	mov rbx, rax
	l_1336:
	cmp r15, r13
	jl l_1337
	l_1338:
	mov rax, rbx
	jmp l_1339
	l_1337:
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1339:
	mov rdx, rax
	mov rcx, qword [rbp-768]
	mov r14, rcx
	mov rcx, qword [rbp-2224]
	mov rbx, rcx
	mov r12, rdx
	l_1340:
	cmp rbx, r14
	jl l_1341
	l_1342:
	jmp l_1343
	l_1341:
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1343:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1327:
	mov rdx, rax
	mov rcx, qword [rbp-2848]
	mov r14, rcx
	mov rcx, qword [rbp-1264]
	mov rbx, rcx
	mov rcx, rdx
	mov qword [rbp-3864], rcx
	l_1344:
	cmp rbx, r14
	jl l_1345
	l_1346:
	jmp l_1347
	l_1345:
	mov rcx, r14
	sub rcx, 1
	mov r15, rcx
	mov r12, rbx
	mov rcx, qword [rbp-3864]
	mov r13, rcx
	l_1348:
	cmp r12, r15
	jl l_1349
	l_1350:
	jmp l_1351
	l_1349:
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-2504], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3048], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3048]
	mov rsi, rax
	mov rax, qword [rbp-2504]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1351:
	mov qword [rbp-4392], rax
	mov rax, rbx
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-3864]
	mov r12, rax
	mov r15, r14
	l_1352:
	cmp r12, r13
	jl l_1353
	l_1354:
	mov rax, r15
	jmp l_1355
	l_1353:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3360], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-3064], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-3064]
	mov rsi, rax
	mov rax, qword [rbp-3360]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1355:
	mov qword [rbp-4152], rax
	mov rax, qword [rbp-3864]
	sub rax, 1
	mov r13, rax
	mov r15, rbx
	l_1356:
	cmp r14, r13
	jl l_1357
	l_1358:
	mov rax, r15
	jmp l_1359
	l_1357:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1359:
	mov rdx, rax
	mov rcx, qword [rbp-4392]
	mov rbx, rcx
	mov rcx, qword [rbp-4152]
	mov r14, rcx
	mov r12, rdx
	l_1360:
	cmp r14, rbx
	jl l_1361
	l_1362:
	jmp l_1363
	l_1361:
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1363:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1347:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1283:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1027:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_3:
	pop r12
	pop r14
	pop rbx
	pop r13
	pop r15
	leave 
	ret
_main_User_Defined_fihriaifhiahidsafans:
	l_1364:
	push rbp
	mov rbp, rsp
	sub rsp, 1112
	push r15
	push r13
	push rbx
	push r14
	push r12
	call __getInt 
	mov r14, rax
	call __getInt 
	mov r12, rax
	call __getInt 
	mov rcx, rax
	mov rdx, rcx
	mov rcx, r14
	mov qword [rbp-8], rcx
	mov rcx, r12
	mov qword [rbp-1016], rcx
	mov rcx, rdx
	mov qword [rbp-776], rcx
	l_1365:
	mov rdx, qword [rbp-1016]
	mov rcx, qword [rbp-8]
	cmp rdx, rcx
	jl l_1366
	l_1367:
	jmp l_1368
	l_1366:
	mov rcx, qword [rbp-8]
	sub rcx, 1
	mov qword [rbp-392], rcx
	mov rcx, qword [rbp-1016]
	mov qword [rbp-696], rcx
	mov rcx, qword [rbp-776]
	mov qword [rbp-184], rcx
	l_1369:
	mov rcx, qword [rbp-696]
	mov rdx, qword [rbp-392]
	cmp rcx, rdx
	jl l_1370
	l_1371:
	jmp l_1372
	l_1370:
	mov rcx, qword [rbp-392]
	sub rcx, 1
	mov rbx, rcx
	mov rcx, qword [rbp-696]
	mov r14, rcx
	mov rcx, qword [rbp-184]
	mov qword [rbp-672], rcx
	l_1373:
	cmp r14, rbx
	jl l_1374
	l_1375:
	jmp l_1376
	l_1374:
	mov rcx, rbx
	sub rcx, 1
	mov r13, rcx
	mov r15, r14
	mov rcx, qword [rbp-672]
	mov r12, rcx
	l_1377:
	cmp r15, r13
	jl l_1378
	l_1379:
	jmp l_1380
	l_1378:
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-656], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-32], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-32]
	mov rsi, rax
	mov rax, qword [rbp-656]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1380:
	mov qword [rbp-432], rax
	mov rax, r14
	sub rax, 1
	mov r15, rax
	mov rax, qword [rbp-672]
	mov r12, rax
	mov r13, rbx
	l_1381:
	cmp r12, r15
	jl l_1382
	l_1383:
	mov rax, r13
	jmp l_1384
	l_1382:
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-808], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-376], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-376]
	mov rsi, rax
	mov rax, qword [rbp-808]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1384:
	mov qword [rbp-728], rax
	mov rax, qword [rbp-672]
	sub rax, 1
	mov r12, rax
	l_1385:
	cmp rbx, r12
	jl l_1386
	l_1387:
	mov rax, r14
	jmp l_1388
	l_1386:
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1388:
	mov rcx, rax
	mov rdx, qword [rbp-432]
	mov r15, rdx
	mov rdx, qword [rbp-728]
	mov rbx, rdx
	mov r12, rcx
	l_1389:
	cmp rbx, r15
	jl l_1390
	l_1391:
	jmp l_1392
	l_1390:
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1392:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1376:
	mov qword [rbp-1024], rax
	mov rax, qword [rbp-696]
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-184]
	mov qword [rbp-1000], rax
	mov rax, qword [rbp-392]
	mov r14, rax
	l_1393:
	mov rax, qword [rbp-1000]
	cmp rax, r12
	jl l_1394
	l_1395:
	mov rax, r14
	jmp l_1396
	l_1394:
	mov rax, r12
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-1000]
	mov r13, rax
	mov r15, r14
	l_1397:
	cmp r13, rbx
	jl l_1398
	l_1399:
	mov rax, r15
	jmp l_1400
	l_1398:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-592], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-368], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-368]
	mov rsi, rax
	mov rax, qword [rbp-592]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1400:
	mov qword [rbp-336], rax
	mov rax, qword [rbp-1000]
	sub rax, 1
	mov rbx, rax
	mov r13, r14
	mov r15, r12
	l_1401:
	cmp r13, rbx
	jl l_1402
	l_1403:
	mov rax, r15
	jmp l_1404
	l_1402:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-576], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-80], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-80]
	mov rsi, rax
	mov rax, qword [rbp-576]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1404:
	mov qword [rbp-224], rax
	mov rax, r14
	sub rax, 1
	mov r14, rax
	mov r13, r12
	mov rax, qword [rbp-1000]
	mov r15, rax
	l_1405:
	cmp r13, r14
	jl l_1406
	l_1407:
	mov rax, r15
	jmp l_1408
	l_1406:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1408:
	mov rdx, rax
	mov rcx, qword [rbp-336]
	mov r14, rcx
	mov rcx, qword [rbp-224]
	mov rbx, rcx
	mov r15, rdx
	l_1409:
	cmp rbx, r14
	jl l_1410
	l_1411:
	jmp l_1412
	l_1410:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1412:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1396:
	mov qword [rbp-912], rax
	mov rax, qword [rbp-184]
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-392]
	mov qword [rbp-960], rax
	mov rax, qword [rbp-696]
	mov r14, rax
	l_1413:
	mov rax, qword [rbp-960]
	cmp rax, r12
	jl l_1414
	l_1415:
	mov rax, r14
	jmp l_1416
	l_1414:
	mov rax, r12
	sub rax, 1
	mov r15, rax
	mov rax, qword [rbp-960]
	mov r13, rax
	mov rbx, r14
	l_1417:
	cmp r13, r15
	jl l_1418
	l_1419:
	mov rax, rbx
	jmp l_1420
	l_1418:
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1008], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-480], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-480]
	mov rsi, rax
	mov rax, qword [rbp-1008]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1420:
	mov qword [rbp-208], rax
	mov rax, qword [rbp-960]
	sub rax, 1
	mov rbx, rax
	mov r13, r14
	mov r15, r12
	l_1421:
	cmp r13, rbx
	jl l_1422
	l_1423:
	mov rax, r15
	jmp l_1424
	l_1422:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-720], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-168], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-168]
	mov rsi, rax
	mov rax, qword [rbp-720]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1424:
	mov qword [rbp-272], rax
	mov rax, r14
	sub rax, 1
	mov rbx, rax
	mov r14, r12
	mov rax, qword [rbp-960]
	mov r13, rax
	l_1425:
	cmp r14, rbx
	jl l_1426
	l_1427:
	mov rax, r13
	jmp l_1428
	l_1426:
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1428:
	mov rdx, rax
	mov rcx, qword [rbp-208]
	mov r14, rcx
	mov rcx, qword [rbp-272]
	mov r15, rcx
	mov r12, rdx
	l_1429:
	cmp r15, r14
	jl l_1430
	l_1431:
	jmp l_1432
	l_1430:
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1432:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1416:
	mov rcx, rax
	mov rdx, qword [rbp-1024]
	mov r14, rdx
	mov rdx, qword [rbp-912]
	mov r13, rdx
	mov qword [rbp-824], rcx
	l_1433:
	cmp r13, r14
	jl l_1434
	l_1435:
	jmp l_1436
	l_1434:
	mov rcx, r14
	sub rcx, 1
	mov r15, rcx
	mov rbx, r13
	mov rcx, qword [rbp-824]
	mov r12, rcx
	l_1437:
	cmp rbx, r15
	jl l_1438
	l_1439:
	jmp l_1440
	l_1438:
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-64], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-968], rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-968]
	mov rsi, rax
	mov rax, qword [rbp-64]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1440:
	mov qword [rbp-136], rax
	mov rax, r13
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-824]
	mov r12, rax
	mov r15, r14
	l_1441:
	cmp r12, rbx
	jl l_1442
	l_1443:
	mov rax, r15
	jmp l_1444
	l_1442:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-72], rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-56], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-56]
	mov rsi, rax
	mov rax, qword [rbp-72]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1444:
	mov qword [rbp-600], rax
	mov rax, qword [rbp-824]
	sub rax, 1
	mov r12, rax
	mov r15, r13
	l_1445:
	cmp r14, r12
	jl l_1446
	l_1447:
	mov rax, r15
	jmp l_1448
	l_1446:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1448:
	mov rdx, rax
	mov rcx, qword [rbp-136]
	mov rbx, rcx
	mov rcx, qword [rbp-600]
	mov r13, rcx
	mov r15, rdx
	l_1449:
	cmp r13, rbx
	jl l_1450
	l_1451:
	jmp l_1452
	l_1450:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1452:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1436:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1372:
	mov qword [rbp-440], rax
	mov rax, qword [rbp-1016]
	sub rax, 1
	mov qword [rbp-352], rax
	mov rax, qword [rbp-776]
	mov qword [rbp-304], rax
	mov rax, qword [rbp-8]
	mov qword [rbp-976], rax
	l_1453:
	mov rcx, qword [rbp-304]
	mov rax, qword [rbp-352]
	cmp rcx, rax
	jl l_1454
	l_1455:
	mov rax, qword [rbp-976]
	jmp l_1456
	l_1454:
	mov rax, qword [rbp-352]
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-304]
	mov qword [rbp-216], rax
	mov rax, qword [rbp-976]
	mov r14, rax
	l_1457:
	mov rax, qword [rbp-216]
	cmp rax, rbx
	jl l_1458
	l_1459:
	mov rax, r14
	jmp l_1460
	l_1458:
	mov rax, rbx
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-216]
	mov r12, rax
	mov r15, r14
	l_1461:
	cmp r12, r13
	jl l_1462
	l_1463:
	mov rax, r15
	jmp l_1464
	l_1462:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-24], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-104], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-104]
	mov rsi, rax
	mov rax, qword [rbp-24]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1464:
	mov qword [rbp-416], rax
	mov rax, qword [rbp-216]
	sub rax, 1
	mov r12, rax
	mov r15, r14
	mov r13, rbx
	l_1465:
	cmp r15, r12
	jl l_1466
	l_1467:
	mov rax, r13
	jmp l_1468
	l_1466:
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-992], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-680], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-680]
	mov rsi, rax
	mov rax, qword [rbp-992]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1468:
	mov qword [rbp-192], rax
	mov rax, r14
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-216]
	mov r15, rax
	l_1469:
	cmp rbx, r12
	jl l_1470
	l_1471:
	mov rax, r15
	jmp l_1472
	l_1470:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1472:
	mov rdx, rax
	mov rcx, qword [rbp-416]
	mov r14, rcx
	mov rcx, qword [rbp-192]
	mov r13, rcx
	mov r12, rdx
	l_1473:
	cmp r13, r14
	jl l_1474
	l_1475:
	jmp l_1476
	l_1474:
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1476:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1460:
	mov qword [rbp-400], rax
	mov rax, qword [rbp-304]
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-976]
	mov qword [rbp-1088], rax
	mov rax, qword [rbp-352]
	mov rbx, rax
	l_1477:
	mov rax, qword [rbp-1088]
	cmp rax, r13
	jl l_1478
	l_1479:
	mov rax, rbx
	jmp l_1480
	l_1478:
	mov rax, r13
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-1088]
	mov r12, rax
	mov r15, rbx
	l_1481:
	cmp r12, r14
	jl l_1482
	l_1483:
	mov rax, r15
	jmp l_1484
	l_1482:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-536], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-928], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-928]
	mov rsi, rax
	mov rax, qword [rbp-536]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1484:
	mov qword [rbp-984], rax
	mov rax, qword [rbp-1088]
	sub rax, 1
	mov r14, rax
	mov r15, rbx
	mov r12, r13
	l_1485:
	cmp r15, r14
	jl l_1486
	l_1487:
	mov rax, r12
	jmp l_1488
	l_1486:
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-280], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-360], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-360]
	mov rsi, rax
	mov rax, qword [rbp-280]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1488:
	mov qword [rbp-544], rax
	mov rax, rbx
	sub rax, 1
	mov rbx, rax
	mov r15, r13
	mov rax, qword [rbp-1088]
	mov r14, rax
	l_1489:
	cmp r15, rbx
	jl l_1490
	l_1491:
	mov rax, r14
	jmp l_1492
	l_1490:
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1492:
	mov rcx, rax
	mov rdx, qword [rbp-984]
	mov r12, rdx
	mov rdx, qword [rbp-544]
	mov rbx, rdx
	mov r15, rcx
	l_1493:
	cmp rbx, r12
	jl l_1494
	l_1495:
	jmp l_1496
	l_1494:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1496:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1480:
	mov qword [rbp-344], rax
	mov rax, qword [rbp-976]
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-352]
	mov qword [rbp-616], rax
	mov rax, qword [rbp-304]
	mov r13, rax
	l_1497:
	mov rax, qword [rbp-616]
	cmp rax, r12
	jl l_1498
	l_1499:
	mov rax, r13
	jmp l_1500
	l_1498:
	mov rax, r12
	sub rax, 1
	mov r15, rax
	mov rax, qword [rbp-616]
	mov r14, rax
	mov rbx, r13
	l_1501:
	cmp r14, r15
	jl l_1502
	l_1503:
	mov rax, rbx
	jmp l_1504
	l_1502:
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-632], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-328], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-328]
	mov rsi, rax
	mov rax, qword [rbp-632]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1504:
	mov qword [rbp-176], rax
	mov rax, qword [rbp-616]
	sub rax, 1
	mov r15, rax
	mov r14, r13
	mov rbx, r12
	l_1505:
	cmp r14, r15
	jl l_1506
	l_1507:
	mov rax, rbx
	jmp l_1508
	l_1506:
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-856], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-640], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-640]
	mov rsi, rax
	mov rax, qword [rbp-856]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1508:
	mov qword [rbp-128], rax
	mov rax, r13
	sub rax, 1
	mov r14, rax
	mov r13, r12
	mov rax, qword [rbp-616]
	mov r15, rax
	l_1509:
	cmp r13, r14
	jl l_1510
	l_1511:
	mov rax, r15
	jmp l_1512
	l_1510:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1512:
	mov rcx, rax
	mov rdx, qword [rbp-176]
	mov r12, rdx
	mov rdx, qword [rbp-128]
	mov r14, rdx
	mov rbx, rcx
	l_1513:
	cmp r14, r12
	jl l_1514
	l_1515:
	jmp l_1516
	l_1514:
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1516:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1500:
	mov rdx, rax
	mov rcx, qword [rbp-400]
	mov r12, rcx
	mov rcx, qword [rbp-344]
	mov r14, rcx
	mov rcx, rdx
	mov qword [rbp-816], rcx
	l_1517:
	cmp r14, r12
	jl l_1518
	l_1519:
	jmp l_1520
	l_1518:
	mov rcx, r12
	sub rcx, 1
	mov r13, rcx
	mov rbx, r14
	mov rcx, qword [rbp-816]
	mov r15, rcx
	l_1521:
	cmp rbx, r13
	jl l_1522
	l_1523:
	jmp l_1524
	l_1522:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-96], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-944], rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-944]
	mov rsi, rax
	mov rax, qword [rbp-96]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1524:
	mov qword [rbp-240], rax
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-816]
	mov r15, rax
	mov rbx, r12
	l_1525:
	cmp r15, r13
	jl l_1526
	l_1527:
	mov rax, rbx
	jmp l_1528
	l_1526:
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-40], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-312], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-312]
	mov rsi, rax
	mov rax, qword [rbp-40]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1528:
	mov qword [rbp-800], rax
	mov rax, qword [rbp-816]
	sub rax, 1
	mov rbx, rax
	l_1529:
	cmp r12, rbx
	jl l_1530
	l_1531:
	mov rax, r14
	jmp l_1532
	l_1530:
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1532:
	mov rdx, rax
	mov rcx, qword [rbp-240]
	mov r12, rcx
	mov rcx, qword [rbp-800]
	mov r13, rcx
	mov rbx, rdx
	l_1533:
	cmp r13, r12
	jl l_1534
	l_1535:
	jmp l_1536
	l_1534:
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1536:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1520:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1456:
	mov qword [rbp-496], rax
	mov rax, qword [rbp-776]
	sub rax, 1
	mov qword [rbp-920], rax
	mov rax, qword [rbp-8]
	mov qword [rbp-1072], rax
	mov rax, qword [rbp-1016]
	mov qword [rbp-16], rax
	l_1537:
	mov rcx, qword [rbp-1072]
	mov rax, qword [rbp-920]
	cmp rcx, rax
	jl l_1538
	l_1539:
	mov rax, qword [rbp-16]
	jmp l_1540
	l_1538:
	mov rax, qword [rbp-920]
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-1072]
	mov qword [rbp-664], rax
	mov rax, qword [rbp-16]
	mov r12, rax
	l_1541:
	mov rax, qword [rbp-664]
	cmp rax, rbx
	jl l_1542
	l_1543:
	mov rax, r12
	jmp l_1544
	l_1542:
	mov rax, rbx
	sub rax, 1
	mov r15, rax
	mov rax, qword [rbp-664]
	mov r13, rax
	mov r14, r12
	l_1545:
	cmp r13, r15
	jl l_1546
	l_1547:
	mov rax, r14
	jmp l_1548
	l_1546:
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-384], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-608], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-608]
	mov rsi, rax
	mov rax, qword [rbp-384]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1548:
	mov qword [rbp-560], rax
	mov rax, qword [rbp-664]
	sub rax, 1
	mov r14, rax
	mov r13, r12
	mov r15, rbx
	l_1549:
	cmp r13, r14
	jl l_1550
	l_1551:
	mov rax, r15
	jmp l_1552
	l_1550:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-504], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-528], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-528]
	mov rsi, rax
	mov rax, qword [rbp-504]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1552:
	mov qword [rbp-904], rax
	mov rax, r12
	sub rax, 1
	mov r14, rax
	mov r12, rbx
	mov rax, qword [rbp-664]
	mov rbx, rax
	l_1553:
	cmp r12, r14
	jl l_1554
	l_1555:
	mov rax, rbx
	jmp l_1556
	l_1554:
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1556:
	mov rdx, rax
	mov rcx, qword [rbp-560]
	mov r12, rcx
	mov rcx, qword [rbp-904]
	mov r15, rcx
	mov r13, rdx
	l_1557:
	cmp r15, r12
	jl l_1558
	l_1559:
	jmp l_1560
	l_1558:
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1560:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1544:
	mov qword [rbp-152], rax
	mov rax, qword [rbp-1072]
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-16]
	mov qword [rbp-448], rax
	mov rax, qword [rbp-920]
	mov r14, rax
	l_1561:
	mov rax, qword [rbp-448]
	cmp rax, rbx
	jl l_1562
	l_1563:
	mov rax, r14
	jmp l_1564
	l_1562:
	mov rax, rbx
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-448]
	mov r12, rax
	mov r15, r14
	l_1565:
	cmp r12, r13
	jl l_1566
	l_1567:
	mov rax, r15
	jmp l_1568
	l_1566:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1096], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-424], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-424]
	mov rsi, rax
	mov rax, qword [rbp-1096]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1568:
	mov qword [rbp-112], rax
	mov rax, qword [rbp-448]
	sub rax, 1
	mov r15, rax
	mov r13, r14
	mov r12, rbx
	l_1569:
	cmp r13, r15
	jl l_1570
	l_1571:
	mov rax, r12
	jmp l_1572
	l_1570:
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-296], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-760], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-760]
	mov rsi, rax
	mov rax, qword [rbp-296]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1572:
	mov qword [rbp-872], rax
	mov rax, r14
	sub rax, 1
	mov r13, rax
	mov r15, rbx
	mov rax, qword [rbp-448]
	mov r12, rax
	l_1573:
	cmp r15, r13
	jl l_1574
	l_1575:
	mov rax, r12
	jmp l_1576
	l_1574:
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1576:
	mov rcx, rax
	mov rdx, qword [rbp-112]
	mov rbx, rdx
	mov rdx, qword [rbp-872]
	mov r12, rdx
	mov r14, rcx
	l_1577:
	cmp r12, rbx
	jl l_1578
	l_1579:
	jmp l_1580
	l_1578:
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r12
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1580:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1564:
	mov qword [rbp-264], rax
	mov rax, qword [rbp-16]
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-920]
	mov qword [rbp-648], rax
	mov rax, qword [rbp-1072]
	mov r14, rax
	l_1581:
	mov rax, qword [rbp-648]
	cmp rax, r12
	jl l_1582
	l_1583:
	mov rax, r14
	jmp l_1584
	l_1582:
	mov rax, r12
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-648]
	mov rbx, rax
	mov r15, r14
	l_1585:
	cmp rbx, r13
	jl l_1586
	l_1587:
	mov rax, r15
	jmp l_1588
	l_1586:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-896], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-288], rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-288]
	mov rsi, rax
	mov rax, qword [rbp-896]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1588:
	mov qword [rbp-472], rax
	mov rax, qword [rbp-648]
	sub rax, 1
	mov r15, rax
	mov r13, r14
	mov rbx, r12
	l_1589:
	cmp r13, r15
	jl l_1590
	l_1591:
	mov rax, rbx
	jmp l_1592
	l_1590:
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-736], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1040], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1040]
	mov rsi, rax
	mov rax, qword [rbp-736]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1592:
	mov qword [rbp-1080], rax
	mov rax, r14
	sub rax, 1
	mov r14, rax
	mov r15, r12
	mov rax, qword [rbp-648]
	mov r12, rax
	l_1593:
	cmp r15, r14
	jl l_1594
	l_1595:
	mov rax, r12
	jmp l_1596
	l_1594:
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1596:
	mov rdx, rax
	mov rcx, qword [rbp-472]
	mov r14, rcx
	mov rcx, qword [rbp-1080]
	mov r13, rcx
	mov rbx, rdx
	l_1597:
	cmp r13, r14
	jl l_1598
	l_1599:
	jmp l_1600
	l_1598:
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1600:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1584:
	mov rdx, rax
	mov rcx, qword [rbp-152]
	mov r14, rcx
	mov rcx, qword [rbp-264]
	mov r12, rcx
	mov rcx, rdx
	mov qword [rbp-832], rcx
	l_1601:
	cmp r12, r14
	jl l_1602
	l_1603:
	jmp l_1604
	l_1602:
	mov rcx, r14
	sub rcx, 1
	mov rbx, rcx
	mov r15, r12
	mov rcx, qword [rbp-832]
	mov r13, rcx
	l_1605:
	cmp r15, rbx
	jl l_1606
	l_1607:
	jmp l_1608
	l_1606:
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-568], rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-512], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-512]
	mov rsi, rax
	mov rax, qword [rbp-568]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1608:
	mov qword [rbp-488], rax
	mov rax, r12
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-832]
	mov r15, rax
	mov rbx, r14
	l_1609:
	cmp r15, r13
	jl l_1610
	l_1611:
	mov rax, rbx
	jmp l_1612
	l_1610:
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1048], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-456], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-456]
	mov rsi, rax
	mov rax, qword [rbp-1048]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1612:
	mov qword [rbp-880], rax
	mov rax, qword [rbp-832]
	sub rax, 1
	mov rbx, rax
	mov r13, r14
	l_1613:
	cmp r13, rbx
	jl l_1614
	l_1615:
	mov rax, r12
	jmp l_1616
	l_1614:
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r14
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1616:
	mov rdx, rax
	mov rcx, qword [rbp-488]
	mov rbx, rcx
	mov rcx, qword [rbp-880]
	mov r14, rcx
	mov r13, rdx
	l_1617:
	cmp r14, rbx
	jl l_1618
	l_1619:
	jmp l_1620
	l_1618:
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1620:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1604:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1540:
	mov rdx, rax
	mov rcx, qword [rbp-440]
	mov qword [rbp-888], rcx
	mov rcx, qword [rbp-496]
	mov qword [rbp-200], rcx
	mov rcx, rdx
	mov qword [rbp-248], rcx
	l_1621:
	mov rcx, qword [rbp-200]
	mov rdx, qword [rbp-888]
	cmp rcx, rdx
	jl l_1622
	l_1623:
	jmp l_1624
	l_1622:
	mov rcx, qword [rbp-888]
	sub rcx, 1
	mov r15, rcx
	mov rcx, qword [rbp-200]
	mov rbx, rcx
	mov rcx, qword [rbp-248]
	mov qword [rbp-144], rcx
	l_1625:
	cmp rbx, r15
	jl l_1626
	l_1627:
	jmp l_1628
	l_1626:
	mov rcx, r15
	sub rcx, 1
	mov r14, rcx
	mov r12, rbx
	mov rcx, qword [rbp-144]
	mov r13, rcx
	l_1629:
	cmp r12, r14
	jl l_1630
	l_1631:
	jmp l_1632
	l_1630:
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1032], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-744], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-744]
	mov rsi, rax
	mov rax, qword [rbp-1032]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1632:
	mov qword [rbp-688], rax
	mov rax, rbx
	sub rax, 1
	mov r14, rax
	mov rax, qword [rbp-144]
	mov r13, rax
	mov r12, r15
	l_1633:
	cmp r13, r14
	jl l_1634
	l_1635:
	mov rax, r12
	jmp l_1636
	l_1634:
	mov rax, r14
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-840], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1064], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1064]
	mov rsi, rax
	mov rax, qword [rbp-840]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1636:
	mov qword [rbp-712], rax
	mov rax, qword [rbp-144]
	sub rax, 1
	mov r12, rax
	mov r13, r15
	mov r14, rbx
	l_1637:
	cmp r13, r12
	jl l_1638
	l_1639:
	mov rax, r14
	jmp l_1640
	l_1638:
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, rbx
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1640:
	mov rdx, rax
	mov rcx, qword [rbp-688]
	mov r14, rcx
	mov rcx, qword [rbp-712]
	mov r13, rcx
	mov r15, rdx
	l_1641:
	cmp r13, r14
	jl l_1642
	l_1643:
	jmp l_1644
	l_1642:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1644:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1628:
	mov qword [rbp-792], rax
	mov rax, qword [rbp-200]
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-248]
	mov qword [rbp-520], rax
	mov rax, qword [rbp-888]
	mov r14, rax
	l_1645:
	mov rax, qword [rbp-520]
	cmp rax, r12
	jl l_1646
	l_1647:
	mov rax, r14
	jmp l_1648
	l_1646:
	mov rax, r12
	sub rax, 1
	mov r13, rax
	mov rax, qword [rbp-520]
	mov rbx, rax
	mov r15, r14
	l_1649:
	cmp rbx, r13
	jl l_1650
	l_1651:
	mov rax, r15
	jmp l_1652
	l_1650:
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-320], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-864], rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-864]
	mov rsi, rax
	mov rax, qword [rbp-320]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1652:
	mov qword [rbp-160], rax
	mov rax, qword [rbp-520]
	sub rax, 1
	mov r15, rax
	mov rbx, r14
	mov r13, r12
	l_1653:
	cmp rbx, r15
	jl l_1654
	l_1655:
	mov rax, r13
	jmp l_1656
	l_1654:
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-408], rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-1056], rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-1056]
	mov rsi, rax
	mov rax, qword [rbp-408]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1656:
	mov qword [rbp-848], rax
	mov rax, r14
	sub rax, 1
	mov rbx, rax
	mov r13, r12
	mov rax, qword [rbp-520]
	mov r12, rax
	l_1657:
	cmp r13, rbx
	jl l_1658
	l_1659:
	mov rax, r12
	jmp l_1660
	l_1658:
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1660:
	mov rdx, rax
	mov rcx, qword [rbp-160]
	mov rbx, rcx
	mov rcx, qword [rbp-848]
	mov r14, rcx
	mov r15, rdx
	l_1661:
	cmp r14, rbx
	jl l_1662
	l_1663:
	jmp l_1664
	l_1662:
	mov rax, rbx
	sub rax, 1
	mov rdx, r15
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1664:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1648:
	mov qword [rbp-232], rax
	mov rax, qword [rbp-248]
	sub rax, 1
	mov rbx, rax
	mov rax, qword [rbp-888]
	mov qword [rbp-584], rax
	mov rax, qword [rbp-200]
	mov r15, rax
	l_1665:
	mov rax, qword [rbp-584]
	cmp rax, rbx
	jl l_1666
	l_1667:
	mov rax, r15
	jmp l_1668
	l_1666:
	mov rax, rbx
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-584]
	mov r13, rax
	mov r14, r15
	l_1669:
	cmp r13, r12
	jl l_1670
	l_1671:
	mov rax, r14
	jmp l_1672
	l_1670:
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-784], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-88], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-88]
	mov rsi, rax
	mov rax, qword [rbp-784]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1672:
	mov qword [rbp-704], rax
	mov rax, qword [rbp-584]
	sub rax, 1
	mov r12, rax
	mov r13, r15
	mov r14, rbx
	l_1673:
	cmp r13, r12
	jl l_1674
	l_1675:
	mov rax, r14
	jmp l_1676
	l_1674:
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-256], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-464], rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-464]
	mov rsi, rax
	mov rax, qword [rbp-256]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1676:
	mov qword [rbp-48], rax
	mov rax, r15
	sub rax, 1
	mov r14, rax
	mov r13, rbx
	mov rax, qword [rbp-584]
	mov r15, rax
	l_1677:
	cmp r13, r14
	jl l_1678
	l_1679:
	mov rax, r15
	jmp l_1680
	l_1678:
	mov rax, r14
	sub rax, 1
	mov rdx, r15
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r13
	sub rax, 1
	mov rdx, r14
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r15
	sub rax, 1
	mov rdx, r13
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, rbx
	mov rdi, r12
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1680:
	mov rcx, rax
	mov rdx, qword [rbp-704]
	mov r12, rdx
	mov rdx, qword [rbp-48]
	mov rbx, rdx
	mov r15, rcx
	l_1681:
	cmp rbx, r12
	jl l_1682
	l_1683:
	jmp l_1684
	l_1682:
	mov rax, r12
	sub rax, 1
	mov rdx, r15
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, r15
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r13
	mov rdi, r14
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1684:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1668:
	mov rcx, rax
	mov rdx, qword [rbp-792]
	mov r14, rdx
	mov rdx, qword [rbp-232]
	mov rbx, rdx
	mov qword [rbp-552], rcx
	l_1685:
	cmp rbx, r14
	jl l_1686
	l_1687:
	jmp l_1688
	l_1686:
	mov rcx, r14
	sub rcx, 1
	mov r15, rcx
	mov r13, rbx
	mov rcx, qword [rbp-552]
	mov r12, rcx
	l_1689:
	cmp r13, r15
	jl l_1690
	l_1691:
	jmp l_1692
	l_1690:
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-952], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-120], rax
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-120]
	mov rsi, rax
	mov rax, qword [rbp-952]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1692:
	mov qword [rbp-624], rax
	mov rax, rbx
	sub rax, 1
	mov r12, rax
	mov rax, qword [rbp-552]
	mov r15, rax
	mov r13, r14
	l_1693:
	cmp r15, r12
	jl l_1694
	l_1695:
	mov rax, r13
	jmp l_1696
	l_1694:
	mov rax, r12
	sub rax, 1
	mov rdx, r13
	mov rsi, r15
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-936], rax
	mov rax, r15
	sub rax, 1
	mov rdx, r12
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-768], rax
	mov rax, r13
	sub rax, 1
	mov rdx, r15
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rax, qword [rbp-768]
	mov rsi, rax
	mov rax, qword [rbp-936]
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1696:
	mov qword [rbp-752], rax
	mov rax, qword [rbp-552]
	sub rax, 1
	mov r13, rax
	l_1697:
	cmp r14, r13
	jl l_1698
	l_1699:
	mov rax, rbx
	jmp l_1700
	l_1698:
	mov rax, r13
	sub rax, 1
	mov rdx, rbx
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, r13
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r14
	mov rsi, r13
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r12
	mov rdi, r15
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1700:
	mov rdx, rax
	mov rcx, qword [rbp-624]
	mov r12, rcx
	mov rcx, qword [rbp-752]
	mov rbx, rcx
	mov r14, rdx
	l_1701:
	cmp rbx, r12
	jl l_1702
	l_1703:
	jmp l_1704
	l_1702:
	mov rax, r12
	sub rax, 1
	mov rdx, r14
	mov rsi, rbx
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r13, rax
	mov rax, rbx
	sub rax, 1
	mov rdx, r12
	mov rsi, r14
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r14
	sub rax, 1
	mov rdx, rbx
	mov rsi, r12
	mov rdi, rax
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rdx, rax
	mov rsi, r15
	mov rdi, r13
	call _tak_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1704:
	mov rcx, rax
	mov rax, 1
	add rax, rcx
	l_1688:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1624:
	mov rcx, 1
	add rcx, rax
	mov rax, rcx
	l_1368:
	mov rdi, rax
	call __toString 
	mov rdi, rax
	call __println 
	mov rax, 0
	l_1705:
	pop r12
	pop r14
	pop rbx
	pop r13
	pop r15
	leave 
	ret
__init:
	l_1706:
	push rbp
	mov rbp, rsp
	call _main_User_Defined_fihriaifhiahidsafans 
	leave 
	ret
	 section .data

