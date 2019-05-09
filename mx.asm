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
_random_User_Defined_fihriaifhiahidsafans:
	l_0:
	push rbp
	mov rbp, rsp
	mov r8, qword [g_0]
	mov r10, qword [g_1]
	mov r9, qword [g_2]
	mov rsi, qword [g_3]
	mov rdi, qword [g_4]
	mov rax, r9
	xor rdx, rdx
	cdq
	idiv r8d
	mov rcx, rdx
	mov rax, rdi
	imul rcx
	mov rcx, rax
	mov rax, r9
	xor rdx, rdx
	cdq
	idiv r8d
	mov rdx, rax
	mov rax, rsi
	imul rdx
	mov rdx, rax
	mov rax, rcx
	sub rax, rdx
	cmp rax, 0
	jge l_1
	l_2:
	add rax, r10
	mov r9, rax
	jmp l_3
	l_1:
	mov r9, rax
	l_3:
	mov rax, r9
	l_4:
	mov qword [g_0], r8
	mov qword [g_1], r10
	mov qword [g_2], r9
	mov qword [g_3], rsi
	mov qword [g_4], rdi
	leave 
	ret
_initialize_User_Defined_fihriaifhiahidsafans:
	l_5:
	push rbp
	mov rbp, rsp
	mov rax, rdi
	mov rcx, qword [g_2]
	mov rcx, rax
	l_6:
	mov qword [g_2], rcx
	leave 
	ret
_swap_User_Defined_fihriaifhiahidsafans:
	l_7:
	push rbp
	mov rbp, rsp
	mov rcx, rdi
	mov rdx, rsi
	mov rdi, qword [g_5]
	mov rax, qword [rdi + rcx * 8 + 8]
	mov rsi, qword [rdi + rdx * 8 + 8]
	mov qword [rdi + rcx * 8 + 8], rsi
	mov qword [rdi + rdx * 8 + 8], rax
	l_8:
	mov qword [g_5], rdi
	leave 
	ret
_pd_User_Defined_fihriaifhiahidsafans:
	l_9:
	push rbp
	mov rbp, rsp
	mov rsi, rdi
	mov r8, qword [g_6]
	l_10:
	cmp r8, rsi
	jle l_11
	l_12:
	l_13:
	mov rax, 0
	l_14:
	jmp l_15
	l_11:
	mov rcx, r8
	add rcx, 1
	mov rax, r8
	imul rcx
	xor rdx, rdx
	cdq
	mov rdi, 2
	idiv edi
	cmp rsi, rax
	je l_16
	l_17:
	l_18:
	mov r8, rcx
	jmp l_10
	l_16:
	l_19:
	mov rax, 1
	l_20:
	l_15:
	mov qword [g_6], r8
	leave 
	ret
_show_User_Defined_fihriaifhiahidsafans:
	l_21:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push rbx
	push r13
	push r14
	mov r13, qword [g_7]
	mov r14, qword [g_5]
	mov rbx, 0
	l_22:
	cmp rbx, r13
	jl l_23
	l_24:
	mov rdi, g_8
	call __println 
	l_25:
	mov qword [g_7], r13
	mov qword [g_5], r14
	pop r14
	pop r13
	pop rbx
	leave 
	ret
	l_23:
	mov rdi, qword [r14 + rbx * 8 + 8]
	call __toString 
	mov rsi, g_9
	mov rdi, rax
	call __stringConcat 
	mov rdi, rax
	call __print 
	l_26:
	inc rbx
	jmp l_22
