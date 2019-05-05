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
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_1]
	mov qword [g_1], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rcx, 1
	l_1:
	mov rax, qword [g_0]
	cmp rcx, rax
	jle l_2
	l_3:
	l_4:
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_1]
	mov qword [g_1], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	leave 
	ret
	l_2:
	mov rax, qword [g_1]
	mov rax, qword [rax + rcx * 8 + 8]
	mov rdx, qword [g_2]
	mov qword [rdx + rcx * 8 + 8], rax
	l_5:
	inc rcx
	jmp l_1
_quicksort_User_Defined_fihriaifhiahidsafans:
	l_6:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push r14
	push r12
	push r15
	mov r12, rsi
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov r15, 0
	mov rax, qword [g_2]
	mov rsi, qword [rax + rdi * 8 + 8]
	mov r8, 0
	mov r14, 0
	mov rax, rdi
	add rax, 1
	mov rdx, rax
	l_7:
	cmp rdx, r12
	jl l_8
	l_9:
	mov rax, rdi
	mov rdx, 0
	l_10:
	cmp rdx, r8
	jl l_11
	l_12:
	mov rdx, rax
	inc rax
	mov rcx, qword [g_2]
	mov qword [rcx + rdx * 8 + 8], rsi
	mov rdx, 0
	l_13:
	cmp rdx, r14
	jl l_14
	l_15:
	cmp r8, 1
	jle l_16
	l_17:
	mov rcx, rdi
	add rcx, r8
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rsi, rcx
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	call _quicksort_User_Defined_fihriaifhiahidsafans 
	add r15, rax
	l_16:
	cmp r14, 1
	jle l_18
	l_19:
	mov rcx, r12
	sub rcx, r14
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rsi, r12
	mov rdi, rcx
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	call _quicksort_User_Defined_fihriaifhiahidsafans 
	add r15, rax
	l_18:
	mov rax, r15
	l_20:
	mov rcx, qword [g_3]
	mov qword [g_3], rcx
	mov rcx, qword [g_2]
	mov qword [g_2], rcx
	mov rcx, qword [g_4]
	mov qword [g_4], rcx
	pop r15
	pop r12
	pop r14
	leave 
	ret
	l_14:
	mov r9, rax
	inc rax
	mov rcx, qword [g_3]
	mov rcx, qword [rcx + rdx * 8 + 8]
	mov rsi, qword [g_2]
	mov qword [rsi + r9 * 8 + 8], rcx
	l_21:
	inc rdx
	jmp l_13
	l_11:
	mov r9, rax
	inc rax
	mov rcx, qword [g_4]
	mov r10, qword [rcx + rdx * 8 + 8]
	mov rcx, qword [g_2]
	mov qword [rcx + r9 * 8 + 8], r10
	l_22:
	inc rdx
	jmp l_10
	l_8:
	inc r15
	mov rax, qword [g_2]
	cmp qword [rax + rdx * 8 + 8], rsi
	jl l_23
	l_24:
	mov rax, r14
	inc r14
	mov rcx, qword [g_2]
	mov r9, qword [rcx + rdx * 8 + 8]
	mov rcx, qword [g_3]
	mov qword [rcx + rax * 8 + 8], r9
	jmp l_25
	l_23:
	mov r9, r8
	inc r8
	mov rax, qword [g_2]
	mov rcx, qword [rax + rdx * 8 + 8]
	mov rax, qword [g_4]
	mov qword [rax + r9 * 8 + 8], rcx
	l_25:
	l_26:
	inc rdx
	jmp l_7
