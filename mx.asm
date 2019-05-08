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
_init_User_Defined_fihriaifhiahidsafans:
	l_0:
	push rbp
	mov rbp, rsp
	sub rsp, 184
	push rbx
	push r14
	push r15
	push r12
	push r13
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
	mov rax, 0
	mov qword [g_8], rax
	mov rax, 0
	mov qword [g_10], rax
	mov rax, 0
	mov qword [g_4], rax
	mov rax, 0
	mov qword [g_7], rax
	mov r12, 6
	lea rcx, [r12 * 8 + 8]
	mov rdi, rcx
	call malloc 
	mov qword [rax], 6
	l_1:
	cmp r12, 0
	jg l_2
	l_3:
	mov qword [g_2], rax
	mov r15, 0
	l_4:
	cmp r15, 6
	jl l_5
	l_6:
	mov r13, 6
	mov rax, qword [rbp-152]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-152], rax
	mov rax, qword [rbp-152]
	mov rdi, rax
	call malloc 
	mov qword [rax], 6
	l_7:
	cmp r13, 0
	jg l_8
	l_9:
	mov qword [g_12], rax
	mov r15, 0
	l_10:
	cmp r15, 6
	jl l_11
	l_12:
	mov r13, 1001
	mov rax, qword [rbp-144]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-144], rax
	mov rax, qword [rbp-144]
	mov rdi, rax
	call malloc 
	mov qword [rax], 1001
	l_13:
	cmp r13, 0
	jg l_14
	l_15:
	mov qword [g_17], rax
	mov r15, 0
	l_16:
	cmp r15, 1001
	jl l_17
	l_18:
	mov r13, 100001
	mov rax, qword [rbp-64]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-64], rax
	mov rax, qword [rbp-64]
	mov rdi, rax
	call malloc 
	mov qword [rax], 100001
	l_19:
	cmp r13, 0
	jg l_20
	l_21:
	mov qword [g_16], rax
	mov r15, 0
	l_22:
	cmp r15, 100001
	jl l_23
	l_24:
	mov r13, 21
	mov rax, qword [rbp-16]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-16], rax
	mov rax, qword [rbp-16]
	mov rdi, rax
	call malloc 
	mov qword [rax], 21
	l_25:
	cmp r13, 0
	jg l_26
	l_27:
	mov qword [g_1], rax
	mov r15, 0
	l_28:
	cmp r15, 21
	jl l_29
	l_30:
	mov r13, 21
	mov rax, qword [rbp-88]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-88], rax
	mov rax, qword [rbp-88]
	mov rdi, rax
	call malloc 
	mov qword [rax], 21
	l_31:
	cmp r13, 0
	jg l_32
	l_33:
	mov qword [g_9], rax
	mov r15, 0
	l_34:
	cmp r15, 21
	jl l_35
	l_36:
	mov r13, 100001
	mov rax, qword [rbp-96]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-96], rax
	mov rax, qword [rbp-96]
	mov rdi, rax
	call malloc 
	mov qword [rax], 100001
	l_37:
	cmp r13, 0
	jg l_38
	l_39:
	mov qword [g_3], rax
	mov r15, 0
	l_40:
	cmp r15, 100001
	jl l_41
	l_42:
	mov r13, 1001
	mov rax, qword [rbp-80]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-80], rax
	mov rax, qword [rbp-80]
	mov rdi, rax
	call malloc 
	mov qword [rax], 1001
	l_43:
	cmp r13, 0
	jg l_44
	l_45:
	mov qword [g_0], rax
	mov r15, 0
	l_46:
	cmp r15, 1001
	jl l_47
	l_48:
	mov r13, 1001
	mov rax, qword [rbp-48]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-48], rax
	mov rax, qword [rbp-48]
	mov rdi, rax
	call malloc 
	mov qword [rax], 1001
	l_49:
	cmp r13, 0
	jg l_50
	l_51:
	mov qword [g_5], rax
	mov r15, 0
	l_52:
	cmp r15, 1001
	jl l_53
	l_54:
	mov r13, 1001
	mov rax, qword [rbp-168]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-168], rax
	mov rax, qword [rbp-168]
	mov rdi, rax
	call malloc 
	mov qword [rax], 1001
	l_55:
	cmp r13, 0
	jg l_56
	l_57:
	mov qword [g_11], rax
	mov r15, 0
	l_58:
	cmp r15, 1001
	jl l_59
	l_60:
	mov r13, 1001
	mov rax, qword [rbp-56]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-56], rax
	mov rax, qword [rbp-56]
	mov rdi, rax
	call malloc 
	mov qword [rax], 1001
	l_61:
	cmp r13, 0
	jg l_62
	l_63:
	mov qword [g_6], rax
	mov r15, 0
	l_64:
	cmp r15, 1001
	jl l_65
	l_66:
	mov r13, 1001
	mov rax, qword [rbp-40]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-40], rax
	mov rax, qword [rbp-40]
	mov rdi, rax
	call malloc 
	mov qword [rax], 1001
	l_67:
	cmp r13, 0
	jg l_68
	l_69:
	mov qword [g_14], rax
	mov r15, 0
	l_70:
	cmp r15, 1001
	jl l_71
	l_72:
	mov r13, 100001
	mov rax, qword [rbp-24]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-24], rax
	mov rax, qword [rbp-24]
	mov rdi, rax
	call malloc 
	mov qword [rax], 100001
	l_73:
	cmp r13, 0
	jg l_74
	l_75:
	mov qword [g_13], rax
	mov r15, 0
	l_76:
	cmp r15, 100001
	jl l_77
	l_78:
	mov r13, 100001
	mov rax, qword [rbp-128]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-128], rax
	mov rax, qword [rbp-128]
	mov rdi, rax
	call malloc 
	mov qword [rax], 100001
	l_79:
	cmp r13, 0
	jg l_80
	l_81:
	mov qword [g_15], rax
	mov r15, 0
	l_82:
	cmp r15, 100001
	jl l_83
	l_84:
	l_85:
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
	pop r13
	pop r12
	pop r15
	pop r14
	pop rbx
	leave 
	ret
	l_83:
	mov rax, qword [g_15]
	mov qword [rax + r15 * 8 + 8], 0
	l_86:
	inc r15
	jmp l_82
	l_80:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_79
	l_77:
	mov rax, qword [g_13]
	mov qword [rax + r15 * 8 + 8], 0
	l_87:
	inc r15
	jmp l_76
	l_74:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_73
	l_71:
	mov rax, qword [g_14]
	mov qword [rax + r15 * 8 + 8], 0
	l_88:
	inc r15
	jmp l_70
	l_68:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_67
	l_65:
	mov rax, qword [g_6]
	mov qword [rax + r15 * 8 + 8], 0
	l_89:
	inc r15
	jmp l_64
	l_62:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_61
	l_59:
	mov rax, qword [g_11]
	mov qword [rax + r15 * 8 + 8], 0
	l_90:
	inc r15
	jmp l_58
	l_56:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_55
	l_53:
	mov rax, qword [g_5]
	mov qword [rax + r15 * 8 + 8], 0
	l_91:
	inc r15
	jmp l_52
	l_50:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_49
	l_47:
	mov rax, qword [g_0]
	mov qword [rax + r15 * 8 + 8], 0
	l_92:
	inc r15
	jmp l_46
	l_44:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_43
	l_41:
	mov r13, 21
	mov rax, qword [rbp-120]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-120], rax
	mov rax, qword [rbp-120]
	mov rdi, rax
	call malloc 
	mov qword [rax], 21
	l_93:
	cmp r13, 0
	jg l_94
	l_95:
	mov rcx, qword [g_3]
	mov qword [rcx + r15 * 8 + 8], rax
	mov r12, 0
	l_96:
	cmp r12, 21
	jl l_97
	l_98:
	l_99:
	inc r15
	jmp l_40
	l_97:
	mov rax, qword [g_3]
	mov rax, qword [rax + r15 * 8 + 8]
	mov qword [rax + r12 * 8 + 8], 0
	l_100:
	inc r12
	jmp l_96
	l_94:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_93
	l_38:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_37
	l_35:
	mov r13, 100001
	mov rax, qword [rbp-32]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-32], rax
	mov rax, qword [rbp-32]
	mov rdi, rax
	call malloc 
	mov qword [rax], 100001
	l_101:
	cmp r13, 0
	jg l_102
	l_103:
	mov rcx, qword [g_9]
	mov qword [rcx + r15 * 8 + 8], rax
	mov r12, 0
	l_104:
	cmp r12, 100001
	jl l_105
	l_106:
	l_107:
	inc r15
	jmp l_34
	l_105:
	mov rax, qword [g_9]
	mov rax, qword [rax + r15 * 8 + 8]
	mov qword [rax + r12 * 8 + 8], 0
	l_108:
	inc r12
	jmp l_104
	l_102:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_101
	l_32:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_31
	l_29:
	mov r13, 21
	mov rax, qword [rbp-72]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-72], rax
	mov rax, qword [rbp-72]
	mov rdi, rax
	call malloc 
	mov rcx, rax
	mov qword [rcx], 21
	l_109:
	cmp r13, 0
	jg l_110
	l_111:
	mov rax, qword [g_1]
	mov qword [rax + r15 * 8 + 8], rcx
	mov r12, 0
	l_112:
	cmp r12, 21
	jl l_113
	l_114:
	l_115:
	inc r15
	jmp l_28
	l_113:
	mov rax, qword [g_1]
	mov rax, qword [rax + r15 * 8 + 8]
	mov qword [rax + r12 * 8 + 8], 0
	l_116:
	inc r12
	jmp l_112
	l_110:
	mov qword [rcx + r13 * 8], 0
	dec r13
	jmp l_109
	l_26:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_25
	l_23:
	mov r13, 21
	mov rax, qword [rbp-104]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-104], rax
	mov rax, qword [rbp-104]
	mov rdi, rax
	call malloc 
	mov qword [rax], 21
	l_117:
	cmp r13, 0
	jg l_118
	l_119:
	mov rcx, qword [g_16]
	mov qword [rcx + r15 * 8 + 8], rax
	mov r12, 0
	l_120:
	cmp r12, 21
	jl l_121
	l_122:
	l_123:
	inc r15
	jmp l_22
	l_121:
	mov rax, qword [g_16]
	mov rax, qword [rax + r15 * 8 + 8]
	mov qword [rax + r12 * 8 + 8], 0
	l_124:
	inc r12
	jmp l_120
	l_118:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_117
	l_20:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_19
	l_17:
	mov r13, 13
	mov rax, qword [rbp-112]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-112], rax
	mov rax, qword [rbp-112]
	mov rdi, rax
	call malloc 
	mov rcx, rax
	mov qword [rcx], 13
	l_125:
	cmp r13, 0
	jg l_126
	l_127:
	mov rax, qword [g_17]
	mov qword [rax + r15 * 8 + 8], rcx
	mov r12, 0
	l_128:
	cmp r12, 13
	jl l_129
	l_130:
	l_131:
	inc r15
	jmp l_16
	l_129:
	mov rax, qword [g_17]
	mov rax, qword [rax + r15 * 8 + 8]
	mov qword [rax + r12 * 8 + 8], 0
	l_132:
	inc r12
	jmp l_128
	l_126:
	mov qword [rcx + r13 * 8], 0
	dec r13
	jmp l_125
	l_14:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_13
	l_11:
	mov r13, 100001
	mov rax, qword [rbp-8]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-8], rax
	mov rax, qword [rbp-8]
	mov rdi, rax
	call malloc 
	mov qword [rax], 100001
	l_133:
	cmp r13, 0
	jg l_134
	l_135:
	mov rcx, qword [g_12]
	mov qword [rcx + r15 * 8 + 8], rax
	mov r12, 0
	l_136:
	cmp r12, 100001
	jl l_137
	l_138:
	l_139:
	inc r15
	jmp l_10
	l_137:
	mov rax, qword [g_12]
	mov r13, qword [rax + r15 * 8 + 8]
	mov r14, 15
	mov rax, qword [rbp-160]
	lea rax, [r14 * 8 + 8]
	mov qword [rbp-160], rax
	mov rax, qword [rbp-160]
	mov rdi, rax
	call malloc 
	mov qword [rax], 15
	l_140:
	cmp r14, 0
	jg l_141
	l_142:
	mov qword [r13 + r12 * 8 + 8], rax
	mov rcx, 0
	l_143:
	cmp rcx, 15
	jl l_144
	l_145:
	l_146:
	inc r12
	jmp l_136
	l_144:
	mov rax, qword [g_12]
	mov rax, qword [rax + r15 * 8 + 8]
	mov rax, qword [rax + r12 * 8 + 8]
	mov qword [rax + rcx * 8 + 8], 0
	l_147:
	inc rcx
	jmp l_143
	l_141:
	mov qword [rax + r14 * 8], 0
	dec r14
	jmp l_140
	l_134:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_133
	l_8:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_7
	l_5:
	mov r12, 100001
	lea r13, [r12 * 8 + 8]
	mov rdi, r13
	call malloc 
	mov rcx, rax
	mov qword [rcx], 100001
	l_148:
	cmp r12, 0
	jg l_149
	l_150:
	mov rax, qword [g_2]
	mov qword [rax + r15 * 8 + 8], rcx
	mov r12, 0
	l_151:
	cmp r12, 100001
	jl l_152
	l_153:
	l_154:
	inc r15
	jmp l_4
	l_152:
	mov rax, qword [g_2]
	mov rbx, qword [rax + r15 * 8 + 8]
	mov r14, 15
	mov rax, qword [rbp-136]
	lea rax, [r14 * 8 + 8]
	mov qword [rbp-136], rax
	mov rax, qword [rbp-136]
	mov rdi, rax
	call malloc 
	mov qword [rax], 15
	l_155:
	cmp r14, 0
	jg l_156
	l_157:
	mov qword [rbx + r12 * 8 + 8], rax
	mov rcx, 0
	l_158:
	cmp rcx, 15
	jl l_159
	l_160:
	l_161:
	inc r12
	jmp l_151
	l_159:
	mov rax, qword [g_2]
	mov rax, qword [rax + r15 * 8 + 8]
	mov rax, qword [rax + r12 * 8 + 8]
	mov qword [rax + rcx * 8 + 8], 0
	l_162:
	inc rcx
	jmp l_158
	l_156:
	mov qword [rax + r14 * 8], 0
	dec r14
	jmp l_155
	l_149:
	mov qword [rcx + r12 * 8], 0
	dec r12
	jmp l_148
	l_2:
	mov qword [rax + r12 * 8], 0
	dec r12
	jmp l_1
