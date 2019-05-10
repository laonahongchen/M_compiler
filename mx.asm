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
_printBool_User_Defined_fihriaifhiahidsafans:
	l_0:
	push rbp
	mov rbp, rsp
	mov rax, rdi
	cmp rax, 0
	jne l_1
	l_2:
	mov rdi, g_0
	call __println 
	jmp l_3
	l_1:
	mov rdi, g_1
	call __println 
	l_3:
	l_4:
	leave 
	ret
_main_User_Defined_fihriaifhiahidsafans:
	l_5:
	push rbp
	mov rbp, rsp
	push r13
	push r15
	push rbx
	push r14
	mov r15, g_2
	mov rbx, g_3
	mov r14, g_4
	mov rax, rbx
	mov rdx, 2
	mov rsi, 0
	mov rdi, rax
	call __string_substring 
	mov r13, rax
	mov rsi, r13
	mov rdi, r15
	call __stringComp 
	cmp rax, 0
	je l_6
	l_7:
	mov rax, 0
	jmp l_8
	l_6:
	mov rax, 1
	l_8:
	mov rdi, rax
	call _printBool_User_Defined_fihriaifhiahidsafans 
	mov rsi, r13
	mov rdi, r15
	call __stringComp 
	cmp rax, 0
	jne l_9
	l_10:
	mov rax, 0
	jmp l_11
	l_9:
	mov rax, 1
	l_11:
	mov rdi, rax
	call _printBool_User_Defined_fihriaifhiahidsafans 
	mov rsi, r13
	mov rdi, r15
	call __stringComp 
	cmp rax, 0
	jl l_12
	l_13:
	mov rax, 0
	jmp l_14
	l_12:
	mov rax, 1
	l_14:
	mov rdi, rax
	call _printBool_User_Defined_fihriaifhiahidsafans 
	mov rsi, r13
	mov rdi, r15
	call __stringComp 
	cmp rax, 0
	jg l_15
	l_16:
	mov rax, 0
	jmp l_17
	l_15:
	mov rax, 1
	l_17:
	mov rdi, rax
	call _printBool_User_Defined_fihriaifhiahidsafans 
	mov rsi, r13
	mov rdi, r15
	call __stringComp 
	cmp rax, 0
	jle l_18
	l_19:
	mov rax, 0
	jmp l_20
	l_18:
	mov rax, 1
	l_20:
	mov rdi, rax
	call _printBool_User_Defined_fihriaifhiahidsafans 
	mov rsi, r13
	mov rdi, r15
	call __stringComp 
	cmp rax, 0
	jge l_21
	l_22:
	mov rax, 0
	jmp l_23
	l_21:
	mov rax, 1
	l_23:
	mov rdi, rax
	call _printBool_User_Defined_fihriaifhiahidsafans 
	mov rdi, g_5
	call __println 
	mov rsi, rbx
	mov rdi, r15
	call __stringComp 
	cmp rax, 0
	je l_24
	l_25:
	mov rax, 0
	jmp l_26
	l_24:
	mov rax, 1
	l_26:
	mov rdi, rax
	call _printBool_User_Defined_fihriaifhiahidsafans 
	mov rsi, rbx
	mov rdi, r15
	call __stringComp 
	cmp rax, 0
	jne l_27
	l_28:
	mov rax, 0
	jmp l_29
	l_27:
	mov rax, 1
	l_29:
	mov rdi, rax
	call _printBool_User_Defined_fihriaifhiahidsafans 
	mov rsi, rbx
	mov rdi, r15
	call __stringComp 
	cmp rax, 0
	jl l_30
	l_31:
	mov rax, 0
	jmp l_32
	l_30:
	mov rax, 1
	l_32:
	mov rdi, rax
	call _printBool_User_Defined_fihriaifhiahidsafans 
	mov rsi, rbx
	mov rdi, r15
	call __stringComp 
	cmp rax, 0
	jg l_33
	l_34:
	mov rax, 0
	jmp l_35
	l_33:
	mov rax, 1
	l_35:
	mov rdi, rax
	call _printBool_User_Defined_fihriaifhiahidsafans 
	mov rsi, rbx
	mov rdi, r15
	call __stringComp 
	cmp rax, 0
	jle l_36
	l_37:
	mov rax, 0
	jmp l_38
	l_36:
	mov rax, 1
	l_38:
	mov rdi, rax
	call _printBool_User_Defined_fihriaifhiahidsafans 
	mov rsi, rbx
	mov rdi, r15
	call __stringComp 
	cmp rax, 0
	jge l_39
	l_40:
	mov rax, 0
	jmp l_41
	l_39:
	mov rax, 1
	l_41:
	mov rdi, rax
	call _printBool_User_Defined_fihriaifhiahidsafans 
	mov rdi, g_6
	call __println 
	mov rsi, r14
	mov rdi, rbx
	call __stringComp 
	cmp rax, 0
	je l_42
	l_43:
	mov rax, 0
	jmp l_44
	l_42:
	mov rax, 1
	l_44:
	mov rdi, rax
	call _printBool_User_Defined_fihriaifhiahidsafans 
	mov rsi, r14
	mov rdi, rbx
	call __stringComp 
	cmp rax, 0
	jne l_45
	l_46:
	mov rax, 0
	jmp l_47
	l_45:
	mov rax, 1
	l_47:
	mov rdi, rax
	call _printBool_User_Defined_fihriaifhiahidsafans 
	mov rsi, r14
	mov rdi, rbx
	call __stringComp 
	cmp rax, 0
	jl l_48
	l_49:
	mov rax, 0
	jmp l_50
	l_48:
	mov rax, 1
	l_50:
	mov rdi, rax
	call _printBool_User_Defined_fihriaifhiahidsafans 
	mov rsi, r14
	mov rdi, rbx
	call __stringComp 
	cmp rax, 0
	jg l_51
	l_52:
	mov rax, 0
	jmp l_53
	l_51:
	mov rax, 1
	l_53:
	mov rdi, rax
	call _printBool_User_Defined_fihriaifhiahidsafans 
	mov rsi, r14
	mov rdi, rbx
	call __stringComp 
	cmp rax, 0
	jle l_54
	l_55:
	mov rax, 0
	jmp l_56
	l_54:
	mov rax, 1
	l_56:
	mov rdi, rax
	call _printBool_User_Defined_fihriaifhiahidsafans 
	mov rsi, r14
	mov rdi, rbx
	call __stringComp 
	cmp rax, 0
	jge l_57
	l_58:
	mov rax, 0
	jmp l_59
	l_57:
	mov rax, 1
	l_59:
	mov rdi, rax
	call _printBool_User_Defined_fihriaifhiahidsafans 
	mov rax, 0
	l_60:
	pop r14
	pop rbx
	pop r15
	pop r13
	leave 
	ret
__init:
	l_61:
	push rbp
	mov rbp, rsp
	call _main_User_Defined_fihriaifhiahidsafans 
	leave 
	ret
	 section .data
g_1:
	dq 4
	db 54H, 72H, 75H, 65H, 00H
g_0:
	dq 5
	db 46H, 61H, 6CH, 73H, 65H, 00H
g_2:
	dq 3
	db 41H, 43H, 4DH, 00H
g_3:
	dq 7
	db 41H, 43H, 4DH, 69H, 6CH, 61H, 6EH, 00H
g_4:
	dq 8
	db 41H, 43H, 4DH, 43H, 6CH, 61H, 73H, 73H, 00H
g_5:
	dq 0
	db 00H
g_6:
	dq 0
	db 00H

