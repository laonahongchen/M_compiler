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
_worka_User_Defined_fihriaifhiahidsafans:
	l_0:
	push rbp
	mov rbp, rsp
	mov rax, rdi
	mov rcx, rsi
	mov rdx, rax
	add rdx, rax
	mov rax, rdx
	sub rax, rcx
	l_1:
	leave 
	ret
_workb_User_Defined_fihriaifhiahidsafans:
	l_2:
	push rbp
	mov rbp, rsp
	mov rcx, rdi
	mov rax, rsi
	neg rcx
	add rcx, rax
	add rcx, rax
	mov rax, rcx
	l_3:
	leave 
	ret
_workc_User_Defined_fihriaifhiahidsafans:
	l_4:
	push rbp
	mov rbp, rsp
	mov rcx, rdi
	mov rax, rsi
	mov rdx, rcx
	add rdx, rcx
	add rdx, rcx
	mov rcx, rdx
	sub rcx, rax
	sub rcx, rax
	mov rax, rcx
	l_5:
	leave 
	ret
_main_User_Defined_fihriaifhiahidsafans:
	l_6:
	push rbp
	mov rbp, rsp
	push rbx
	push r14
	call __getInt 
	mov r8, rax
	mov rsi, 0
	mov rdi, 0
	mov r10, 1
	mov rcx, 0
	mov r9, 1
	mov r11, 1
	l_7:
	cmp r11, 100000000
	jle l_8
	l_9:
	mov rdi, r9
	call __toString 
	mov rdi, rax
	call __println 
	mov rax, 0
	l_10:
	pop r14
	pop rbx
	leave 
	ret
	l_8:
	mov rdx, rsi
	l_11:
	mov rax, r8
	add rax, r8
	sub rax, rdx
	l_12:
	mov r8, rax
	mov rdx, r8
	mov rax, rsi
	l_13:
	neg rdx
	add rdx, rax
	add rdx, rax
	mov rax, rdx
	l_14:
	mov rsi, rax
	mov rdx, r8
	mov r14, rsi
	l_15:
	mov rax, rdx
	add rax, rdx
	add rax, rdx
	sub rax, r14
	sub rax, r14
	l_16:
	mov rdx, rax
	mov rax, r8
	neg rax
	add rax, rsi
	sub rax, rdx
	add rax, rdi
	add rax, r10
	sub rax, rcx
	add rax, r9
	mov rdi, rax
	mov rax, r8
	add rax, rsi
	mov r14, rax
	add r14, rdx
	mov rbx, r14
	sub rbx, rdi
	sub rbx, r10
	mov r10, rbx
	sub r10, rcx
	add r10, r9
	sub rax, rdx
	add rax, rdi
	sub rax, r10
	add rax, rcx
	sub rax, r9
	mov rcx, rax
	mov rax, r8
	sub rax, rsi
	sub rax, rdx
	sub rax, rdi
	add rax, r10
	add rax, rcx
	add r9, rax
	mov rax, r14
	add rax, rdi
	add rax, r10
	add rax, rcx
	add rax, r9
	cmp rax, 100000000
	jle l_17
	l_18:
	mov r8, 123
	mov rsi, 456
	mov rdi, 155
	mov r10, 123
	mov rcx, 55
	mov r9, 32
	l_17:
	l_19:
	inc r11
	jmp l_7
__init:
	l_20:
	push rbp
	mov rbp, rsp
	call _main_User_Defined_fihriaifhiahidsafans 
	leave 
	ret
	 section .data