_Ksm_User_Defined_fihriaifhiahidsafans:
	l_163:
	push rbp
	mov rbp, rsp
	push r12
	push r13
	mov r13, rdi
	mov r12, rsi
	mov rax, qword [g_18]
	mov qword [g_18], rax
	cmp r12, 0
	je l_164
	l_165:
	cmp r12, 1
	je l_166
	l_167:
	mov rax, r12
	mov rcx, 1
	sar rax, cl
	mov rcx, qword [g_18]
	mov qword [g_18], rcx
	mov rsi, rax
	mov rdi, r13
	mov rax, qword [g_18]
	mov qword [g_18], rax
	call _Ksm_User_Defined_fihriaifhiahidsafans 
	mov rsi, rax
	mov rax, r12
	xor rdx, rdx
	cdq
	mov rcx, 2
	idiv ecx
	mov rax, rdx
	cmp rax, 1
	je l_168
	l_169:
	mov rax, rsi
	imul rsi
	xor rdx, rdx
	cdq
	mov rcx, qword [g_18]
	idiv ecx
	mov rax, rdx
	jmp l_170
	l_168:
	mov rax, rsi
	imul rsi
	xor rdx, rdx
	cdq
	mov rcx, qword [g_18]
	idiv ecx
	mov rax, rdx
	imul r13
	xor rdx, rdx
	cdq
	mov rcx, qword [g_18]
	idiv ecx
	mov rax, rdx
	jmp l_170
	l_166:
	mov rax, r13
	xor rdx, rdx
	cdq
	mov rcx, qword [g_18]
	idiv ecx
	mov rax, rdx
	jmp l_170
	l_164:
	mov rax, 1
	l_170:
	mov rcx, qword [g_18]
	mov qword [g_18], rcx
	pop r13
	pop r12
	leave 
	ret
