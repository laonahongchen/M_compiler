





default rel

global main
global __print
global __println
global __getString
global __getInt
global __toString
global __string_length
global __string_substring
global __string_parseInt
global __string_ord
global __stringConcate
global __stringCompare

extern strcmp
extern atoi
extern sprintf
extern __stack_chk_fail
extern strcpy
extern malloc
extern strlen
extern __isoc99_scanf
extern puts
extern printf
extern _GLOBAL_OFFSET_TABLE_


SECTION .text   

main:
        push    rbp
        mov     rbp, rsp
        mov     eax, 0
        call    __init
        pop     rbp
        ret


__print:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     rax, qword [rbp-8H]
        add     rax, 8
        mov     rsi, rax
        lea     rdi, [rel L_008]
        mov     eax, 0
        call    printf
        nop
        leave
        ret


__println:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     rax, qword [rbp-8H]
        add     rax, 8
        mov     rdi, rax
        call    puts
        nop
        leave
        ret


__getString:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        lea     rsi, [rel __buffer.2954]
        lea     rdi, [rel L_008]
        mov     eax, 0
        call    __isoc99_scanf
        lea     rdi, [rel __buffer.2954]
        call    strlen
        mov     dword [rbp-0CH], eax
        mov     eax, dword [rbp-0CH]
        add     eax, 8
        cdqe
        mov     rdi, rax
        call    malloc
        mov     qword [rbp-8H], rax
        mov     eax, dword [rbp-0CH]
        movsxd  rdx, eax
        mov     rax, qword [rbp-8H]
        mov     qword [rax], rdx
        mov     rax, qword [rbp-8H]
        add     rax, 8
        lea     rsi, [rel __buffer.2954]
        mov     rdi, rax
        call    strcpy
        mov     rax, qword [rbp-8H]
        leave
        ret


__getInt:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16


        mov     rax, qword [fs:abs 28H]
        mov     qword [rbp-8H], rax
        xor     eax, eax
        lea     rax, [rbp-10H]
        mov     rsi, rax
        lea     rdi, [rel L_009]
        mov     eax, 0
        call    __isoc99_scanf
        mov     rax, qword [rbp-10H]
        mov     rdx, qword [rbp-8H]


        xor     rdx, qword [fs:abs 28H]
        jz      L_001
        call    __stack_chk_fail
L_001:  leave
        ret


__toString:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     qword [rbp-18H], rdi
        mov     edi, 32
        call    malloc
        mov     qword [rbp-8H], rax
        mov     rax, qword [rbp-8H]
        lea     rcx, [rax+8H]
        mov     rax, qword [rbp-18H]
        mov     rdx, rax
        lea     rsi, [rel L_009]
        mov     rdi, rcx
        mov     eax, 0
        call    sprintf
        movsxd  rdx, eax
        mov     rax, qword [rbp-8H]
        mov     qword [rax], rdx
        mov     rax, qword [rbp-8H]
        leave
        ret


__string_length:
        push    rbp
        mov     rbp, rsp
        mov     qword [rbp-8H], rdi
        mov     rax, qword [rbp-8H]
        mov     rax, qword [rax]
        pop     rbp
        ret


__string_substring:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     qword [rbp-18H], rdi
        mov     dword [rbp-1CH], esi
        mov     dword [rbp-20H], edx
        mov     eax, dword [rbp-20H]
        sub     eax, dword [rbp-1CH]
        add     eax, 1
        mov     dword [rbp-0CH], eax
        mov     eax, dword [rbp-0CH]
        add     eax, 9
        cdqe
        mov     rdi, rax
        call    malloc
        mov     qword [rbp-8H], rax
        mov     eax, dword [rbp-0CH]
        movsxd  rdx, eax
        mov     rax, qword [rbp-8H]
        mov     qword [rax], rdx
        mov     dword [rbp-10H], 0
        jmp     L_003

L_002:  mov     eax, dword [rbp-1CH]
        lea     edx, [rax+8H]
        mov     eax, dword [rbp-10H]
        add     eax, edx
        movsxd  rdx, eax
        mov     rax, qword [rbp-18H]
        add     rax, rdx
        mov     edx, dword [rbp-10H]
        add     edx, 8
        movsxd  rcx, edx
        mov     rdx, qword [rbp-8H]
        add     rdx, rcx
        movzx   eax, byte [rax]
        mov     byte [rdx], al
        add     dword [rbp-10H], 1