_calc_User_Defined_fihriaifhiahidsafans:
	l_27:
	push rbp
	mov rbp, rsp
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rsi, 1
	l_28:
	mov rax, qword [g_0]
	cmp rsi, rax
	jle l_29
	l_30:
	mov rdx, 0
	mov rax, qword [g_0]
	mov rsi, rax
	l_31:
	cmp rsi, 1
	jge l_32
	l_33:
	mov rax, rdx
	l_34:
	mov rcx, qword [g_3]
	mov qword [g_3], rcx
	mov rcx, qword [g_0]
	mov qword [g_0], rcx
	mov rcx, qword [g_2]
	mov qword [g_2], rcx
	mov rcx, qword [g_4]
	mov qword [g_4], rcx
	leave 
	ret
	l_32:
	mov rax, qword [g_2]
	mov rax, qword [rax + rsi * 8 + 8]
	mov rcx, qword [g_4]
	mov rdi, qword [rcx + rax * 8 + 8]
	mov rax, qword [g_2]
	mov rcx, qword [rax + rsi * 8 + 8]
	mov rax, qword [g_3]
	mov rax, qword [rax + rcx * 8 + 8]
	mov rcx, qword [g_3]
	mov qword [rcx + rdi * 8 + 8], rax
	mov rcx, qword [g_4]
	mov qword [rcx + rax * 8 + 8], rdi
	mov rcx, rdx
	add rcx, rax
	mov rax, rcx
	sub rax, rdi
	sub rax, 2
	mov rdx, rax
	l_35:
	dec rsi
	jmp l_31
	l_29:
	mov rcx, rsi
	sub rcx, 1
	mov rax, qword [g_4]
	mov qword [rax + rsi * 8 + 8], rcx
	mov rcx, rsi
	add rcx, 1
	mov rax, qword [g_3]
	mov qword [rax + rsi * 8 + 8], rcx
	l_36:
	inc rsi
	jmp l_28
_mergesort_User_Defined_fihriaifhiahidsafans:
	l_37:
	push rbp
	mov rbp, rsp
	push rbx
	push r14
	push r12
	push r15
	mov r14, rdi
	mov r15, rsi
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rax, r14
	add rax, 1
	cmp rax, r15
	je l_38
	l_39:
	mov rax, r14
	add rax, r15
	mov rcx, 1
	sar rax, cl
	mov rbx, rax
	mov r12, 0
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rsi, rbx
	mov rdi, r14
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	call _mergesort_User_Defined_fihriaifhiahidsafans 
	add r12, rax
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	mov rsi, r15
	mov rdi, rbx
	mov rax, qword [g_3]
	mov qword [g_3], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_4]
	mov qword [g_4], rax
	call _mergesort_User_Defined_fihriaifhiahidsafans 
	add r12, rax
	mov rdi, 0
	mov rsi, 0
	mov rdx, r14
	l_40:
	cmp rdx, rbx
	jl l_41
	l_42:
	mov rdx, rbx
	l_43:
	cmp rdx, r15
	jl l_44
	l_45:
	mov r9, 0
	mov rdx, 0
	mov rax, r14
	l_46:
	cmp r9, rdi
	jge l_47
	l_48:
	cmp rdx, rsi
	jge l_47
	jmp l_49
	l_47:
	l_50:
	cmp r9, rdi
	jl l_51
	l_52:
	l_53:
	cmp rdx, rsi
	jl l_54
	l_55:
	mov rax, r12
	jmp l_56
	l_54:
	mov r8, rax
	inc rax
	mov rdi, rdx
	inc rdx
	mov rcx, qword [g_3]
	mov rdi, qword [rcx + rdi * 8 + 8]
	mov rcx, qword [g_2]
	mov qword [rcx + r8 * 8 + 8], rdi
	jmp l_53
	l_51:
	mov r10, rax
	inc rax
	mov r8, r9
	inc r9
	mov rcx, qword [g_4]
	mov r8, qword [rcx + r8 * 8 + 8]
	mov rcx, qword [g_2]
	mov qword [rcx + r10 * 8 + 8], r8
	jmp l_50
	l_49:
	inc r12
	mov rcx, qword [g_4]
	mov r8, qword [rcx + r9 * 8 + 8]
	mov rcx, qword [g_3]
	cmp r8, qword [rcx + rdx * 8 + 8]
	jl l_57
	l_58:
	mov r10, rax
	inc rax
	mov rcx, rdx
	inc rdx
	mov r8, qword [g_3]
	mov rcx, qword [r8 + rcx * 8 + 8]
	mov r8, qword [g_2]
	mov qword [r8 + r10 * 8 + 8], rcx
	jmp l_59
	l_57:
	mov r8, rax
	inc rax
	mov r10, r9
	inc r9
	mov rcx, qword [g_4]
	mov r10, qword [rcx + r10 * 8 + 8]
	mov rcx, qword [g_2]
	mov qword [rcx + r8 * 8 + 8], r10
	l_59:
	jmp l_46
	l_44:
	mov rcx, rsi
	inc rsi
	mov rax, qword [g_2]
	mov r8, qword [rax + rdx * 8 + 8]
	mov rax, qword [g_3]
	mov qword [rax + rcx * 8 + 8], r8
	l_60:
	inc rdx
	jmp l_43
	l_41:
	mov r8, rdi
	inc rdi
	mov rax, qword [g_2]
	mov rcx, qword [rax + rdx * 8 + 8]
	mov rax, qword [g_4]
	mov qword [rax + r8 * 8 + 8], rcx
	l_61:
	inc rdx
	jmp l_40
	l_38:
	mov rax, 0
	l_56:
	mov rcx, qword [g_3]
	mov qword [g_3], rcx
	mov rcx, qword [g_2]
	mov qword [g_2], rcx
	mov rcx, qword [g_4]
	mov qword [g_4], rcx
	pop r15
	pop r12
	pop r14
	pop rbx
	leave 
	ret