_Calculate_p_User_Defined_fihriaifhiahidsafans:
	l_171:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push r13
	mov rax, qword [g_1]
	mov qword [g_1], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	mov rax, qword [g_1]
	mov rax, qword [rax + 8]
	mov qword [rax + 8], 1
	mov rax, qword [g_1]
	mov rax, qword [rax + 16]
	mov qword [rax + 16], 1
	mov rax, qword [g_1]
	mov rcx, qword [rax + 16]
	mov rax, qword [g_18]
	sub rax, 1
	mov qword [rcx + 8], rax
	mov r13, 2
	l_172:
	mov rax, qword [g_10]
	sub rax, 2
	cmp r13, rax
	jle l_173
	l_174:
	l_175:
	mov rax, qword [g_1]
	mov qword [g_1], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	pop r13
	leave 
	ret
	l_173:
	mov rax, qword [g_18]
	mov rcx, rax
	sub rcx, 2
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rsi, rcx
	mov rdi, r13
	mov rax, qword [g_18]
	mov qword [g_18], rax
	call _Ksm_User_Defined_fihriaifhiahidsafans 
	mov rdi, rax
	mov r8, 0
	l_176:
	cmp r8, r13
	jl l_177
	l_178:
	mov r8, 0
	l_179:
	cmp r8, r13
	jle l_180
	l_181:
	l_182:
	inc r13
	jmp l_172
	l_180:
	mov rax, qword [g_1]
	mov rsi, qword [rax + r13 * 8 + 8]
	mov rax, qword [g_1]
	mov rcx, qword [rax + r13 * 8 + 8]
	mov rdx, r13
	sub rdx, 1
	mov rax, qword [g_1]
	mov rax, qword [rax + rdx * 8 + 8]
	mov rax, qword [rax + r8 * 8 + 8]
	imul r13
	xor rdx, rdx
	cdq
	mov r9, qword [g_18]
	idiv r9d
	mov rax, qword [rcx + r8 * 8 + 8]
	sub rax, rdx
	mov rcx, qword [g_18]
	add rax, rcx
	imul rdi
	xor rdx, rdx
	cdq
	mov rcx, qword [g_18]
	idiv ecx
	mov rax, rdx
	mov qword [rsi + r8 * 8 + 8], rax
	l_183:
	inc r8
	jmp l_179
	l_177:
	mov rcx, r8
	add rcx, 1
	mov rax, qword [g_1]
	mov rdx, qword [rax + r13 * 8 + 8]
	mov rax, r13
	sub rax, 1
	mov rsi, qword [g_1]
	mov rax, qword [rsi + rax * 8 + 8]
	mov rax, qword [rax + r8 * 8 + 8]
	mov qword [rdx + rcx * 8 + 8], rax
	l_184:
	mov r8, rcx
	jmp l_176