_win_User_Defined_fihriaifhiahidsafans:
	l_27:
	push rbp
	mov rbp, rsp
	push r12
	push rbx
	push r13
	push r14
	mov r13, qword [g_7]
	mov rbx, qword [g_6]
	mov r14, qword [g_5]
	mov r12, 100
	lea rax, [r12 * 8 + 8]
	mov rdi, rax
	call malloc 
	mov qword [rax], 100
	l_28:
	cmp r12, 0
	jg l_29
	l_30:
	mov rsi, rax
	cmp r13, rbx
	jne l_31
	l_32:
	mov rdx, 0
	l_33:
	cmp rdx, r13
	jl l_34
	l_35:
	mov rax, 0
	l_36:
	mov rcx, r13
	sub rcx, 1
	cmp rax, rcx
	jl l_37
	l_38:
	mov rax, 0
	l_39:
	cmp rax, r13
	jl l_40
	l_41:
	l_42:
	mov rax, 1
	l_43:
	jmp l_44
	l_40:
	mov rcx, rax
	add rcx, 1
	cmp qword [rsi + rax * 8 + 8], rcx
	jne l_45
	l_46:
	l_47:
	mov rax, rcx
	jmp l_39
	l_45:
	l_48:
	mov rax, 0
	l_49:
	jmp l_44
	l_37:
	mov rcx, rax
	add rcx, 1
	mov rdx, rcx
	l_50:
	cmp rdx, r13
	jl l_51
	l_52:
	l_53:
	inc rax
	jmp l_36
	l_51:
	mov rcx, qword [rsi + rax * 8 + 8]
	cmp rcx, qword [rsi + rdx * 8 + 8]
	jle l_54
	l_55:
	mov rcx, qword [rsi + rax * 8 + 8]
	mov rdi, qword [rsi + rdx * 8 + 8]
	mov qword [rsi + rax * 8 + 8], rdi
	mov qword [rsi + rdx * 8 + 8], rcx
	l_54:
	l_56:
	inc rdx
	jmp l_50
	l_34:
	mov rax, qword [r14 + rdx * 8 + 8]
	mov qword [rsi + rdx * 8 + 8], rax
	l_57:
	inc rdx
	jmp l_33
	l_31:
	l_58:
	mov rax, 0
	l_59:
	l_44:
	mov qword [g_7], r13
	mov qword [g_6], rbx
	mov qword [g_5], r14
	pop r14
	pop r13
	pop rbx
	pop r12
	leave 
	ret
	l_29:
	mov qword [rax + r12 * 8], 0
	dec r12
	jmp l_28
_merge_User_Defined_fihriaifhiahidsafans:
	l_60:
	push rbp
	mov rbp, rsp
	push r13
	push r14
	mov r13, qword [g_7]
	mov rax, qword [g_5]
	mov r14, 0
	l_61:
	cmp r14, r13
	jl l_62
	l_63:
	mov r14, 0
	l_64:
	cmp r14, r13
	jge l_65
	l_66:
	cmp qword [rax + r14 * 8 + 8], 0
	je l_67
	l_68:
	l_69:
	inc r14
	jmp l_64
	l_67:
	mov r13, r14
	l_65:
	l_70:
	mov qword [g_7], r13
	mov qword [g_5], rax
	pop r14
	pop r13
	leave 
	ret
	l_62:
	cmp qword [rax + r14 * 8 + 8], 0
	jne l_71
	l_72:
	mov rcx, r14
	add rcx, 1
	l_73:
	cmp rcx, r13
	jge l_74
	l_75:
	cmp qword [rax + rcx * 8 + 8], 0
	jne l_76
	l_77:
	l_78:
	inc rcx
	jmp l_73
	l_76:
	mov qword [g_5], rax
	mov rsi, rcx
	mov rdi, r14
	call _swap_User_Defined_fihriaifhiahidsafans 
	mov rax, qword [g_5]
	l_74:
	l_71:
	l_79:
	inc r14
	jmp l_61
_move_User_Defined_fihriaifhiahidsafans:
	l_80:
	push rbp
	mov rbp, rsp
	mov rcx, qword [g_7]
	mov rdx, qword [g_5]
	mov rax, 0
	l_81:
	cmp rax, rcx
	jl l_82
	l_83:
	mov qword [rdx + rcx * 8 + 8], rcx
	inc rcx
	l_84:
	mov qword [g_7], rcx
	mov qword [g_5], rdx
	leave 
	ret
	l_82:
	dec qword [rdx + rax * 8 + 8]
	add rax, 1
	jmp l_81
