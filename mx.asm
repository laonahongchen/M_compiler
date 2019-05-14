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
_max_User_Defined_fihriaifhiahidsafans:
	l_0:
	push rbp
	mov rbp, rsp
	mov rcx, rdi
	mov rax, rsi
	cmp rcx, rax
	jg l_1
	l_2:
	jmp l_3
	l_1:
	mov rax, rcx
	l_3:
	leave 
	ret
_equ_User_Defined_fihriaifhiahidsafans:
	l_4:
	push rbp
	mov rbp, rsp
	mov rax, rdi
	mov rcx, rsi
	cmp rax, 0
	je l_5
	l_6:
	cmp rcx, 0
	je l_7
	l_8:
	mov rax, qword [rax]
	cmp rax, qword [rcx]
	je l_9
	l_10:
	mov rax, 0
	jmp l_11
	l_9:
	mov rax, 1
	l_11:
	jmp l_12
	l_7:
	l_13:
	mov rax, 0
	l_14:
	jmp l_12
	l_5:
	cmp rcx, 0
	je l_15
	l_16:
	l_17:
	mov rax, 0
	l_18:
	jmp l_12
	l_15:
	l_19:
	mov rax, 1
	l_20:
	l_12:
	leave 
	ret
_merge_User_Defined_fihriaifhiahidsafans:
	l_21:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r15
	push r14
	mov rbx, rdi
	mov r14, rsi
	mov r15, rdx
	mov rax, r14
	mov rcx, rbx
	add rcx, 1
	mov rsi, rcx
	mov rdi, rax
	call _find_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r12
	mov rsi, 0
	mov rdi, rax
	call _rotto_User_Defined_fihriaifhiahidsafans 
	mov rax, r14
	mov qword [rax], r12
	mov rax, r14
	mov rsi, rbx
	mov rdi, rax
	call _find_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rcx, r12
	mov rax, r14
	mov rsi, qword [rax]
	mov rdi, rcx
	call _rotto_User_Defined_fihriaifhiahidsafans 
	mov rax, r12
	mov rax, qword [rax + 80]
	mov rcx, r15
	mov rcx, qword [rcx]
	mov qword [rax + 16], rcx
	mov rax, r15
	mov rax, qword [rax]
	mov qword [rax + 88], r12
	mov rax, r12
	mov rsi, 0
	mov rdi, rax
	call _rotto_User_Defined_fihriaifhiahidsafans 
	mov rax, r14
	mov qword [rax], r12
	l_22:
	pop r14
	pop r15
	pop r12
	pop rbx
	leave 
	ret