_Euler_User_Defined_fihriaifhiahidsafans:
	l_185:
	push rbp
	mov rbp, rsp
	mov rax, qword [g_13]
	mov qword [g_13], rax
	mov rax, qword [g_15]
	mov qword [g_15], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_16]
	mov qword [g_16], rax
	mov rax, qword [g_8]
	mov qword [g_8], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_9]
	mov qword [g_9], rax
	mov rax, 0
	mov qword [g_8], rax
	mov rax, qword [g_9]
	mov rax, qword [rax + rdi * 8 + 8]
	mov qword [rax + 16], 1
	mov r8, 0
	l_186:
	cmp r8, 100001
	jl l_187
	l_188:
	mov r8, 2
	l_189:
	mov rax, qword [g_4]
	cmp r8, rax
	jle l_190
	l_191:
	l_192:
	mov rax, qword [g_13]
	mov qword [g_13], rax
	mov rax, qword [g_15]
	mov qword [g_15], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_16]
	mov qword [g_16], rax
	mov rax, qword [g_8]
	mov qword [g_8], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_9]
	mov qword [g_9], rax
	leave 
	ret
	l_190:
	mov rax, qword [g_13]
	cmp qword [rax + r8 * 8 + 8], 0
	jne l_193
	l_194:
	mov rax, qword [g_8]
	inc rax
	mov qword [g_8], rax
	mov rcx, qword [g_15]
	mov rax, qword [g_8]
	mov qword [rcx + rax * 8 + 8], r8
	mov rax, qword [g_9]
	mov rsi, qword [rax + rdi * 8 + 8]
	mov rax, qword [g_16]
	mov rax, qword [rax + r8 * 8 + 8]
	mov rcx, qword [rax + rdi * 8 + 8]
	mov rax, qword [g_18]
	add rcx, rax
	mov rax, rcx
	sub rax, 1
	xor rdx, rdx
	cdq
	mov rcx, qword [g_18]
	idiv ecx
	mov rax, rdx
	mov qword [rsi + r8 * 8 + 8], rax
	l_193:
	mov rcx, 1
	l_195:
	mov rax, qword [g_8]
	cmp rcx, rax
	jg l_196
	l_197:
	mov rax, qword [g_15]
	mov rax, qword [rax + rcx * 8 + 8]
	imul r8
	mov rsi, qword [g_4]
	cmp rax, rsi
	jg l_196
	l_198:
	mov rax, qword [g_15]
	mov rax, qword [rax + rcx * 8 + 8]
	imul r8
	mov rsi, qword [g_13]
	mov qword [rsi + rax * 8 + 8], 1
	mov rax, r8
	xor rdx, rdx
	cdq
	mov rsi, qword [g_15]
	idiv qword [rsi + rcx * 8 + 8]
	mov rax, rdx
	cmp rax, 0
	je l_199
	l_200:
	mov rax, r8
	mov rdx, qword [g_15]
	imul qword [rdx + rcx * 8 + 8]
	mov rsi, rax
	mov rax, qword [g_9]
	mov r10, qword [rax + rdi * 8 + 8]
	mov rax, qword [g_9]
	mov r11, qword [rax + rdi * 8 + 8]
	mov rax, qword [g_9]
	mov r9, qword [rax + rdi * 8 + 8]
	mov rax, qword [g_15]
	mov rdx, qword [rax + rcx * 8 + 8]
	mov rax, qword [r11 + r8 * 8 + 8]
	imul qword [r9 + rdx * 8 + 8]
	xor rdx, rdx
	cdq
	mov r9, qword [g_18]
	idiv r9d
	mov rax, rdx
	mov qword [r10 + rsi * 8 + 8], rax
	l_201:
	l_202:
	inc rcx
	jmp l_195
	l_199:
	mov rax, r8
	mov rdx, qword [g_15]
	imul qword [rdx + rcx * 8 + 8]
	mov r9, rax
	mov rax, qword [g_9]
	mov rsi, qword [rax + rdi * 8 + 8]
	mov rax, qword [g_9]
	mov rdx, qword [rax + rdi * 8 + 8]
	mov rax, qword [g_15]
	mov rax, qword [rax + rcx * 8 + 8]
	mov rcx, qword [g_16]
	mov rcx, qword [rcx + rax * 8 + 8]
	mov rax, qword [rdx + r8 * 8 + 8]
	imul qword [rcx + rdi * 8 + 8]
	xor rdx, rdx
	cdq
	mov rcx, qword [g_18]
	idiv ecx
	mov rax, rdx
	mov qword [rsi + r9 * 8 + 8], rax
	l_196:
	l_203:
	inc r8
	jmp l_189
	l_187:
	mov rax, qword [g_13]
	mov qword [rax + r8 * 8 + 8], 0
	l_204:
	inc r8
	jmp l_186