_main_User_Defined_fihriaifhiahidsafans:
	l_85:
	push rbp
	mov rbp, rsp
	sub rsp, 40
	push r15
	push r12
	push rbx
	push r13
	push r14
	mov rax, qword [g_10]
	mov qword [g_10], rax
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov r13, qword [g_7]
	mov rbx, qword [g_1]
	mov rax, qword [g_6]
	mov qword [g_6], rax
	mov r15, qword [g_5]
	mov r12, qword [g_3]
	mov r14, qword [g_4]
	mov rax, 0
	mov qword [rbp-8], rax
	mov rax, 0
	mov qword [rbp-24], rax
	mov rax, 0
	mov qword [rbp-16], rax
	mov rax, 210
	mov qword [g_10], rax
	mov rax, 0
	mov qword [g_6], rax
	mov r12, 100
	lea rcx, [r12 * 8 + 8]
	mov rdi, rcx
	call malloc 
	mov qword [rax], 100
	l_86:
	cmp r12, 0
	jg l_87
	l_88:
	mov r15, rax
	mov rax, rbx
	xor rdx, rdx
	cdq
	idiv r14d
	mov qword [g_0], rax
	mov rax, rbx
	xor rdx, rdx
	cdq
	idiv r14d
	mov rax, rdx
	mov r12, rax
	mov rax, qword [g_6]
	mov qword [g_6], rax
	mov rax, qword [g_10]
	mov rdi, rax
	call _pd_User_Defined_fihriaifhiahidsafans 
	mov rcx, qword [g_6]
	mov qword [g_6], rcx
	cmp rax, 0
	jne l_89
	l_90:
	mov rdi, g_11
	call __println 
	mov rax, 1
	jmp l_91
	l_89:
	mov rdi, g_12
	call __println 
	mov rdi, 3654898
	call _initialize_User_Defined_fihriaifhiahidsafans 
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov qword [g_1], rbx
	mov qword [g_3], r12
	mov qword [g_4], r14
	call _random_User_Defined_fihriaifhiahidsafans 
	mov r14, qword [g_4]
	mov r12, qword [g_3]
	mov rbx, qword [g_1]
	mov rcx, qword [g_0]
	mov qword [g_0], rcx
	xor rdx, rdx
	cdq
	mov rcx, 10
	idiv ecx
	mov rax, rdx
	add rax, 1
	mov r13, rax
	mov rdi, r13
	call __toString 
	mov rdi, rax
	call __println 
	l_92:
	mov rcx, r13
	sub rcx, 1
	mov rax, qword [rbp-8]
	cmp rax, rcx
	jl l_93
	l_94:
	mov rdx, rcx
	mov rax, qword [g_10]
	mov rcx, rax
	mov rax, qword [rbp-24]
	sub rcx, rax
	mov qword [r15 + rdx * 8 + 8], rcx
	mov qword [g_7], r13
	mov qword [g_5], r15
	call _show_User_Defined_fihriaifhiahidsafans 
	mov r15, qword [g_5]
	mov r13, qword [g_7]
	mov qword [g_7], r13
	mov qword [g_5], r15
	call _merge_User_Defined_fihriaifhiahidsafans 
	mov r15, qword [g_5]
	mov r13, qword [g_7]
	l_95:
	mov qword [g_7], r13
	mov rax, qword [g_6]
	mov qword [g_6], rax
	mov qword [g_5], r15
	call _win_User_Defined_fihriaifhiahidsafans 
	mov r15, qword [g_5]
	mov rcx, qword [g_6]
	mov qword [g_6], rcx
	mov r13, qword [g_7]
	cmp rax, 0
	jne l_96
	l_97:
	mov rax, qword [rbp-16]
	inc rax
	mov qword [rbp-16], rax
	mov rax, qword [rbp-16]
	mov rdi, rax
	call __toString 
	mov rsi, rax
	mov rdi, g_13
	call __stringConcat 
	mov rsi, g_14
	mov rdi, rax
	call __stringConcat 
	mov rdi, rax
	call __println 
	mov qword [g_7], r13
	mov qword [g_5], r15
	call _move_User_Defined_fihriaifhiahidsafans 
	mov r15, qword [g_5]
	mov r13, qword [g_7]
	mov qword [g_7], r13
	mov qword [g_5], r15
	call _merge_User_Defined_fihriaifhiahidsafans 
	mov r15, qword [g_5]
	mov r13, qword [g_7]
	mov qword [g_7], r13
	mov qword [g_5], r15
	call _show_User_Defined_fihriaifhiahidsafans 
	mov r15, qword [g_5]
	mov r13, qword [g_7]
	jmp l_95
	l_96:
	mov rax, qword [rbp-16]
	mov rdi, rax
	call __toString 
	mov rsi, rax
	mov rdi, g_15
	call __stringConcat 
	mov rsi, g_16
	mov rdi, rax
	call __stringConcat 
	mov rdi, rax
	call __println 
	mov rax, 0
	l_91:
	mov rcx, qword [g_10]
	mov qword [g_10], rcx
	mov rcx, qword [g_0]
	mov qword [g_0], rcx
	mov qword [g_7], r13
	mov qword [g_1], rbx
	mov rcx, qword [g_6]
	mov qword [g_6], rcx
	mov qword [g_5], r15
	mov qword [g_3], r12
	mov qword [g_4], r14
	pop r14
	pop r13
	pop rbx
	pop r12
	pop r15
	leave 
	ret
	l_93:
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov qword [g_1], rbx
	mov qword [g_3], r12
	mov qword [g_4], r14
	call _random_User_Defined_fihriaifhiahidsafans 
	mov r14, qword [g_4]
	mov r12, qword [g_3]
	mov rbx, qword [g_1]
	mov rcx, qword [g_0]
	mov qword [g_0], rcx
	xor rdx, rdx
	cdq
	mov rcx, 10
	idiv ecx
	mov rax, rdx
	add rax, 1
	mov rcx, qword [rbp-8]
	mov qword [r15 + rcx * 8 + 8], rax
	l_98:
	mov rax, qword [rbp-8]
	mov rax, qword [r15 + rax * 8 + 8]
	mov rcx, qword [rbp-24]
	add rax, rcx
	mov rcx, qword [g_10]
	cmp rax, rcx
	jg l_99
	l_100:
	mov rax, qword [rbp-8]
	mov rcx, qword [rbp-24]
	add rcx, qword [r15 + rax * 8 + 8]
	mov qword [rbp-24], rcx
	l_101:
	mov rax, qword [rbp-8]
	inc rax
	mov qword [rbp-8], rax
	jmp l_92
	l_99:
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov qword [g_1], rbx
	mov qword [g_3], r12
	mov qword [g_4], r14
	call _random_User_Defined_fihriaifhiahidsafans 
	mov r14, qword [g_4]
	mov r12, qword [g_3]
	mov rbx, qword [g_1]
	mov rcx, qword [g_0]
	mov qword [g_0], rcx
	xor rdx, rdx
	cdq
	mov rcx, 10
	idiv ecx
	mov rax, rdx
	mov rcx, rax
	add rcx, 1
	mov rax, qword [rbp-8]
	mov qword [r15 + rax * 8 + 8], rcx
	jmp l_98
	l_87:
	mov qword [rax + r12 * 8], 0
	dec r12
	jmp l_86