_main_User_Defined_fihriaifhiahidsafans:
	l_23:
	push rbp
	mov rbp, rsp
	sub rsp, 24
	push r13
	push rbx
	push r12
	push r15
	push r14
	call __getInt 
	mov qword [g_0], rax
	call __getInt 
	mov qword [g_1], rax
	mov rdi, 8
	call malloc 
	mov r14, rax
	mov rdi, r14
	call _splay_tree_User_Defined_fihriaifhiahidsafans 
	mov rax, r14
	mov qword [g_2], rax
	mov rdi, 8
	call malloc 
	mov r14, rax
	mov rdi, r14
	call _splay_tree_User_Defined_fihriaifhiahidsafans 
	mov rax, r14
	mov qword [g_3], rax
	mov rax, qword [g_4]
	mov rcx, rax
	neg rcx
	mov rax, qword [g_5]
	mov qword [rax + 8], rcx
	mov rax, qword [g_0]
	mov rcx, rax
	add rcx, 1
	mov rax, qword [g_4]
	mov rdx, rax
	neg rdx
	mov rax, qword [g_5]
	mov qword [rax + rcx * 8 + 8], rdx
	mov r15, 1
	l_24:
	mov rax, qword [g_0]
	cmp r15, rax
	jle l_25
	l_26:
	mov rax, qword [g_2]
	mov rcx, rax
	mov rax, qword [g_0]
	add rax, 1
	mov rdx, rax
	mov rsi, 0
	mov rdi, rcx
	call _build_tree_User_Defined_fihriaifhiahidsafans 
	mov r15, 1
	l_27:
	mov rax, qword [g_1]
	cmp r15, rax
	jle l_28
	l_29:
	mov rax, 0
	l_30:
	pop r14
	pop r15
	pop r12
	pop rbx
	pop r13
	leave 
	ret
	l_28:
	call __getString 
	mov r12, rax
	mov rax, r12
	mov rsi, 0
	mov rdi, rax
	call __string_ord 
	mov r14, rax
	mov rax, qword [g_6]
	mov rsi, 0
	mov rdi, rax
	call __string_ord 
	cmp r14, rax
	jne l_31
	l_32:
	call __getInt 
	mov r14, rax
	call __getInt 
	mov rbx, rax
	mov r13, 1
	l_33:
	cmp r13, rbx
	jle l_34
	l_35:
	mov rax, qword [g_3]
	mov rdx, rbx
	mov rsi, 1
	mov rdi, rax
	call _build_tree_User_Defined_fihriaifhiahidsafans 
	mov rax, r14
	add rax, 1
	mov r13, rax
	mov rax, qword [g_2]
	mov r14, rax
	mov rax, qword [g_3]
	mov qword [rbp-8], rax
	l_36:
	mov rcx, r14
	mov rax, r13
	add rax, 1
	mov rsi, rax
	mov rdi, rcx
	call _find_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, rbx
	mov rsi, 0
	mov rdi, rax
	call _rotto_User_Defined_fihriaifhiahidsafans 
	mov rax, r14
	mov qword [rax], rbx
	mov rax, r14
	mov rsi, r13
	mov rdi, rax
	call _find_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rcx, rbx
	mov rax, r14
	mov rsi, qword [rax]
	mov rdi, rcx
	call _rotto_User_Defined_fihriaifhiahidsafans 
	mov rax, rbx
	mov rax, qword [rax + 80]
	mov rcx, qword [rbp-8]
	mov rcx, qword [rcx]
	mov qword [rax + 16], rcx
	mov rax, qword [rbp-8]
	mov rax, qword [rax]
	mov qword [rax + 88], rbx
	mov rax, rbx
	mov rsi, 0
	mov rdi, rax
	call _rotto_User_Defined_fihriaifhiahidsafans 
	mov rax, r14
	mov qword [rax], rbx
	l_37:
	l_31:
	mov rax, r12
	mov rsi, 0
	mov rdi, rax
	call __string_ord 
	mov r14, rax
	mov rax, qword [g_6]
	mov rsi, 1
	mov rdi, rax
	call __string_ord 
	cmp r14, rax
	jne l_38
	l_39:
	call __getInt 
	mov r14, rax
	call __getInt 
	mov rcx, rax
	mov rax, qword [g_2]
	mov rdi, rax
	mov rax, r14
	add rax, 1
	mov rdx, r14
	add rdx, rcx
	mov rsi, rax
	call _del_User_Defined_fihriaifhiahidsafans 
	l_38:
	mov rax, r12
	mov rsi, 0
	mov rdi, rax
	call __string_ord 
	cmp rax, 82
	jne l_40
	l_41:
	call __getInt 
	mov r14, rax
	call __getInt 
	mov rcx, rax
	mov rax, qword [g_2]
	mov rdi, rax
	mov rsi, r14
	add rsi, 1
	mov rax, r14
	add rax, rcx
	mov rdx, rax
	call _rol_User_Defined_fihriaifhiahidsafans 
	l_40:
	mov rax, r12
	mov rsi, 0
	mov rdi, rax
	call __string_ord 
	cmp rax, 71
	jne l_42
	l_43:
	call __getInt 
	mov r14, rax
	call __getInt 
	cmp rax, 0
	jg l_44
	l_45:
	mov rdi, g_7
	call __print 
	jmp l_46
	l_44:
	mov rcx, qword [g_2]
	mov rdi, rcx
	mov rcx, r14
	add rcx, 1
	mov rdx, r14
	add rdx, rax
	mov rsi, rcx
	call _getsum_User_Defined_fihriaifhiahidsafans 
	mov rdi, rax
	call __toString 
	mov rdi, rax
	call __println 
	l_46:
	l_42:
	mov rax, r12
	mov rsi, 0
	mov rdi, rax
	call __string_ord 
	cmp rax, 77
	jne l_47
	l_48:
	mov rax, r12
	mov rsi, 2
	mov rdi, rax
	call __string_ord 
	cmp rax, 75
	je l_49
	l_50:
	mov rax, qword [g_2]
	mov rdi, rax
	call _getMax_User_Defined_fihriaifhiahidsafans 
	mov rdi, rax
	call __toString 
	mov rsi, g_8
	mov rdi, rax
	call __stringConcat 
	mov rdi, rax
	call __print 
	jmp l_51
	l_49:
	call __getInt 
	mov r12, rax
	call __getInt 
	mov r14, rax
	call __getInt 
	mov rcx, qword [g_2]
	mov rdi, rcx
	mov rsi, r12
	add rsi, 1
	mov rdx, r12
	add rdx, r14
	mov rcx, rax
	call _change_User_Defined_fihriaifhiahidsafans 
	l_51:
	l_47:
	l_52:
	inc r15
	jmp l_27
	l_34:
	call __getInt 
	mov rcx, qword [g_5]
	mov qword [rcx + r13 * 8 + 8], rax
	l_53:
	inc r13
	jmp l_33
	l_25:
	call __getInt 
	mov rcx, rax
	mov rax, qword [g_5]
	mov qword [rax + r15 * 8 + 8], rcx
	l_54:
	inc r15
	jmp l_24
_Node_User_Defined_fihriaifhiahidsafans:
	l_55:
	push rbp
	mov rbp, rsp
	l_56:
	leave 
	ret