_Calculate_q_User_Defined_fihriaifhiahidsafans:
	l_205:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push r13
	mov rax, qword [g_10]
	mov qword [g_10], rax
	mov r13, 0
	l_206:
	mov rax, qword [g_10]
	sub rax, 2
	cmp r13, rax
	jle l_207
	l_208:
	l_209:
	mov rax, qword [g_10]
	mov qword [g_10], rax
	pop r13
	leave 
	ret
	l_207:
	mov rdi, r13
	call _Euler_User_Defined_fihriaifhiahidsafans 
	l_210:
	inc r13
	jmp l_206
_Calculate_Ksm_User_Defined_fihriaifhiahidsafans:
	l_211:
	push rbp
	mov rbp, rsp
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_16]
	mov qword [g_16], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	mov r8, 1
	l_212:
	mov rax, qword [g_4]
	cmp r8, rax
	jle l_213
	l_214:
	l_215:
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_16]
	mov qword [g_16], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	leave 
	ret
	l_213:
	mov rax, qword [g_16]
	mov rax, qword [rax + r8 * 8 + 8]
	mov qword [rax + 8], 1
	mov rsi, 1
	l_216:
	mov rax, qword [g_10]
	sub rax, 2
	cmp rsi, rax
	jle l_217
	l_218:
	l_219:
	inc r8
	jmp l_212
	l_217:
	mov rax, qword [g_16]
	mov rdi, qword [rax + r8 * 8 + 8]
	mov rax, rsi
	sub rax, 1
	mov rcx, qword [g_16]
	mov rcx, qword [rcx + r8 * 8 + 8]
	mov rax, qword [rcx + rax * 8 + 8]
	imul r8
	xor rdx, rdx
	cdq
	mov rcx, qword [g_18]
	idiv ecx
	mov rax, rdx
	mov qword [rdi + rsi * 8 + 8], rax
	l_220:
	inc rsi
	jmp l_216