__init:
	l_102:
	push rbp
	mov rbp, rsp
	mov rcx, 48271
	mov rsi, 2147483647
	mov rdx, 1
	mov qword [g_1], rsi
	mov qword [g_2], rdx
	mov qword [g_4], rcx
	call _main_User_Defined_fihriaifhiahidsafans 
	mov rcx, qword [g_4]
	mov rdx, qword [g_2]
	mov rsi, qword [g_1]
	leave 
	ret
	 section .data
g_10:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_6:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_7:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_5:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_4:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_1:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_0:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_3:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_2:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_9:
	dq 1
	db 20H, 00H
g_8:
	dq 0
	db 00H
g_11:
	dq 79
	db 53H, 6FH, 72H, 72H, 79H, 2CH, 20H, 74H, 68H, 65H, 20H, 6EH, 75H, 6DH, 62H, 65H, 72H, 20H, 6EH, 20H, 6DH, 75H, 73H, 74H, 20H, 62H, 65H, 20H, 61H, 20H, 6EH, 75H, 6DH, 62H, 65H, 72H, 20H, 73H, 2EH, 74H, 2EH, 20H, 74H, 68H, 65H, 72H, 65H, 20H, 65H, 78H, 69H, 73H, 74H, 73H, 20H, 69H, 20H, 73H, 61H, 74H, 69H, 73H, 66H, 79H, 69H, 6EH, 67H, 20H, 6EH, 3DH, 31H, 2BH, 32H, 2BH, 2EH, 2EH, 2EH, 2BH, 69H, 00H
g_12:
	dq 12
	db 4CH, 65H, 74H, 27H, 73H, 20H, 73H, 74H, 61H, 72H, 74H, 21H, 00H
g_13:
	dq 5
	db 73H, 74H, 65H, 70H, 20H, 00H
g_14:
	dq 1
	db 3AH, 00H
g_15:
	dq 7
	db 54H, 6FH, 74H, 61H, 6CH, 3AH, 20H, 00H
g_16:
	dq 8
	db 20H, 73H, 74H, 65H, 70H, 28H, 73H, 29H, 00H