_copy_User_Defined_fihriaifhiahidsafans:
	l_57:
	push rbp
	mov rbp, rsp
	mov rcx, rdi
	mov rdx, rsi
	mov rax, rdx
	mov rax, qword [rax]
	mov qword [rcx], rax
	mov rax, rdx
	mov rax, qword [rax + 8]
	mov qword [rcx + 8], rax
	mov rax, rdx
	mov rax, qword [rax + 16]
	mov qword [rcx + 16], rax
	mov rax, rdx
	mov rax, qword [rax + 24]
	mov qword [rcx + 24], rax
	mov rax, rdx
	mov rax, qword [rax + 32]
	mov qword [rcx + 32], rax
	mov rax, rdx
	mov rax, qword [rax + 40]
	mov qword [rcx + 40], rax
	mov rax, rdx
	mov rax, qword [rax + 48]
	mov qword [rcx + 48], rax
	mov rax, rdx
	mov rax, qword [rax + 56]
	mov qword [rcx + 56], rax
	mov rax, rdx
	mov rax, qword [rax + 64]
	mov qword [rcx + 64], rax
	mov rax, rdx
	mov rax, qword [rax + 72]
	mov qword [rcx + 72], rax
	mov rsi, qword [rcx + 80]
	mov rax, rdx
	mov rax, qword [rax + 80]
	mov rax, qword [rax + 8]
	mov qword [rsi + 8], rax
	mov rsi, qword [rcx + 80]
	mov rax, rdx
	mov rax, qword [rax + 80]
	mov rax, qword [rax + 16]
	mov qword [rsi + 16], rax
	mov rax, rdx
	mov rax, qword [rax + 88]
	mov qword [rcx + 88], rax
	l_58:
	leave 
	ret
_init_User_Defined_fihriaifhiahidsafans:
	l_59:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push r12
	push r15
	push r14
	mov r15, rdi
	mov rax, rsi
	mov rcx, rdx
	mov qword [r15], rcx
	mov qword [r15 + 16], 1
	mov qword [r15 + 32], 0
	mov qword [r15 + 48], 0
	mov qword [r15 + 40], 0
	mov qword [r15 + 24], rax
	mov qword [r15 + 8], rax
	mov qword [r15 + 56], rax
	mov qword [r15 + 64], rax
	mov qword [r15 + 72], rax
	mov r14, 2
	lea rdx, [r14 * 8 + 8]
	mov rdi, rdx
	call malloc 
	mov r12, rax
	mov qword [r12], 2
	l_60:
	cmp r14, 0
	jg l_61
	l_62:
	mov qword [r15 + 80], r12
	mov rax, qword [r15 + 80]
	mov qword [rax + 8], 0
	mov rax, qword [r15 + 80]
	mov qword [rax + 16], 0
	mov qword [r15 + 88], 0
	l_63:
	pop r14
	pop r15
	pop r12
	leave 
	ret
	l_61:
	mov rdi, 8
	call malloc 
	add rax, 8
	mov qword [rax], 0
	sub rax, 8
	mov qword [r12 + r14 * 8], rax
	dec r14
	jmp l_60
_judge_User_Defined_fihriaifhiahidsafans:
	l_64:
	push rbp
	mov rbp, rsp
	mov rax, rdi
	mov rcx, rsi
	mov rax, qword [rax + 80]
	mov rax, qword [rax + 8]
	l_65:
	cmp rax, 0
	je l_66
	l_67:
	cmp rcx, 0
	je l_68
	l_69:
	mov rax, qword [rax]
	cmp rax, qword [rcx]
	je l_70
	l_71:
	mov rax, 0
	jmp l_72
	l_70:
	mov rax, 1
	l_72:
	jmp l_73
	l_68:
	l_74:
	mov rax, 0
	l_75:
	jmp l_73
	l_66:
	cmp rcx, 0
	je l_76
	l_77:
	l_78:
	mov rax, 0
	l_79:
	jmp l_73
	l_76:
	l_80:
	mov rax, 1
	l_81:
	l_73:
	cmp rax, 0
	jne l_82
	l_83:
	mov rax, 1
	jmp l_84
	l_82:
	mov rax, 0
	l_84:
	leave 
	ret