L_003:  mov     eax, dword [rbp-10H]
        cmp     eax, dword [rbp-0CH]
        jl      L_002
        mov     eax, dword [rbp-0CH]
        add     eax, 8
        movsxd  rdx, eax
        mov     rax, qword [rbp-8H]
        add     rax, rdx
        mov     byte [rax], 0
        mov     rax, qword [rbp-8H]
        leave
        ret


__string_parseInt:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     rax, qword [rbp-8H]
        mov     rdi, rax
        call    atoi
        cdqe
        leave
        ret


__string_ord:
        push    rbp
        mov     rbp, rsp
        mov     qword [rbp-8H], rdi
        mov     qword [rbp-10H], rsi
        mov     rax, qword [rbp-10H]
        add     rax, 8
        mov     rdx, rax
        mov     rax, qword [rbp-8H]
        add     rax, rdx
        movzx   eax, byte [rax]
        movsx   rax, al
        pop     rbp
        ret


__stringConcate:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 48
        mov     qword [rbp-28H], rdi
        mov     qword [rbp-30H], rsi
        mov     rax, qword [rbp-28H]
        mov     rax, qword [rax]
        mov     qword [rbp-18H], rax
        mov     rax, qword [rbp-30H]
        mov     rax, qword [rax]
        mov     qword [rbp-10H], rax
        mov     rdx, qword [rbp-18H]
        mov     rax, qword [rbp-10H]
        add     rax, rdx
        add     rax, 9
        mov     rdi, rax
        call    malloc
        mov     qword [rbp-8H], rax
        mov     rdx, qword [rbp-18H]
        mov     rax, qword [rbp-10H]
        add     rdx, rax
        mov     rax, qword [rbp-8H]
        mov     qword [rax], rdx
        mov     dword [rbp-1CH], 0
        jmp     L_005

L_004:  mov     eax, dword [rbp-1CH]
        add     eax, 8
        movsxd  rdx, eax
        mov     rax, qword [rbp-28H]
        add     rax, rdx
        mov     edx, dword [rbp-1CH]
        add     edx, 8
        movsxd  rcx, edx
        mov     rdx, qword [rbp-8H]
        add     rdx, rcx
        movzx   eax, byte [rax]
        mov     byte [rdx], al
        add     dword [rbp-1CH], 1
L_005:  mov     eax, dword [rbp-1CH]
        cdqe
        cmp     qword [rbp-18H], rax
        jg      L_004
        mov     dword [rbp-1CH], 0
        jmp     L_007

L_006:  mov     eax, dword [rbp-1CH]
        add     eax, 8
        movsxd  rdx, eax
        mov     rax, qword [rbp-30H]
        add     rax, rdx
        mov     rdx, qword [rbp-18H]
        lea     rcx, [rdx+8H]
        mov     edx, dword [rbp-1CH]
        movsxd  rdx, edx
        add     rdx, rcx
        mov     rcx, rdx
        mov     rdx, qword [rbp-8H]
        add     rdx, rcx
        movzx   eax, byte [rax]
        mov     byte [rdx], al
        add     dword [rbp-1CH], 1
L_007:  mov     eax, dword [rbp-1CH]
        cdqe
        cmp     qword [rbp-10H], rax
        jg      L_006
        mov     rax, qword [rbp-18H]
        lea     rdx, [rax+8H]
        mov     rax, qword [rbp-10H]
        add     rax, rdx
        mov     rdx, rax
        mov     rax, qword [rbp-8H]
        add     rax, rdx
        mov     byte [rax], 0
        mov     rax, qword [rbp-8H]
        leave
        ret


__stringCompare:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     qword [rbp-10H], rsi
        mov     rax, qword [rbp-10H]
        lea     rdx, [rax+8H]
        mov     rax, qword [rbp-8H]
        add     rax, 8
        mov     rsi, rdx
        mov     rdi, rax
        call    strcmp
        cdqe
        leave
        ret



SECTION .data   


SECTION .bss    align=32

__buffer.2954:
        resb    1048576


SECTION .rodata 

L_008:
        db 25H, 73H, 00H

L_009:
        db 25H, 6CH, 64H, 00H