_Calculate_G_User_Defined_fihriaifhiahidsafans:
	l_221:
	push rbp
	mov rbp, rsp
	mov rax, qword [g_1]
	mov qword [g_1], rax
	mov rax, qword [g_12]
	mov qword [g_12], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_7]
	mov qword [g_7], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_9]
	mov qword [g_9], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	call _Calculate_Ksm_User_Defined_fihriaifhiahidsafans 
	mov rax, qword [g_1]
	mov qword [g_1], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	mov rax, qword [g_1]
	mov qword [g_1], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	call _Calculate_p_User_Defined_fihriaifhiahidsafans 
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_9]
	mov qword [g_9], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_9]
	mov qword [g_9], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	call _Calculate_q_User_Defined_fihriaifhiahidsafans 
	mov rdi, 1
	l_222:
	mov rax, qword [g_4]
	cmp rdi, rax
	jle l_223
	l_224:
	mov rsi, 0
	l_225:
	mov rax, qword [g_7]
	cmp rsi, rax
	jle l_226
	l_227:
	l_228:
	mov rax, qword [g_1]
	mov qword [g_1], rax
	mov rax, qword [g_12]
	mov qword [g_12], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_7]
	mov qword [g_7], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_9]
	mov qword [g_9], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	leave 
	ret
	l_226:
	mov rdi, 2
	l_229:
	mov rax, qword [g_10]
	cmp rdi, rax
	jle l_230
	l_231:
	l_232:
	inc rsi
	jmp l_225
	l_230:
	mov r8, 1
	l_233:
	mov rax, qword [g_4]
	cmp r8, rax
	jle l_234
	l_235:
	l_236:
	inc rdi
	jmp l_229
	l_234:
	mov rax, qword [g_12]
	mov rax, qword [rax + rsi * 8 + 8]
	mov rcx, qword [rax + r8 * 8 + 8]
	mov rdx, r8
	sub rdx, 1
	mov rax, qword [g_12]
	mov rax, qword [rax + rsi * 8 + 8]
	mov rdx, qword [rax + rdx * 8 + 8]
	mov rax, qword [g_2]
	mov rax, qword [rax + rsi * 8 + 8]
	mov rax, qword [rax + r8 * 8 + 8]
	mov rdx, qword [rdx + rdi * 8 + 8]
	add rdx, qword [rax + rdi * 8 + 8]
	mov qword [rcx + rdi * 8 + 8], rdx
	mov rax, qword [g_12]
	mov rax, qword [rax + rsi * 8 + 8]
	mov rax, qword [rax + r8 * 8 + 8]
	mov rcx, qword [g_18]
	cmp qword [rax + rdi * 8 + 8], rcx
	jl l_237
	l_238:
	mov rax, qword [g_12]
	mov rax, qword [rax + rsi * 8 + 8]
	mov rcx, qword [rax + r8 * 8 + 8]
	mov rax, qword [g_12]
	mov rax, qword [rax + rsi * 8 + 8]
	mov rax, qword [rax + r8 * 8 + 8]
	mov rax, qword [rax + rdi * 8 + 8]
	mov rdx, qword [g_18]
	sub rax, rdx
	mov qword [rcx + rdi * 8 + 8], rax
	l_237:
	l_239:
	inc r8
	jmp l_233
	l_223:
	mov r8, 2
	l_240:
	mov rax, qword [g_10]
	cmp r8, rax
	jle l_241
	l_242:
	l_243:
	inc rdi
	jmp l_222
	l_241:
	mov rsi, 0
	l_244:
	mov rcx, r8
	sub rcx, 2
	cmp rsi, rcx
	jle l_245
	l_246:
	mov rsi, 1
	l_247:
	mov rax, qword [g_7]
	cmp rsi, rax
	jle l_248
	l_249:
	l_250:
	inc r8
	jmp l_240
	l_248:
	mov rax, qword [g_2]
	mov rax, qword [rax + rsi * 8 + 8]
	mov rcx, qword [rax + rdi * 8 + 8]
	mov rax, rsi
	sub rax, 1
	mov rdx, qword [g_2]
	mov rax, qword [rdx + rax * 8 + 8]
	mov rax, qword [rax + rdi * 8 + 8]
	mov rax, qword [rax + r8 * 8 + 8]
	imul rdi
	xor rdx, rdx
	cdq
	mov r9, qword [g_18]
	idiv r9d
	mov rax, rdx
	mov qword [rcx + r8 * 8 + 8], rax
	l_251:
	inc rsi
	jmp l_247
	l_245:
	mov rax, qword [g_2]
	mov rax, qword [rax + 8]
	mov r9, qword [rax + rdi * 8 + 8]
	mov rax, qword [g_2]
	mov rax, qword [rax + 8]
	mov r10, qword [rax + rdi * 8 + 8]
	mov rax, rcx
	mov rcx, qword [g_1]
	mov rdx, qword [rcx + rax * 8 + 8]
	mov rax, qword [g_9]
	mov rcx, qword [rax + rsi * 8 + 8]
	mov rax, qword [rdx + rsi * 8 + 8]
	imul qword [rcx + rdi * 8 + 8]
	mov rcx, rax
	mov rax, qword [r10 + r8 * 8 + 8]
	add rax, rcx
	xor rdx, rdx
	cdq
	mov rcx, qword [g_18]
	idiv ecx
	mov rax, rdx
	mov qword [r9 + r8 * 8 + 8], rax
	l_252:
	inc rsi
	jmp l_244
_Calculate_Comb_User_Defined_fihriaifhiahidsafans:
	l_253:
	push rbp
	mov rbp, rsp
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	mov rdx, 0
	l_254:
	mov rax, qword [g_4]
	cmp rdx, rax
	jle l_255
	l_256:
	mov rdx, 1
	l_257:
	mov rax, qword [g_4]
	cmp rdx, rax
	jle l_258
	l_259:
	l_260:
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	leave 
	ret
	l_258:
	mov rsi, 1
	l_261:
	mov rax, qword [g_10]
	cmp rsi, rax
	jle l_262
	l_263:
	l_264:
	inc rdx
	jmp l_257
	l_262:
	mov rax, qword [g_3]
	mov r9, qword [rax + rdx * 8 + 8]
	mov rcx, rdx
	sub rcx, 1
	mov rax, qword [g_3]
	mov r8, qword [rax + rcx * 8 + 8]
	mov rdi, rcx
	mov rcx, rsi
	sub rcx, 1
	mov rax, qword [g_3]
	mov rdi, qword [rax + rdi * 8 + 8]
	mov rax, qword [r8 + rsi * 8 + 8]
	add rax, qword [rdi + rcx * 8 + 8]
	mov qword [r9 + rsi * 8 + 8], rax
	mov rax, qword [g_3]
	mov rax, qword [rax + rdx * 8 + 8]
	mov rcx, qword [g_18]
	cmp qword [rax + rsi * 8 + 8], rcx
	jl l_265
	l_266:
	mov rax, qword [g_3]
	mov rax, qword [rax + rdx * 8 + 8]
	mov rcx, qword [g_3]
	mov rcx, qword [rcx + rdx * 8 + 8]
	mov rcx, qword [rcx + rsi * 8 + 8]
	mov rdi, qword [g_18]
	sub rcx, rdi
	mov qword [rax + rsi * 8 + 8], rcx
	l_265:
	l_267:
	inc rsi
	jmp l_261
	l_255:
	mov rax, qword [g_3]
	mov rax, qword [rax + rdx * 8 + 8]
	mov qword [rax + 8], 1
	l_268:
	inc rdx
	jmp l_254