_push_up_User_Defined_fihriaifhiahidsafans:
	l_85:
	push rbp
	mov rbp, rsp
	mov rdx, rdi
	mov qword [rdx + 16], 1
	mov rax, qword [rdx + 8]
	mov qword [rdx + 24], rax
	mov rsi, 0
	l_86:
	cmp rsi, 2
	jl l_87
	l_88:
	mov rax, qword [rdx + 8]
	mov qword [rdx + 56], rax
	mov rax, qword [rdx + 8]
	mov qword [rdx + 64], rax
	mov rax, qword [rdx + 8]
	mov qword [rdx + 72], rax
	mov rcx, qword [rdx + 8]
	mov rsi, qword [rdx + 8]
	mov rax, qword [rdx + 80]
	cmp qword [rax + 8], 0
	je l_89
	l_90:
	mov rax, qword [rdx + 80]
	mov rax, qword [rax + 8]
	mov rax, qword [rax + 56]
	mov qword [rdx + 56], rax
	mov rax, qword [rdx + 80]
	mov rax, qword [rax + 8]
	add rcx, qword [rax + 24]
	mov rax, qword [rdx + 80]
	mov rax, qword [rax + 8]
	mov rax, qword [rax + 64]
	l_91:
	cmp rax, 0
	jg l_92
	l_93:
	mov rax, 0
	jmp l_94
	l_92:
	l_94:
	add rsi, rax
	l_89:
	mov rax, qword [rdx + 80]
	cmp qword [rax + 16], 0
	je l_95
	l_96:
	mov rax, qword [rdx + 80]
	mov rax, qword [rax + 16]
	mov rax, qword [rax + 64]
	mov qword [rdx + 64], rax
	mov rax, qword [rdx + 80]
	mov rax, qword [rax + 16]
	add rsi, qword [rax + 24]
	mov rax, qword [rdx + 80]
	mov rax, qword [rax + 16]
	mov rax, qword [rax + 56]
	l_97:
	cmp rax, 0
	jg l_98
	l_99:
	mov rax, 0
	jmp l_100
	l_98:
	l_100:
	add rcx, rax
	l_95:
	mov rax, qword [rdx + 56]
	l_101:
	cmp rax, rcx
	jg l_102
	l_103:
	mov rax, rcx
	jmp l_104
	l_102:
	l_104:
	mov qword [rdx + 56], rax
	mov rax, qword [rdx + 64]
	mov rcx, rsi
	l_105:
	cmp rax, rcx
	jg l_106
	l_107:
	mov rax, rcx
	jmp l_108
	l_106:
	l_108:
	mov qword [rdx + 64], rax
	mov rsi, 0
	l_109:
	cmp rsi, 2
	jl l_110
	l_111:
	mov rcx, qword [rdx + 8]
	mov rax, qword [rdx + 80]
	cmp qword [rax + 8], 0
	je l_112
	l_113:
	mov rax, qword [rdx + 80]
	mov rax, qword [rax + 8]
	mov rax, qword [rax + 64]
	l_114:
	cmp rax, 0
	jg l_115
	l_116:
	mov rax, 0
	jmp l_117
	l_115:
	l_117:
	add rcx, rax
	l_112:
	mov rax, qword [rdx + 80]
	cmp qword [rax + 16], 0
	je l_118
	l_119:
	mov rax, qword [rdx + 80]
	mov rax, qword [rax + 16]
	mov rax, qword [rax + 56]
	l_120:
	cmp rax, 0
	jg l_121
	l_122:
	mov rax, 0
	jmp l_123
	l_121:
	l_123:
	add rcx, rax
	l_118:
	mov rax, qword [rdx + 72]
	l_124:
	cmp rax, rcx
	jg l_125
	l_126:
	mov rax, rcx
	jmp l_127
	l_125:
	l_127:
	mov qword [rdx + 72], rax
	l_128:
	leave 
	ret
	l_110:
	mov rax, qword [rdx + 80]
	cmp qword [rax + rsi * 8 + 8], 0
	je l_129
	l_130:
	mov rax, qword [rdx + 80]
	mov rcx, qword [rax + rsi * 8 + 8]
	mov rax, qword [rdx + 72]
	mov rcx, qword [rcx + 72]
	l_131:
	cmp rax, rcx
	jg l_132
	l_133:
	mov rax, rcx
	jmp l_134
	l_132:
	l_134:
	mov qword [rdx + 72], rax
	l_129:
	l_135:
	inc rsi
	jmp l_109
	l_87:
	mov rax, qword [rdx + 80]
	cmp qword [rax + rsi * 8 + 8], 0
	je l_136
	l_137:
	mov rax, qword [rdx + 80]
	mov rax, qword [rax + rsi * 8 + 8]
	mov rcx, qword [rdx + 16]
	add rcx, qword [rax + 16]
	mov qword [rdx + 16], rcx
	mov rax, qword [rdx + 80]
	mov rcx, qword [rax + rsi * 8 + 8]
	mov rax, qword [rdx + 24]
	add rax, qword [rcx + 24]
	mov qword [rdx + 24], rax
	l_136:
	l_138:
	inc rsi
	jmp l_86
_addtag_ch_User_Defined_fihriaifhiahidsafans:
	l_139:
	push rbp
	mov rbp, rsp
	mov rcx, rdi
	mov qword [rcx + 8], rsi
	mov rax, qword [rcx + 16]
	imul rsi
	mov qword [rcx + 24], rax
	cmp rsi, 0
	jge l_140
	l_141:
	mov qword [rcx + 56], rsi
	mov qword [rcx + 64], rsi
	mov qword [rcx + 72], rsi
	jmp l_142
	l_140:
	mov rax, qword [rcx + 24]
	mov qword [rcx + 56], rax
	mov rax, qword [rcx + 24]
	mov qword [rcx + 64], rax
	mov rax, qword [rcx + 24]
	mov qword [rcx + 72], rax
	l_142:
	mov qword [rcx + 32], 1
	mov qword [rcx + 40], rsi
	l_143:
	leave 
	ret
_addtag_ro_User_Defined_fihriaifhiahidsafans:
	l_144:
	push rbp
	mov rbp, rsp
	mov rdx, rdi
	mov rax, qword [rdx + 80]
	mov rcx, qword [rax + 8]
	mov rsi, qword [rdx + 80]
	mov rax, qword [rdx + 80]
	mov rax, qword [rax + 16]
	mov qword [rsi + 8], rax
	mov rax, qword [rdx + 80]
	mov qword [rax + 16], rcx
	mov rax, qword [rdx + 56]
	mov rcx, qword [rdx + 64]
	mov qword [rdx + 56], rcx
	mov qword [rdx + 64], rax
	mov rax, qword [rdx + 48]
	xor rax, 1
	mov qword [rdx + 48], rax
	l_145:
	leave 
	ret