_heapsort_User_Defined_fihriaifhiahidsafans:
	l_62:
	push rbp
	mov rbp, rsp
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_5]
	mov qword [g_5], rax
	mov rdi, 0
	mov rdx, 1
	l_63:
	mov rax, qword [g_0]
	cmp rdx, rax
	jle l_64
	l_65:
	mov rax, qword [g_0]
	mov r9, rax
	mov rdx, 1
	l_66:
	mov rax, qword [g_0]
	cmp rdx, rax
	jle l_67
	l_68:
	mov rax, rdi
	l_69:
	mov rcx, qword [g_0]
	mov qword [g_0], rcx
	mov rcx, qword [g_2]
	mov qword [g_2], rcx
	mov rcx, qword [g_5]
	mov qword [g_5], rcx
	leave 
	ret
	l_67:
	mov rax, qword [g_5]
	mov rcx, qword [rax + 16]
	mov rax, qword [g_2]
	mov qword [rax + rdx * 8 + 8], rcx
	mov rcx, r9
	dec r9
	mov rax, qword [g_5]
	mov rax, qword [rax + rcx * 8 + 8]
	mov rcx, qword [g_5]
	mov qword [rcx + 16], rax
	mov r8, 1
	l_70:
	mov rax, r8
	mov rcx, 1
	sal rax, cl
	cmp rax, r9
	jg l_71
	l_72:
	mov rax, r8
	mov rcx, 1
	sal rax, cl
	mov rsi, rax
	mov rax, rsi
	add rax, 1
	mov r11, rax
	mov r10, rsi
	cmp r11, r9
	jg l_73
	l_74:
	inc rdi
	mov rax, qword [g_5]
	mov rax, qword [rax + r11 * 8 + 8]
	mov rcx, qword [g_5]
	cmp rax, qword [rcx + rsi * 8 + 8]
	jge l_75
	l_76:
	mov r10, r11
	l_75:
	l_73:
	inc rdi
	mov rax, qword [g_5]
	mov rax, qword [rax + r8 * 8 + 8]
	mov rcx, qword [g_5]
	cmp rax, qword [rcx + r10 * 8 + 8]
	jl l_77
	l_78:
	mov rax, qword [g_5]
	mov r11, qword [rax + r8 * 8 + 8]
	mov rax, qword [g_5]
	mov rax, qword [rax + r10 * 8 + 8]
	mov rcx, qword [g_5]
	mov qword [rcx + r8 * 8 + 8], rax
	mov rax, qword [g_5]
	mov qword [rax + r10 * 8 + 8], r11
	mov r8, r10
	jmp l_70
	l_77:
	l_71:
	l_79:
	inc rdx
	jmp l_66
	l_64:
	mov rax, qword [g_2]
	mov rcx, qword [rax + rdx * 8 + 8]
	mov rax, qword [g_5]
	mov qword [rax + rdx * 8 + 8], rcx
	mov rsi, rdx
	l_80:
	cmp rsi, 1
	je l_81
	l_82:
	inc rdi
	mov r8, rsi
	mov rcx, 1
	sar r8, cl
	mov rax, qword [g_5]
	mov rcx, qword [rax + rsi * 8 + 8]
	mov rax, qword [g_5]
	cmp rcx, qword [rax + r8 * 8 + 8]
	jg l_83
	l_84:
	mov rax, qword [g_5]
	mov r11, qword [rax + rsi * 8 + 8]
	mov rax, rsi
	mov rcx, 1
	sar rax, cl
	mov rcx, qword [g_5]
	mov rax, qword [rcx + rax * 8 + 8]
	mov rcx, qword [g_5]
	mov qword [rcx + rsi * 8 + 8], rax
	mov r8, rsi
	mov rcx, 1
	sar r8, cl
	mov rax, qword [g_5]
	mov qword [rax + r8 * 8 + 8], r11
	mov rcx, 1
	sar rsi, cl
	jmp l_80
	l_83:
	l_81:
	l_85:
	inc rdx
	jmp l_63