_main_User_Defined_fihriaifhiahidsafans:
	l_269:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push rbx
	push r14
	push r15
	push r12
	push r13
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_12]
	mov qword [g_12], rax
	mov rax, qword [g_14]
	mov qword [g_14], rax
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_5]
	mov qword [g_5], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_6]
	mov qword [g_6], rax
	mov rax, qword [g_7]
	mov qword [g_7], rax
	mov rax, qword [g_17]
	mov qword [g_17], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	mov rax, qword [g_11]
	mov qword [g_11], rax
	call __getInt 
	mov r13, rax
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_12]
	mov qword [g_12], rax
	mov rax, qword [g_14]
	mov qword [g_14], rax
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_5]
	mov qword [g_5], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_6]
	mov qword [g_6], rax
	mov rax, qword [g_7]
	mov qword [g_7], rax
	mov rax, qword [g_17]
	mov qword [g_17], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	mov rax, qword [g_11]
	mov qword [g_11], rax
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_12]
	mov qword [g_12], rax
	mov rax, qword [g_14]
	mov qword [g_14], rax
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_5]
	mov qword [g_5], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_6]
	mov qword [g_6], rax
	mov rax, qword [g_7]
	mov qword [g_7], rax
	mov rax, qword [g_17]
	mov qword [g_17], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	mov rax, qword [g_11]
	mov qword [g_11], rax
	call _init_User_Defined_fihriaifhiahidsafans 
	mov rax, qword [g_0]
	mov qword [rax + 16], 2
	mov rax, qword [g_5]
	mov qword [rax + 16], 3
	mov rax, qword [g_17]
	mov rax, qword [rax + 16]
	mov qword [rax + 16], 3
	mov rax, qword [g_17]
	mov rax, qword [rax + 16]
	mov qword [rax + 24], 4
	mov rax, qword [g_0]
	mov qword [rax + 24], 3
	mov rax, qword [g_5]
	mov qword [rax + 24], 3
	mov rax, qword [g_17]
	mov rax, qword [rax + 24]
	mov qword [rax + 16], 3
	mov rax, qword [g_17]
	mov rax, qword [rax + 24]
	mov qword [rax + 24], 4
	mov rax, qword [g_17]
	mov rax, qword [rax + 24]
	mov qword [rax + 32], 4
	mov rax, qword [g_0]
	mov qword [rax + 32], 4
	mov rax, qword [g_5]
	mov qword [rax + 32], 4
	mov rax, qword [g_17]
	mov rax, qword [rax + 32]
	mov qword [rax + 16], 5
	mov rax, qword [g_17]
	mov rax, qword [rax + 32]
	mov qword [rax + 24], 7
	mov rax, qword [g_17]
	mov rax, qword [rax + 32]
	mov qword [rax + 32], 8
	mov rax, qword [g_17]
	mov rax, qword [rax + 32]
	mov qword [rax + 40], 9
	mov rax, 4
	mov qword [g_10], rax
	mov rax, 9
	mov qword [g_4], rax
	mov rax, 4
	mov qword [g_7], rax
	mov rax, 10007
	mov qword [g_18], rax
	mov rax, qword [g_12]
	mov qword [g_12], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_7]
	mov qword [g_7], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	mov rax, qword [g_12]
	mov qword [g_12], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_7]
	mov qword [g_7], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	call _Calculate_G_User_Defined_fihriaifhiahidsafans 
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, qword [g_18]
	mov qword [g_18], rax
	mov rax, qword [g_10]
	mov qword [g_10], rax
	call _Calculate_Comb_User_Defined_fihriaifhiahidsafans 
	mov r12, 1
	l_270:
	cmp r12, r13
	jle l_271
	l_272:
	mov rax, 0
	l_273:
	mov rcx, qword [g_0]
	mov qword [g_0], rcx
	mov rcx, qword [g_12]
	mov qword [g_12], rcx
	mov rcx, qword [g_14]
	mov qword [g_14], rcx
	mov rcx, qword [g_3]
	mov qword [g_3], rcx
	mov rcx, qword [g_5]
	mov qword [g_5], rcx
	mov rcx, qword [g_4]
	mov qword [g_4], rcx
	mov rcx, qword [g_6]
	mov qword [g_6], rcx
	mov rcx, qword [g_7]
	mov qword [g_7], rcx
	mov rcx, qword [g_17]
	mov qword [g_17], rcx
	mov rcx, qword [g_18]
	mov qword [g_18], rcx
	mov rcx, qword [g_10]
	mov qword [g_10], rcx
	mov rcx, qword [g_11]
	mov qword [g_11], rcx
	pop r13
	pop r12
	pop r15
	pop r14
	pop rbx
	leave 
	ret
	l_271:
	mov rax, qword [g_0]
	mov rdi, qword [rax + r12 * 8 + 8]
	mov rax, qword [g_5]
	mov rsi, qword [rax + r12 * 8 + 8]
	mov r8, 1
	l_274:
	cmp r8, rdi
	jle l_275
	l_276:
	cmp rdi, 1
	je l_277
	l_278:
	mov r9, 0
	mov r8, 0
	mov r10, 1
	l_279:
	mov rax, qword [g_11]
	cmp r10, qword [rax + 16]
	jle l_280
	l_281:
	cmp r9, 0
	jge l_282
	l_283:
	mov rax, qword [g_18]
	add r9, rax
	l_282:
	mov rdi, r9
	call __toString 
	mov rdi, rax
	call __println 
	jmp l_284
	l_280:
	mov rax, qword [g_11]
	mov rax, qword [rax + 16]
	xor rdx, rdx
	cdq
	idiv r10d
	mov rcx, rax
	mov rax, qword [g_11]
	mov rax, qword [rax + 16]
	xor rdx, rdx
	cdq
	idiv ecx
	mov rcx, rax
	mov r11, 2
	l_285:
	cmp r11, rdi
	jle l_286
	l_287:
	mov rax, qword [g_11]
	cmp qword [rax + 16], rcx
	jge l_288
	l_289:
	mov rax, qword [g_11]
	mov rcx, qword [rax + 16]
	l_288:
	mov r10, rcx
	mov rax, qword [g_14]
	mov qword [rax + 8], 1
	mov r11, 1
	l_290:
	cmp r11, rdi
	jle l_291
	l_292:
	mov r11, 0
	l_293:
	cmp r11, rdi
	jle l_294
	l_295:
	mov r8, r10
	l_296:
	inc r10
	jmp l_279
	l_294:
	mov rax, qword [g_12]
	mov rax, qword [rax + r11 * 8 + 8]
	mov rcx, qword [rax + r10 * 8 + 8]
	mov rax, qword [g_12]
	mov rax, qword [rax + r11 * 8 + 8]
	mov rax, qword [rax + r8 * 8 + 8]
	mov rcx, qword [rcx + rsi * 8 + 8]
	sub rcx, qword [rax + rsi * 8 + 8]
	mov rax, qword [g_14]
	mov rax, qword [rax + r11 * 8 + 8]
	imul rcx
	mov rcx, r9
	add rcx, rax
	mov rax, rcx
	xor rdx, rdx
	cdq
	mov rcx, qword [g_18]
	idiv ecx
	mov rax, rdx
	mov r9, rax
	l_297:
	inc r11
	jmp l_293
	l_291:
	mov rax, qword [g_11]
	mov rax, qword [rax + r11 * 8 + 8]
	xor rdx, rdx
	cdq
	idiv r10d
	xor rdx, rdx
	cdq
	mov rcx, qword [g_18]
	idiv ecx
	mov rax, rdx
	mov r15, rax
	mov rcx, r15
	add rcx, 1
	mov rax, r15
	imul rcx
	xor rdx, rdx
	cdq
	mov rcx, 2
	idiv ecx
	xor rdx, rdx
	cdq
	mov rcx, qword [g_18]
	idiv ecx
	mov rax, rdx
	mov r14, rax
	mov rax, qword [g_11]
	mov rax, qword [rax + r11 * 8 + 8]
	imul r15
	xor rdx, rdx
	cdq
	mov rcx, qword [g_18]
	idiv ecx
	mov rax, rdx
	mov rcx, rax
	mov r15, 0
	l_298:
	cmp r15, r11
	jl l_299
	l_300:
	mov rax, qword [g_6]
	mov qword [rax + 8], 0
	mov r15, 0
	l_301:
	cmp r15, r11
	jl l_302
	l_303:
	mov r15, 0
	l_304:
	cmp r15, r11
	jle l_305
	l_306:
	l_307:
	inc r11
	jmp l_290
	l_305:
	mov rax, qword [g_6]
	mov rax, qword [rax + r15 * 8 + 8]
	mov rcx, qword [g_14]
	mov qword [rcx + r15 * 8 + 8], rax
	l_308:
	inc r15
	jmp l_304
	l_302:
	mov rax, rcx
	mov rdx, qword [g_14]
	imul qword [rdx + r15 * 8 + 8]
	mov r14, qword [g_6]
	mov r14, qword [r14 + r15 * 8 + 8]
	add r14, rax
	mov rax, r14
	xor rdx, rdx
	cdq
	mov r14, qword [g_18]
	idiv r14d
	mov rax, rdx
	mov r14, qword [g_6]
	mov qword [r14 + r15 * 8 + 8], rax
	l_309:
	inc r15
	jmp l_301
	l_299:
	mov rbx, r15
	add rbx, 1
	mov rax, qword [g_18]
	mov rdx, rax
	sub rdx, r14
	mov rax, qword [g_14]
	mov rax, qword [rax + r15 * 8 + 8]
	imul rdx
	xor rdx, rdx
	cdq
	mov r15, qword [g_18]
	idiv r15d
	mov r15, rdx
	mov rax, qword [g_6]
	mov qword [rax + rbx * 8 + 8], r15
	l_310:
	mov r15, rbx
	jmp l_298
	l_286:
	mov rax, qword [g_11]
	mov rax, qword [rax + r11 * 8 + 8]
	xor rdx, rdx
	cdq
	idiv r10d
	mov r15, rax
	mov rax, qword [g_11]
	mov rax, qword [rax + r11 * 8 + 8]
	xor rdx, rdx
	cdq
	idiv r15d
	cmp rax, rcx
	jge l_311
	l_312:
	mov rcx, rax
	l_311:
	l_313:
	inc r11
	jmp l_285
	l_277:
	mov rax, qword [g_11]
	mov rcx, qword [rax + 16]
	mov rax, qword [g_3]
	mov rax, qword [rax + rcx * 8 + 8]
	mov rdi, qword [rax + rsi * 8 + 8]
	call __toString 
	mov rdi, rax
	call __println 
	l_284:
	l_314:
	inc r12
	jmp l_270
	l_275:
	mov rax, qword [g_17]
	mov rax, qword [rax + r12 * 8 + 8]
	mov rax, qword [rax + r8 * 8 + 8]
	mov rcx, qword [g_11]
	mov qword [rcx + r8 * 8 + 8], rax
	l_315:
	inc r8
	jmp l_274
__init:
	l_316:
	push rbp
	mov rbp, rsp
	call _main_User_Defined_fihriaifhiahidsafans 
	leave 
	ret
	 section .data
g_18:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_1:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_6:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_16:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_15:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_8:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_13:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_9:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_2:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_12:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_11:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_14:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_3:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_10:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_4:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_7:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_0:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_5:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_17:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H