_push_down_User_Defined_fihriaifhiahidsafans:
	l_146:
	push rbp
	mov rbp, rsp
	push r14
	push r15
	mov r14, rdi
	cmp qword [r14 + 32], 1
	jne l_147
	l_148:
	mov r15, 0
	l_149:
	cmp r15, 2
	jl l_150
	l_151:
	mov qword [r14 + 32], 0
	l_147:
	cmp qword [r14 + 48], 1
	jne l_152
	l_153:
	mov r15, 0
	l_154:
	cmp r15, 2
	jl l_155
	l_156:
	mov qword [r14 + 48], 0
	l_152:
	l_157:
	pop r15
	pop r14
	leave 
	ret
	l_155:
	mov rax, qword [r14 + 80]
	cmp qword [rax + r15 * 8 + 8], 0
	je l_158
	l_159:
	mov rax, qword [r14 + 80]
	mov rax, qword [rax + r15 * 8 + 8]
	mov rdi, rax
	call _addtag_ro_User_Defined_fihriaifhiahidsafans 
	l_158:
	l_160:
	inc r15
	jmp l_154
	l_150:
	mov rax, qword [r14 + 80]
	cmp qword [rax + r15 * 8 + 8], 0
	je l_161
	l_162:
	mov rax, qword [r14 + 80]
	mov rax, qword [rax + r15 * 8 + 8]
	mov rsi, qword [r14 + 40]
	mov rdi, rax
	call _addtag_ch_User_Defined_fihriaifhiahidsafans 
	l_161:
	l_163:
	inc r15
	jmp l_149
_rot_User_Defined_fihriaifhiahidsafans:
	l_164:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push r12
	push r15
	push r14
	mov r15, rdi
	mov r12, qword [r15 + 88]
	mov rax, r12
	mov rsi, r15
	mov rdi, rax
	call _judge_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, r12
	mov rsi, qword [rax + 80]
	mov rax, rcx
	xor rax, 1
	mov rdx, qword [r15 + 80]
	mov rdx, qword [rdx + rax * 8 + 8]
	mov qword [rsi + rcx * 8 + 8], rdx
	mov rdx, rax
	mov rax, qword [r15 + 80]
	mov qword [rax + rdx * 8 + 8], r12
	mov rax, r12
	mov rax, qword [rax + 80]
	cmp qword [rax + rcx * 8 + 8], 0
	je l_165
	l_166:
	mov rax, r12
	mov rax, qword [rax + 80]
	mov rax, qword [rax + rcx * 8 + 8]
	mov qword [rax + 88], r12
	l_165:
	mov rax, r12
	mov rax, qword [rax + 88]
	mov qword [r15 + 88], rax
	mov rax, r12
	mov qword [rax + 88], r15
	cmp qword [r15 + 88], 0
	je l_167
	l_168:
	mov r14, qword [r15 + 88]
	mov rax, qword [r15 + 88]
	mov rsi, r12
	mov rdi, rax
	call _judge_User_Defined_fihriaifhiahidsafans 
	mov rcx, rax
	mov rax, qword [r14 + 80]
	mov qword [rax + rcx * 8 + 8], r15
	l_167:
	mov rax, r12
	mov rdi, rax
	call _push_up_User_Defined_fihriaifhiahidsafans 
	l_169:
	pop r14
	pop r15
	pop r12
	leave 
	ret
_rotto_User_Defined_fihriaifhiahidsafans:
	l_170:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r15
	push r14
	mov r15, rdi
	mov r14, rsi
	l_171:
	mov rcx, qword [r15 + 88]
	mov rax, r14
	l_172:
	cmp rcx, 0
	je l_173
	l_174:
	cmp rax, 0
	je l_175
	l_176:
	mov rcx, qword [rcx]
	cmp rcx, qword [rax]
	je l_177
	l_178:
	mov rax, 0
	jmp l_179
	l_177:
	mov rax, 1
	l_179:
	jmp l_180
	l_175:
	l_181:
	mov rax, 0
	l_182:
	jmp l_180
	l_173:
	cmp rax, 0
	je l_183
	l_184:
	l_185:
	mov rax, 0
	l_186:
	jmp l_180
	l_183:
	l_187:
	mov rax, 1
	l_188:
	l_180:
	cmp rax, 0
	jne l_189
	l_190:
	mov r12, qword [r15 + 88]
	mov rax, r12
	mov rax, qword [rax + 88]
	mov rcx, r14
	l_191:
	cmp rax, 0
	je l_192
	l_193:
	cmp rcx, 0
	je l_194
	l_195:
	mov rax, qword [rax]
	cmp rax, qword [rcx]
	je l_196
	l_197:
	mov rax, 0
	jmp l_198
	l_196:
	mov rax, 1
	l_198:
	jmp l_199
	l_194:
	l_200:
	mov rax, 0
	l_201:
	jmp l_199
	l_192:
	cmp rcx, 0
	je l_202
	l_203:
	l_204:
	mov rax, 0
	l_205:
	jmp l_199
	l_202:
	l_206:
	mov rax, 1
	l_207:
	l_199:
	cmp rax, 0
	jne l_208
	l_209:
	mov rax, r12
	mov rax, qword [rax + 88]
	mov rsi, r12
	mov rdi, rax
	call _judge_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rax, r12
	mov rsi, r15
	mov rdi, rax
	call _judge_User_Defined_fihriaifhiahidsafans 
	cmp rbx, rax
	je l_210
	l_211:
	mov rdi, r15
	call _rot_User_Defined_fihriaifhiahidsafans 
	mov rdi, r15
	call _rot_User_Defined_fihriaifhiahidsafans 
	jmp l_212
	l_210:
	mov rax, r12
	mov rdi, rax
	call _rot_User_Defined_fihriaifhiahidsafans 
	mov rdi, r15
	call _rot_User_Defined_fihriaifhiahidsafans 
	l_212:
	jmp l_171
	l_208:
	mov rdi, r15
	call _rot_User_Defined_fihriaifhiahidsafans 
	jmp l_171
	l_189:
	mov rdi, r15
	call _push_up_User_Defined_fihriaifhiahidsafans 
	cmp qword [r15 + 88], 0
	je l_213
	l_214:
	mov rax, qword [r15 + 88]
	mov rdi, rax
	call _push_up_User_Defined_fihriaifhiahidsafans 
	l_213:
	l_215:
	pop r14
	pop r15
	pop r12
	pop rbx
	leave 
	ret