_main_User_Defined_fihriaifhiahidsafans:
	l_86:
	push rbp
	mov rbp, rsp
	push rbx
	push r14
	push r12
	push r15
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_1]
	mov qword [g_1], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	call __getInt 
	mov qword [g_0], rax
	call __getInt 
	mov rsi, 1
	l_87:
	mov rcx, qword [g_0]
	cmp rsi, rcx
	jle l_88
	l_89:
	mov rax, qword [g_0]
	add rax, 1
	mov rcx, qword [g_2]
	mov qword [g_2], rcx
	mov rsi, rax
	mov rdi, 1
	mov rax, qword [g_2]
	mov qword [g_2], rax
	call _quicksort_User_Defined_fihriaifhiahidsafans 
	mov r12, rax
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_1]
	mov qword [g_1], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_1]
	mov qword [g_1], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	call _restore_User_Defined_fihriaifhiahidsafans 
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	call _calc_User_Defined_fihriaifhiahidsafans 
	mov r15, rax
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_1]
	mov qword [g_1], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_1]
	mov qword [g_1], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	call _restore_User_Defined_fihriaifhiahidsafans 
	mov rax, qword [g_0]
	mov rcx, rax
	add rcx, 1
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rsi, rcx
	mov rdi, 1
	mov rax, qword [g_2]
	mov qword [g_2], rax
	call _mergesort_User_Defined_fihriaifhiahidsafans 
	mov r14, rax
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_1]
	mov qword [g_1], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_1]
	mov qword [g_1], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	call _restore_User_Defined_fihriaifhiahidsafans 
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	mov rax, qword [g_0]
	mov qword [g_0], rax
	mov rax, qword [g_2]
	mov qword [g_2], rax
	call _heapsort_User_Defined_fihriaifhiahidsafans 
	mov rbx, rax
	mov rdi, r12
	call __toString 
	mov rdi, rax
	call __println 
	mov rdi, r15
	call __toString 
	mov rdi, rax
	call __println 
	mov rdi, r14
	call __toString 
	mov rdi, rax
	call __println 
	mov rdi, rbx
	call __toString 
	mov rdi, rax
	call __println 
	mov rdi, 8
	call malloc 
	add rax, 8
	mov qword [rax], 0
	sub rax, 8
	mov rdi, rax
	call _Optimizer_User_Defined_fihriaifhiahidsafans 
	mov rax, 0
	l_90:
	mov rcx, qword [g_0]
	mov qword [g_0], rcx
	mov rcx, qword [g_1]
	mov qword [g_1], rcx
	mov rcx, qword [g_2]
	mov qword [g_2], rcx
	pop r15
	pop r12
	pop r14
	pop rbx
	leave 
	ret
	l_88:
	mov rcx, qword [g_2]
	mov qword [rcx + rsi * 8 + 8], rsi
	cmp rsi, rax
	jg l_91
	l_92:
	mov rcx, rax
	add rcx, 1
	mov rdx, rcx
	sub rdx, rsi
	mov rcx, qword [g_2]
	mov qword [rcx + rsi * 8 + 8], rdx
	l_91:
	mov rcx, qword [g_2]
	mov rcx, qword [rcx + rsi * 8 + 8]
	mov rdx, qword [g_1]
	mov qword [rdx + rsi * 8 + 8], rcx
	l_93:
	inc rsi
	jmp l_87