;====================================================	 section .text
_main_User_Defined_fihriaifhiahidsafans:
	l_19:
	push rbp
	mov rbp, rsp
	sub rsp, 64
	mov rbx, 0
	mov qword [rbp-8], rbx
	mov rbx, 0
	mov qword [rbp-32], rbx
	l_20:
	mov rbx, qword [rbp-32]
	cmp rbx, 5
	jl l_21
	l_22:
	mov rax, 0
	l_23:
	leave 
	ret
	l_21:
	mov rbx, qword [rbp-8]
	mov r10, rbx
	mov qword [rbp-48], r10
	mov rbx, qword [rbp-32]
	mov rsi, qword [rbp-32]
	mov rbx, qword [rbp-48]
	mov rdi, qword [rbp-48]
	call _set_problem_User_Defined_fihriaifhiahidsafans 
	mov rbx, qword [rbp-8]
	mov r10, rbx
	mov qword [rbp-40], r10
	mov rbx, qword [rbp-40]
	mov rdi, qword [rbp-40]
	call _get_result_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-24], rax
	mov qword [rbp-24], rbx
	mov rbx, qword [rbp-24]
	mov rdi, qword [rbp-24]
	call __toString 
	mov qword [rbp-16], rax
	mov qword [rbp-16], rbx
	mov rbx, qword [rbp-16]
	mov rdi, qword [rbp-16]
	call __println 
	l_24:
	mov r10, qword [rbp-32]
	mov rbx, r10
	mov qword [rbp-56], rbx
	mov rbx, qword [rbp-32]
	inc rbx
	mov qword [rbp-32], rbx
	jmp l_20
_Fibonacci_User_Defined_fihriaifhiahidsafans:
	l_25:
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov qword [rbp-8], rdi
	mov qword [rbp-8], rbx
	l_26:
	leave 
	ret
_reset_User_Defined_fihriaifhiahidsafans:
	l_27:
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov qword [rbp-8], rdi
	mov qword [rbp-8], rbx
	mov rbx, qword [rbp-8]
	mov qword [rbx + 0], 0
	mov rbx, qword [rbp-8]
	mov qword [rbx + 8], 0
	l_28:
	leave 
	ret
_set_problem_User_Defined_fihriaifhiahidsafans:
	l_29:
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov qword [rbp-8], rdi
	mov qword [rbp-8], rbx
	mov qword [rbp-16], rsi
	mov qword [rbp-16], rbx
	mov rbx, qword [rbp-8]
	mov rdi, qword [rbp-8]
	call _reset_User_Defined_fihriaifhiahidsafans 
	mov rbx, qword [rbp-16]
	mov r10, qword [rbp-8]
	mov qword [r10 + 0], rbx
	l_30:
	leave 
	ret
_calc_User_Defined_fihriaifhiahidsafans:
	l_31:
	push rbp
	mov rbp, rsp
	sub rsp, 48
	mov qword [rbp-40], rdi
	mov qword [rbp-40], rbx
	mov qword [rbp-8], rsi
	mov qword [rbp-8], rbx
	mov rbx, qword [rbp-8]
	cmp rbx, 0
	je l_32
	l_33:
	mov r10, qword [rbp-8]
	mov rbx, r10
	mov qword [rbp-24], rbx
	mov rbx, qword [rbp-24]
	sub rbx, 1
	mov qword [rbp-24], rbx
	mov rbx, qword [rbp-24]
	mov rsi, qword [rbp-24]
	mov rbx, qword [rbp-40]
	mov rdi, qword [rbp-40]
	call _calc_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-16], rax
	mov qword [rbp-16], rbx
	mov rbx, qword [rbp-8]
	mov rax, qword [rbp-8]
	mov rbx, qword [rbp-16]
	imul rbx
	mov qword [rbp-32], rax
	mov qword [rbp-32], rbx
	mov rbx, qword [rbp-32]
	mov rax, qword [rbp-32]
	jmp l_34
	l_32:
	mov rax, 1
	l_34:
	leave 
	ret
_get_result_User_Defined_fihriaifhiahidsafans:
	l_35:
	push rbp
	mov rbp, rsp
	sub rsp, 32
	mov qword [rbp-16], rdi
	mov qword [rbp-16], rbx
	mov r10, qword [rbp-16]
	mov rbx, qword [r10 + 0]
	mov qword [rbp-24], rbx
	mov rbx, qword [rbp-24]
	mov rsi, qword [rbp-24]
	mov rbx, qword [rbp-16]
	mov rdi, qword [rbp-16]
	call _calc_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-32], rax
	mov qword [rbp-32], rbx
	mov rbx, qword [rbp-32]
	mov r10, qword [rbp-16]
	mov qword [r10 + 8], rbx
	mov r10, qword [rbp-16]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-8], rbx
	mov rbx, qword [rbp-8]
	mov rax, qword [rbp-8]
	l_36:
	leave 
	ret
__init:
	l_37:
	push rbp
	mov rbp, rsp
	sub rsp, 0
	call _main_User_Defined_fihriaifhiahidsafans 
	leave 
	ret
	 section .data