_splay_tree_User_Defined_fihriaifhiahidsafans:
	l_216:
	push rbp
	mov rbp, rsp
	mov rax, rdi
	mov qword [rax], 0
	l_217:
	leave 
	ret
_build_User_Defined_fihriaifhiahidsafans:
	l_218:
	push rbp
	mov rbp, rsp
	sub rsp, 40
	push r13
	push rbx
	push r12
	push r15
	push r14
	mov rax, rdi
	mov qword [rbp-16], rax
	mov rbx, rsi
	mov rax, rdx
	mov qword [rbp-8], rax
	mov r13, rcx
	mov r12, r8
	mov rax, r13
	add rax, r12
	mov rcx, 1
	sar rax, cl
	mov r15, rax
	mov rdi, 96
	call malloc 
	mov r14, rax
	mov rdi, r14
	call _Node_User_Defined_fihriaifhiahidsafans 
	mov rax, r14
	mov rcx, qword [g_9]
	inc rcx
	mov qword [g_9], rcx
	mov rcx, qword [g_9]
	mov rdx, rcx
	mov rcx, qword [g_5]
	mov rsi, qword [rcx + r15 * 8 + 8]
	mov rdi, rax
	call _init_User_Defined_fihriaifhiahidsafans 
	mov rax, rbx
	mov rsi, r14
	mov rdi, rax
	call _copy_User_Defined_fihriaifhiahidsafans 
	mov rcx, rbx
	mov rax, qword [rbp-8]
	mov qword [rcx + 88], rax
	cmp r13, r15
	jge l_219
	l_220:
	mov rax, rbx
	mov rax, qword [rax + 80]
	mov qword [rbp-24], rax
	mov rdi, 96
	call malloc 
	mov r14, rax
	mov rdi, r14
	call _Node_User_Defined_fihriaifhiahidsafans 
	mov rax, qword [rbp-24]
	mov qword [rax + 8], r14
	mov rax, rbx
	mov rax, qword [rax + 80]
	mov rcx, qword [rax + 8]
	mov rax, qword [g_9]
	inc rax
	mov qword [g_9], rax
	mov rax, qword [g_9]
	mov rdx, rax
	mov rsi, 0
	mov rdi, rcx
	call _init_User_Defined_fihriaifhiahidsafans 
	mov rax, rbx
	mov rsi, qword [rax + 80]
	mov rax, r15
	sub rax, 1
	mov r8, rax
	mov rcx, r13
	mov rdx, rbx
	mov rsi, qword [rsi + 8]
	mov rax, qword [rbp-16]
	mov rdi, rax
	call _build_User_Defined_fihriaifhiahidsafans 
	l_219:
	cmp r12, r15
	jle l_221
	l_222:
	mov rax, rbx
	mov r14, qword [rax + 80]
	mov rdi, 96
	call malloc 
	mov r13, rax
	mov rdi, r13
	call _Node_User_Defined_fihriaifhiahidsafans 
	mov qword [r14 + 16], r13
	mov rax, rbx
	mov rax, qword [rax + 80]
	mov rcx, qword [rax + 16]
	mov rax, qword [g_9]
	inc rax
	mov qword [g_9], rax
	mov rax, qword [g_9]
	mov rdx, rax
	mov rsi, 0
	mov rdi, rcx
	call _init_User_Defined_fihriaifhiahidsafans 
	mov rax, rbx
	mov rax, qword [rax + 80]
	mov rcx, r15
	add rcx, 1
	mov r8, r12
	mov rdx, rbx
	mov rsi, qword [rax + 16]
	mov rax, qword [rbp-16]
	mov rdi, rax
	call _build_User_Defined_fihriaifhiahidsafans 
	l_221:
	mov rax, rbx
	mov rdi, rax
	call _push_up_User_Defined_fihriaifhiahidsafans 
	l_223:
	pop r14
	pop r15
	pop r12
	pop rbx
	pop r13
	leave 
	ret