_A_User_Defined_fihriaifhiahidsafans:
	l_94:
	push rbp
	mov rbp, rsp
	sub rsp, 200
	push r13
	push rbx
	push r14
	push r12
	push r15
	mov rcx, rdi
	mov qword [rbp-152], rcx
	mov r15, 2
	lea rax, [r15 * 8 + 8]
	mov rdi, rax
	call malloc 
	mov qword [rbp-48], rax
	mov rax, qword [rbp-48]
	mov qword [rax], r15
	l_95:
	cmp r15, 0
	jg l_96
	l_97:
	mov rcx, qword [rbp-48]
	mov rax, qword [rbp-152]
	mov qword [rax + 0], rcx
	l_98:
	pop r15
	pop r12
	pop r14
	pop rbx
	pop r13
	leave 
	ret
	l_96:
	mov r12, 2
	mov rax, qword [rbp-80]
	lea rax, [r12 * 8 + 8]
	mov qword [rbp-80], rax
	mov rax, qword [rbp-80]
	mov rdi, rax
	call malloc 
	mov qword [rbp-72], rax
	mov rax, qword [rbp-72]
	mov qword [rax], r12
	l_99:
	cmp r12, 0
	jg l_100
	l_101:
	mov rax, qword [rbp-72]
	mov rcx, qword [rbp-48]
	mov qword [rcx + r15 * 8], rax
	dec r15
	jmp l_95
	l_100:
	mov rax, 3
	mov qword [rbp-104], rax
	mov rcx, qword [rbp-104]
	mov rax, qword [rbp-88]
	lea rax, [rcx * 8 + 8]
	mov qword [rbp-88], rax
	mov rax, qword [rbp-88]
	mov rdi, rax
	call malloc 
	mov qword [rbp-160], rax
	mov rax, qword [rbp-104]
	mov rcx, qword [rbp-160]
	mov qword [rcx], rax
	l_102:
	mov rax, qword [rbp-104]
	cmp rax, 0
	jg l_103
	l_104:
	mov rax, qword [rbp-160]
	mov rcx, qword [rbp-72]
	mov qword [rcx + r12 * 8], rax
	dec r12
	jmp l_99
	l_103:
	mov rax, 2
	mov qword [rbp-64], rax
	mov rax, qword [rbp-64]
	mov rcx, qword [rbp-40]
	lea rcx, [rax * 8 + 8]
	mov qword [rbp-40], rcx
	mov rax, qword [rbp-40]
	mov rdi, rax
	call malloc 
	mov qword [rbp-32], rax
	mov rcx, qword [rbp-64]
	mov rax, qword [rbp-32]
	mov qword [rax], rcx
	l_105:
	mov rax, qword [rbp-64]
	cmp rax, 0
	jg l_106
	l_107:
	mov rcx, qword [rbp-32]
	mov rdx, qword [rbp-160]
	mov rax, qword [rbp-104]
	mov qword [rdx + rax * 8], rcx
	mov rax, qword [rbp-104]
	dec rax
	mov qword [rbp-104], rax
	jmp l_102
	l_106:
	mov rax, 3
	mov qword [rbp-144], rax
	mov rcx, qword [rbp-144]
	mov rax, qword [rbp-56]
	lea rax, [rcx * 8 + 8]
	mov qword [rbp-56], rax
	mov rax, qword [rbp-56]
	mov rdi, rax
	call malloc 
	mov qword [rbp-24], rax
	mov rax, qword [rbp-144]
	mov rcx, qword [rbp-24]
	mov qword [rcx], rax
	l_108:
	mov rax, qword [rbp-144]
	cmp rax, 0
	jg l_109
	l_110:
	mov rax, qword [rbp-24]
	mov rdx, qword [rbp-32]
	mov rcx, qword [rbp-64]
	mov qword [rdx + rcx * 8], rax
	mov rax, qword [rbp-64]
	dec rax
	mov qword [rbp-64], rax
	jmp l_105
	l_109:
	mov r14, 2
	mov rax, qword [rbp-176]
	lea rax, [r14 * 8 + 8]
	mov qword [rbp-176], rax
	mov rax, qword [rbp-176]
	mov rdi, rax
	call malloc 
	mov qword [rbp-96], rax
	mov rax, qword [rbp-96]
	mov qword [rax], r14
	l_111:
	cmp r14, 0
	jg l_112
	l_113:
	mov rax, qword [rbp-96]
	mov rdx, qword [rbp-24]
	mov rcx, qword [rbp-144]
	mov qword [rdx + rcx * 8], rax
	mov rax, qword [rbp-144]
	dec rax
	mov qword [rbp-144], rax
	jmp l_108
	l_112:
	mov rax, 2
	mov qword [rbp-16], rax
	mov rax, qword [rbp-16]
	mov rcx, qword [rbp-184]
	lea rcx, [rax * 8 + 8]
	mov qword [rbp-184], rcx
	mov rax, qword [rbp-184]
	mov rdi, rax
	call malloc 
	mov qword [rbp-120], rax
	mov rax, qword [rbp-16]
	mov rcx, qword [rbp-120]
	mov qword [rcx], rax
	l_114:
	mov rax, qword [rbp-16]
	cmp rax, 0
	jg l_115
	l_116:
	mov rax, qword [rbp-120]
	mov rcx, qword [rbp-96]
	mov qword [rcx + r14 * 8], rax
	dec r14
	jmp l_111
	l_115:
	mov rax, 3
	mov qword [rbp-192], rax
	mov rax, qword [rbp-192]
	mov rcx, qword [rbp-168]
	lea rcx, [rax * 8 + 8]
	mov qword [rbp-168], rcx
	mov rax, qword [rbp-168]
	mov rdi, rax
	call malloc 
	mov qword [rbp-136], rax
	mov rax, qword [rbp-192]
	mov rcx, qword [rbp-136]
	mov qword [rcx], rax
	l_117:
	mov rax, qword [rbp-192]
	cmp rax, 0
	jg l_118
	l_119:
	mov rcx, qword [rbp-136]
	mov rax, qword [rbp-120]
	mov rdx, qword [rbp-16]
	mov qword [rax + rdx * 8], rcx
	mov rax, qword [rbp-16]
	dec rax
	mov qword [rbp-16], rax
	jmp l_114
	l_118:
	mov rbx, 2
	mov rax, qword [rbp-128]
	lea rax, [rbx * 8 + 8]
	mov qword [rbp-128], rax
	mov rax, qword [rbp-128]
	mov rdi, rax
	call malloc 
	mov qword [rbp-112], rax
	mov rax, qword [rbp-112]
	mov qword [rax], rbx
	l_120:
	cmp rbx, 0
	jg l_121
	l_122:
	mov rax, qword [rbp-112]
	mov rdx, qword [rbp-136]
	mov rcx, qword [rbp-192]
	mov qword [rdx + rcx * 8], rax
	mov rax, qword [rbp-192]
	dec rax
	mov qword [rbp-192], rax
	jmp l_117
	l_121:
	mov r13, 2
	mov rax, qword [rbp-8]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-8], rax
	mov rax, qword [rbp-8]
	mov rdi, rax
	call malloc 
	mov qword [rax], r13
	l_123:
	cmp r13, 0
	jg l_124
	l_125:
	mov rcx, qword [rbp-112]
	mov qword [rcx + rbx * 8], rax
	dec rbx
	jmp l_120
	l_124:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_123
_Optimizer_User_Defined_fihriaifhiahidsafans:
	l_126:
	push rbp
	mov rbp, rsp
	sub rsp, 200
	push r13
	push rbx
	push r14
	push r12
	push r15
	mov r15, 2
	lea rax, [r15 * 8 + 8]
	mov rdi, rax
	call malloc 
	mov qword [rbp-8], rax
	mov rax, qword [rbp-8]
	mov qword [rax], r15
	l_127:
	cmp r15, 0
	jg l_128
	l_129:
	mov rax, qword [rbp-8]
	mov rdx, rax
	mov r15, 0
	mov rsi, 1
	l_130:
	cmp rsi, 1000
	jle l_131
	l_132:
	mov rdi, r15
	call __toString 
	mov rdi, rax
	call __println 
	mov rsi, 1
	l_133:
	cmp rsi, 1000000
	jle l_134
	l_135:
	mov rdi, r15
	call __toString 
	mov rdi, rax
	call __println 
	l_136:
	pop r15
	pop r12
	pop r14
	pop rbx
	pop r13
	leave 
	ret
	l_134:
	mov rax, 9876
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	mov rcx, 2345
	imul rcx
	cdq
	mov rcx, 1234
	idiv rcx
	mov rax, rdx
	cdq
	mov rcx, 11
	idiv rcx
	mov rax, rdx
	add r15, rax
	l_137:
	inc rsi
	jmp l_133
	l_131:
	mov rax, qword [rdx + 8]
	mov rax, qword [rax + 16]
	mov rax, qword [rax + 8]
	mov rax, qword [rax + 16]
	mov rax, qword [rax + 8]
	mov rax, qword [rax + 16]
	mov rax, qword [rax + 8]
	mov rax, qword [rax + 16]
	mov rcx, qword [rax + 8]
	mov rax, 123
	add rax, rsi
	mov qword [rcx + 16], rax
	mov rax, qword [rdx + 8]
	mov rax, qword [rax + 16]
	mov rax, qword [rax + 8]
	mov rax, qword [rax + 16]
	mov rax, qword [rax + 8]
	mov rax, qword [rax + 16]
	mov rax, qword [rax + 8]
	mov rax, qword [rax + 16]
	mov rax, qword [rax + 8]
	add r15, qword [rax + 16]
	l_138:
	inc rsi
	jmp l_130
	l_128:
	mov rax, 2
	mov qword [rbp-40], rax
	mov rax, qword [rbp-40]
	mov rcx, qword [rbp-152]
	lea rcx, [rax * 8 + 8]
	mov qword [rbp-152], rcx
	mov rax, qword [rbp-152]
	mov rdi, rax
	call malloc 
	mov qword [rbp-96], rax
	mov rcx, qword [rbp-40]
	mov rax, qword [rbp-96]
	mov qword [rax], rcx
	l_139:
	mov rax, qword [rbp-40]
	cmp rax, 0
	jg l_140
	l_141:
	mov rcx, qword [rbp-96]
	mov rax, qword [rbp-8]
	mov qword [rax + r15 * 8], rcx
	dec r15
	jmp l_127
	l_140:
	mov r12, 2
	mov rax, qword [rbp-128]
	lea rax, [r12 * 8 + 8]
	mov qword [rbp-128], rax
	mov rax, qword [rbp-128]
	mov rdi, rax
	call malloc 
	mov qword [rbp-104], rax
	mov rax, qword [rbp-104]
	mov qword [rax], r12
	l_142:
	cmp r12, 0
	jg l_143
	l_144:
	mov rcx, qword [rbp-104]
	mov rdx, qword [rbp-96]
	mov rax, qword [rbp-40]
	mov qword [rdx + rax * 8], rcx
	mov rax, qword [rbp-40]
	dec rax
	mov qword [rbp-40], rax
	jmp l_139
	l_143:
	mov rax, 2
	mov qword [rbp-48], rax
	mov rax, qword [rbp-48]
	mov rcx, qword [rbp-72]
	lea rcx, [rax * 8 + 8]
	mov qword [rbp-72], rcx
	mov rax, qword [rbp-72]
	mov rdi, rax
	call malloc 
	mov qword [rbp-136], rax
	mov rcx, qword [rbp-48]
	mov rax, qword [rbp-136]
	mov qword [rax], rcx
	l_145:
	mov rax, qword [rbp-48]
	cmp rax, 0
	jg l_146
	l_147:
	mov rax, qword [rbp-136]
	mov rcx, qword [rbp-104]
	mov qword [rcx + r12 * 8], rax
	dec r12
	jmp l_142
	l_146:
	mov r14, 2
	mov rax, qword [rbp-56]
	lea rax, [r14 * 8 + 8]
	mov qword [rbp-56], rax
	mov rax, qword [rbp-56]
	mov rdi, rax
	call malloc 
	mov qword [rbp-16], rax
	mov rax, qword [rbp-16]
	mov qword [rax], r14
	l_148:
	cmp r14, 0
	jg l_149
	l_150:
	mov rdx, qword [rbp-16]
	mov rax, qword [rbp-136]
	mov rcx, qword [rbp-48]
	mov qword [rax + rcx * 8], rdx
	mov rax, qword [rbp-48]
	dec rax
	mov qword [rbp-48], rax
	jmp l_145
	l_149:
	mov rbx, 2
	mov rax, qword [rbp-32]
	lea rax, [rbx * 8 + 8]
	mov qword [rbp-32], rax
	mov rax, qword [rbp-32]
	mov rdi, rax
	call malloc 
	mov qword [rbp-24], rax
	mov rax, qword [rbp-24]
	mov qword [rax], rbx
	l_151:
	cmp rbx, 0
	jg l_152
	l_153:
	mov rax, qword [rbp-24]
	mov rcx, qword [rbp-16]
	mov qword [rcx + r14 * 8], rax
	dec r14
	jmp l_148
	l_152:
	mov rax, 2
	mov qword [rbp-168], rax
	mov rcx, qword [rbp-168]
	mov rax, qword [rbp-160]
	lea rax, [rcx * 8 + 8]
	mov qword [rbp-160], rax
	mov rax, qword [rbp-160]
	mov rdi, rax
	call malloc 
	mov qword [rbp-144], rax
	mov rcx, qword [rbp-168]
	mov rax, qword [rbp-144]
	mov qword [rax], rcx
	l_154:
	mov rax, qword [rbp-168]
	cmp rax, 0
	jg l_155
	l_156:
	mov rax, qword [rbp-144]
	mov rcx, qword [rbp-24]
	mov qword [rcx + rbx * 8], rax
	dec rbx
	jmp l_151
	l_155:
	mov rax, 2
	mov qword [rbp-120], rax
	mov rcx, qword [rbp-120]
	mov rax, qword [rbp-88]
	lea rax, [rcx * 8 + 8]
	mov qword [rbp-88], rax
	mov rax, qword [rbp-88]
	mov rdi, rax
	call malloc 
	mov qword [rbp-176], rax
	mov rax, qword [rbp-120]
	mov rcx, qword [rbp-176]
	mov qword [rcx], rax
	l_157:
	mov rax, qword [rbp-120]
	cmp rax, 0
	jg l_158
	l_159:
	mov rcx, qword [rbp-176]
	mov rax, qword [rbp-144]
	mov rdx, qword [rbp-168]
	mov qword [rax + rdx * 8], rcx
	mov rax, qword [rbp-168]
	dec rax
	mov qword [rbp-168], rax
	jmp l_154
	l_158:
	mov r13, 2
	mov rax, qword [rbp-184]
	lea rax, [r13 * 8 + 8]
	mov qword [rbp-184], rax
	mov rax, qword [rbp-184]
	mov rdi, rax
	call malloc 
	mov qword [rbp-80], rax
	mov rax, qword [rbp-80]
	mov qword [rax], r13
	l_160:
	cmp r13, 0
	jg l_161
	l_162:
	mov rax, qword [rbp-80]
	mov rdx, qword [rbp-176]
	mov rcx, qword [rbp-120]
	mov qword [rdx + rcx * 8], rax
	mov rax, qword [rbp-120]
	dec rax
	mov qword [rbp-120], rax
	jmp l_157
	l_161:
	mov rax, 2
	mov qword [rbp-64], rax
	mov rcx, qword [rbp-64]
	mov rax, qword [rbp-112]
	lea rax, [rcx * 8 + 8]
	mov qword [rbp-112], rax
	mov rax, qword [rbp-112]
	mov rdi, rax
	call malloc 
	mov rcx, rax
	mov rax, qword [rbp-64]
	mov qword [rcx], rax
	l_163:
	mov rax, qword [rbp-64]
	cmp rax, 0
	jg l_164
	l_165:
	mov rax, qword [rbp-80]
	mov qword [rax + r13 * 8], rcx
	dec r13
	jmp l_160
	l_164:
	mov rax, qword [rbp-64]
	mov qword [rcx + rax * 8], 0
	mov rax, qword [rbp-64]
	dec rax
	mov qword [rbp-64], rax
	jmp l_163