_build_tree_User_Defined_fihriaifhiahidsafans:
	l_224:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r15
	push r14
	mov r14, rdi
	mov r12, rsi
	mov r15, rdx
	mov rdi, 96
	call malloc 
	mov rbx, rax
	mov rdi, rbx
	call _Node_User_Defined_fihriaifhiahidsafans 
	mov qword [r14], rbx
	mov rcx, qword [r14]
	mov rax, qword [g_9]
	inc rax
	mov qword [g_9], rax
	mov rax, qword [g_9]
	mov rdx, rax
	mov rsi, 0
	mov rdi, rcx
	call _init_User_Defined_fihriaifhiahidsafans 
	mov r8, r15
	mov rcx, r12
	mov rdx, 0
	mov rsi, qword [r14]
	mov rdi, r14
	call _build_User_Defined_fihriaifhiahidsafans 
	l_225:
	pop r14
	pop r15
	pop r12
	pop rbx
	leave 
	ret
_find_User_Defined_fihriaifhiahidsafans:
	l_226:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push r12
	push r15
	push r14
	mov rax, rdi
	mov r15, rsi
	mov r12, qword [rax]
	mov r14, 0
	mov rax, r12
	mov rax, qword [rax + 80]
	cmp qword [rax + 8], 0
	jne l_227
	l_228:
	mov rax, 1
	jmp l_229
	l_227:
	mov rax, r12
	mov rax, qword [rax + 80]
	mov rax, qword [rax + 8]
	mov rax, qword [rax + 16]
	add rax, 1
	l_229:
	l_230:
	mov rcx, r14
	add rcx, rax
	cmp rcx, r15
	jne l_231
	l_232:
	mov rax, r12
	l_233:
	pop r14
	pop r15
	pop r12
	leave 
	ret
	l_231:
	mov rax, rcx
	cmp r15, rax
	jl l_234
	l_235:
	mov r14, rcx
	mov rax, r12
	mov rax, qword [rax + 80]
	mov r12, qword [rax + 16]
	jmp l_236
	l_234:
	mov rax, r12
	mov rax, qword [rax + 80]
	mov r12, qword [rax + 8]
	l_236:
	mov rax, r12
	mov rdi, rax
	call _push_down_User_Defined_fihriaifhiahidsafans 
	mov rax, r12
	mov rax, qword [rax + 80]
	cmp qword [rax + 8], 0
	jne l_237
	l_238:
	mov rax, 1
	jmp l_239
	l_237:
	mov rax, r12
	mov rax, qword [rax + 80]
	mov rax, qword [rax + 8]
	mov rax, qword [rax + 16]
	add rax, 1
	l_239:
	jmp l_230
_dfs_User_Defined_fihriaifhiahidsafans:
	l_240:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push r12
	push r15
	push r14
	mov r14, rdi
	mov r15, rsi
	mov r12, 0
	l_241:
	cmp r12, 2
	jl l_242
	l_243:
	l_244:
	pop r14
	pop r15
	pop r12
	leave 
	ret
	l_242:
	mov rax, r15
	mov rax, qword [rax + 80]
	cmp qword [rax + r12 * 8 + 8], 0
	je l_245
	l_246:
	mov rax, r15
	mov rax, qword [rax + 80]
	mov rsi, qword [rax + r12 * 8 + 8]
	mov rdi, r14
	call _dfs_User_Defined_fihriaifhiahidsafans 
	l_245:
	l_247:
	inc r12
	jmp l_241
_del_User_Defined_fihriaifhiahidsafans:
	l_248:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push r12
	push r15
	push r14
	mov r14, rdi
	mov r15, rsi
	mov rax, rdx
	add rax, 1
	mov rsi, rax
	mov rdi, r14
	call _find_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r12
	mov rsi, 0
	mov rdi, rax
	call _rotto_User_Defined_fihriaifhiahidsafans 
	mov qword [r14], r12
	mov rax, r15
	sub rax, 1
	mov rsi, rax
	mov rdi, r14
	call _find_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r12
	mov rsi, qword [r14]
	mov rdi, rax
	call _rotto_User_Defined_fihriaifhiahidsafans 
	mov rax, r12
	mov rax, qword [rax + 80]
	cmp qword [rax + 16], 0
	je l_249
	l_250:
	mov rax, r12
	mov rax, qword [rax + 80]
	mov rsi, qword [rax + 16]
	mov rdi, r14
	call _dfs_User_Defined_fihriaifhiahidsafans 
	l_249:
	mov rax, r12
	mov rax, qword [rax + 80]
	mov qword [rax + 16], 0
	mov rax, r12
	mov rsi, 0
	mov rdi, rax
	call _rotto_User_Defined_fihriaifhiahidsafans 
	mov qword [r14], r12
	l_251:
	pop r14
	pop r15
	pop r12
	leave 
	ret