__init:
	l_166:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push rbx
	push r13
	push r14
	push r12
	push r15
	mov rax, 100000
	mov qword [g_6], rax
	mov rax, qword [g_6]
	mov r13, rax
	lea rcx, [r13 * 8 + 8]
	mov rdi, rcx
	call malloc 
	mov qword [rax], r13
	l_167:
	cmp r13, 0
	jg l_168
	l_169:
	mov qword [g_2], rax
	mov rax, qword [g_6]
	mov r13, rax
	lea r15, [r13 * 8 + 8]
	mov rdi, r15
	call malloc 
	mov qword [rax], r13
	l_170:
	cmp r13, 0
	jg l_171
	l_172:
	mov qword [g_1], rax
	mov rax, qword [g_6]
	mov r15, rax
	lea rbx, [r15 * 8 + 8]
	mov rdi, rbx
	call malloc 
	mov qword [rax], r15
	l_173:
	cmp r15, 0
	jg l_174
	l_175:
	mov qword [g_4], rax
	mov rax, qword [g_6]
	mov r15, rax
	lea r12, [r15 * 8 + 8]
	mov rdi, r12
	call malloc 
	mov qword [rax], r15
	l_176:
	cmp r15, 0
	jg l_177
	l_178:
	mov qword [g_3], rax
	mov rax, qword [g_6]
	mov r15, rax
	lea r14, [r15 * 8 + 8]
	mov rdi, r14
	call malloc 
	mov qword [rax], r15
	l_179:
	cmp r15, 0
	jg l_180
	l_181:
	mov qword [g_5], rax
	call _main_User_Defined_fihriaifhiahidsafans 
	pop r15
	pop r12
	pop r14
	pop r13
	pop rbx
	leave 
	ret
	l_180:
	mov qword [rax + r15 * 8], 0
	dec r15
	jmp l_179
	l_177:
	mov qword [rax + r15 * 8], 0
	dec r15
	jmp l_176
	l_174:
	mov qword [rax + r15 * 8], 0
	dec r15
	jmp l_173
	l_171:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_170
	l_168:
	mov qword [rax + r13 * 8], 0
	dec r13
	jmp l_167
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