_change_User_Defined_fihriaifhiahidsafans:
	l_252:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r15
	push r14
	mov rbx, rdi
	mov r14, rsi
	mov rax, rdx
	mov r12, rcx
	add rax, 1
	mov rsi, rax
	mov rdi, rbx
	call _find_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r15
	mov rsi, 0
	mov rdi, rax
	call _rotto_User_Defined_fihriaifhiahidsafans 
	mov qword [rbx], r15
	mov rax, r14
	sub rax, 1
	mov rsi, rax
	mov rdi, rbx
	call _find_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, r15
	mov rsi, qword [rbx]
	mov rdi, rax
	call _rotto_User_Defined_fihriaifhiahidsafans 
	mov rax, r15
	mov rax, qword [rax + 80]
	mov r15, qword [rax + 16]
	mov rax, r15
	mov rdi, rax
	call _push_down_User_Defined_fihriaifhiahidsafans 
	mov rax, r15
	mov rsi, r12
	mov rdi, rax
	call _addtag_ch_User_Defined_fihriaifhiahidsafans 
	mov rax, r15
	mov rdi, rax
	call _push_down_User_Defined_fihriaifhiahidsafans 
	mov rax, r15
	mov rsi, 0
	mov rdi, rax
	call _rotto_User_Defined_fihriaifhiahidsafans 
	mov qword [rbx], r15
	l_253:
	pop r14
	pop r15
	pop r12
	pop rbx
	leave 
	ret
_rol_User_Defined_fihriaifhiahidsafans:
	l_254:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push r12
	push r15
	push r14
	mov r15, rdi
	mov r12, rsi
	mov rax, rdx
	add rax, 1
	mov rsi, rax
	mov rdi, r15
	call _find_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r14
	mov rsi, 0
	mov rdi, rax
	call _rotto_User_Defined_fihriaifhiahidsafans 
	mov qword [r15], r14
	mov rax, r12
	sub rax, 1
	mov rsi, rax
	mov rdi, r15
	call _find_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, r14
	mov rsi, qword [r15]
	mov rdi, rax
	call _rotto_User_Defined_fihriaifhiahidsafans 
	mov rax, r14
	mov rax, qword [rax + 80]
	mov r14, qword [rax + 16]
	mov rax, r14
	mov rdi, rax
	call _push_down_User_Defined_fihriaifhiahidsafans 
	mov rax, r14
	mov rdi, rax
	call _addtag_ro_User_Defined_fihriaifhiahidsafans 
	mov rax, r14
	mov rdi, rax
	call _push_down_User_Defined_fihriaifhiahidsafans 
	mov rax, r14
	mov rsi, 0
	mov rdi, rax
	call _rotto_User_Defined_fihriaifhiahidsafans 
	mov qword [r15], r14
	l_255:
	pop r14
	pop r15
	pop r12
	leave 
	ret
_getsum_User_Defined_fihriaifhiahidsafans:
	l_256:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push r12
	push r15
	push r14
	mov r14, rdi
	mov r15, rsi
	mov rax, rdx
	add rax, 1
	mov rsi, rax
	mov rdi, r14
	call _find_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r12
	mov rsi, 0
	mov rdi, rax
	call _rotto_User_Defined_fihriaifhiahidsafans 
	mov qword [r14], r12
	mov rax, r15
	sub rax, 1
	mov rsi, rax
	mov rdi, r14
	call _find_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, r12
	mov rsi, qword [r14]
	mov rdi, rax
	call _rotto_User_Defined_fihriaifhiahidsafans 
	mov rax, r12
	mov rax, qword [rax + 80]
	mov r12, qword [rax + 16]
	mov rax, r12
	mov rdi, rax
	call _push_down_User_Defined_fihriaifhiahidsafans 
	mov rax, r12
	mov r15, qword [rax + 24]
	mov rax, r12
	mov rsi, 0
	mov rdi, rax
	call _rotto_User_Defined_fihriaifhiahidsafans 
	mov qword [r14], r12
	mov rax, r15
	l_257:
	pop r14
	pop r15
	pop r12
	leave 
	ret
_getMax_User_Defined_fihriaifhiahidsafans:
	l_258:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push r14
	mov r14, rdi
	mov rax, qword [r14]
	mov rdi, rax
	call _push_down_User_Defined_fihriaifhiahidsafans 
	mov rax, qword [r14]
	mov rax, qword [rax + 72]
	l_259:
	pop r14
	leave 
	ret
__init:
	l_260:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push r14
	mov rax, 1000000000
	mov qword [g_4], rax
	mov rax, 4000010
	mov qword [g_10], rax
	mov rax, 0
	mov qword [g_9], rax
	mov r14, 4000010
	lea rcx, [r14 * 8 + 8]
	mov rdi, rcx
	call malloc 
	mov qword [rax], 4000010
	l_261:
	cmp r14, 0
	jg l_262
	l_263:
	mov qword [g_5], rax
	mov rax, g_11
	mov qword [g_6], rax
	call _main_User_Defined_fihriaifhiahidsafans 
	pop r14
	leave 
	ret
	l_262:
	mov qword [rax + r14 * 8], 0
	dec r14
	jmp l_261
	 section .data
g_4:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_10:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_0:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_1:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_9:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_5:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_2:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_3:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_6:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_7:
	dq 2
	db 30H, 0AH, 00H
g_8:
	dq 1
	db 0AH, 00H
g_11:
	dq 2
	db 49H, 44H, 00H

