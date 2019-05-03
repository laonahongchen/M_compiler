





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
global __stringConcat
global __stringComp

extern strcmp
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
        lea     rdi, [rel L_013]
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
        lea     rdi, [rel L_013]
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
        lea     rdi, [rel L_014]
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
        lea     rsi, [rel L_014]
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

L_002:  mov     edx, dword [rbp-1CH]
        mov     eax, dword [rbp-10H]
        add     eax, edx
        cdqe
        lea     rdx, [rax+8H]
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
        mov     qword [rbp-18H], rdi
        mov     qword [rbp-8H], 0
        mov     dword [rbp-0CH], 0
        add     qword [rbp-18H], 8
        mov     rax, qword [rbp-18H]
        movzx   eax, byte [rax]
        cmp     al, 45
        jnz     L_005
        mov     dword [rbp-0CH], 1
        add     qword [rbp-18H], 1
        jmp     L_005

L_004:  mov     rdx, qword [rbp-8H]
        mov     rax, rdx
        shl     rax, 2
        add     rax, rdx
        add     rax, rax
        mov     rdx, rax
        mov     rax, qword [rbp-18H]
        movzx   eax, byte [rax]
        movsx   eax, al
        sub     eax, 48
        cdqe
        add     rax, rdx
        mov     qword [rbp-8H], rax
        add     qword [rbp-18H], 1
L_005:  mov     rax, qword [rbp-18H]
        movzx   eax, byte [rax]
        cmp     al, 47
        jle     L_006
        mov     rax, qword [rbp-18H]
        movzx   eax, byte [rax]
        cmp     al, 57
        jle     L_004
L_006:  cmp     dword [rbp-0CH], 0
        jz      L_007
        mov     rax, qword [rbp-8H]
        neg     rax
        jmp     L_008

L_007:  mov     rax, qword [rbp-8H]
L_008:  pop     rbp
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


__stringConcat:
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
        jmp     L_010

L_009:  mov     eax, dword [rbp-1CH]
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
L_010:  mov     eax, dword [rbp-1CH]
        cdqe
        cmp     qword [rbp-18H], rax
        jg      L_009
        mov     dword [rbp-1CH], 0
        jmp     L_012

L_011:  mov     eax, dword [rbp-1CH]
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
L_012:  mov     eax, dword [rbp-1CH]
        cdqe
        cmp     qword [rbp-10H], rax
        jg      L_011
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


__stringComp:
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

L_013:
        db 25H, 73H, 00H

L_014:
        db 25H, 6CH, 64H, 00H


;====================================================
	 section .text
_check_User_Defined_fihriaifhiahidsafans:
	l_0:
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov qword [rbp-16], rdi
	mov qword [rbp-8], rsi
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-16]
	cmp r10, rbx
	jge l_1
	l_2:
	mov rbx, qword [rbp-16]
	cmp rbx, 0
	jl l_1
	jmp l_3
	l_1:
	mov rax, 0
	jmp l_4
	l_3:
	mov rax, 1
	l_4:
	l_5:
	leave 
	ret
_main_User_Defined_fihriaifhiahidsafans:
	l_6:
	push rbp
	mov rbp, rsp
	sub rsp, 752
	call __getInt 
	mov qword [rbp-640], rax
	mov rbx, qword [rbp-640]
	mov r10, rbx
	mov qword [rbp-304], r10
	mov rbx, 0
	mov qword [rbp-400], rbx
	mov rbx, 0
	mov qword [rbp-496], rbx
	mov rbx, 0
	mov qword [rbp-352], rbx
	mov rbx, 0
	mov qword [rbp-528], rbx
	mov rbx, 0
	mov qword [rbp-120], rbx
	mov r10, qword [rbp-304]
	mov rbx, r10
	mov qword [rbp-104], rbx
	mov rbx, qword [rbp-104]
	sub rbx, 1
	mov qword [rbp-104], rbx
	mov r10, qword [rbp-104]
	mov rbx, r10
	mov qword [rbp-80], rbx
	mov rbx, 0
	mov qword [rbp-456], rbx
	mov rbx, 0
	mov qword [rbp-720], rbx
	mov rbx, 0
	mov qword [rbp-392], rbx
	mov rbx, 0
	mov qword [rbp-336], rbx
	mov rax, qword [rbp-304]
	mov rbx, qword [rbp-304]
	imul rbx
	mov qword [rbp-8], rax
	mov rbx, qword [rbp-8]
	mov r10, rbx
	mov qword [rbp-72], r10
	mov rbx, qword [rbp-72]
	mov r10, qword [rbp-160]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-160], r10
	mov rdi, qword [rbp-160]
	call malloc 
	mov qword [rbp-312], rax
	mov rbx, qword [rbp-312]
	mov r10, qword [rbp-72]
	mov qword [rbx], r10
	l_7:
	mov rbx, qword [rbp-72]
	cmp rbx, 0
	jg l_8
	l_9:
	mov rbx, qword [rbp-312]
	mov r10, rbx
	mov qword [rbp-616], r10
	mov rbx, 0
	mov qword [rbp-728], rbx
	l_10:
	mov rax, qword [rbp-304]
	mov rbx, qword [rbp-304]
	imul rbx
	mov qword [rbp-184], rax
	mov rbx, qword [rbp-728]
	mov r10, qword [rbp-184]
	cmp rbx, r10
	jl l_11
	l_12:
	mov rax, qword [rbp-304]
	mov rbx, qword [rbp-304]
	imul rbx
	mov qword [rbp-240], rax
	mov rbx, qword [rbp-240]
	mov r10, rbx
	mov qword [rbp-544], r10
	mov rbx, qword [rbp-504]
	mov r10, qword [rbp-544]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-504], rbx
	mov rdi, qword [rbp-504]
	call malloc 
	mov qword [rbp-376], rax
	mov rbx, qword [rbp-376]
	mov r10, qword [rbp-544]
	mov qword [rbx], r10
	l_13:
	mov rbx, qword [rbp-544]
	cmp rbx, 0
	jg l_14
	l_15:
	mov rbx, qword [rbp-376]
	mov r10, rbx
	mov qword [rbp-432], r10
	mov rbx, 0
	mov qword [rbp-728], rbx
	l_16:
	mov rax, qword [rbp-304]
	mov rbx, qword [rbp-304]
	imul rbx
	mov qword [rbp-384], rax
	mov rbx, qword [rbp-384]
	mov r10, qword [rbp-728]
	cmp r10, rbx
	jl l_17
	l_18:
	mov r10, qword [rbp-304]
	mov rbx, r10
	mov qword [rbp-632], rbx
	mov rbx, qword [rbp-272]
	mov r10, qword [rbp-632]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-272], rbx
	mov rdi, qword [rbp-272]
	call malloc 
	mov qword [rbp-136], rax
	mov rbx, qword [rbp-136]
	mov r10, qword [rbp-632]
	mov qword [rbx], r10
	l_19:
	mov rbx, qword [rbp-632]
	cmp rbx, 0
	jg l_20
	l_21:
	mov rbx, qword [rbp-136]
	mov r10, rbx
	mov qword [rbp-648], r10
	mov rbx, 0
	mov qword [rbp-728], rbx
	l_22:
	mov rbx, qword [rbp-728]
	mov r10, qword [rbp-304]
	cmp rbx, r10
	jl l_23
	l_24:
	mov rbx, qword [rbp-616]
	mov r10, qword [rbp-352]
	mov qword [rbx + 8], r10
	mov rbx, qword [rbp-528]
	mov r10, qword [rbp-432]
	mov qword [r10 + 8], rbx
	l_25:
	mov rbx, qword [rbp-400]
	mov r10, qword [rbp-496]
	cmp rbx, r10
	jg l_26
	l_27:
	mov rbx, qword [rbp-616]
	mov r10, qword [rbp-400]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-584], r11
	mov rbx, qword [rbp-584]
	mov r10, qword [rbp-648]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-624], r11
	mov rbx, qword [rbp-400]
	mov r11, qword [rbp-432]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-464], r10
	mov rbx, qword [rbp-464]
	mov r11, qword [rbp-624]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-392], r10
	mov rbx, qword [rbp-616]
	mov r10, qword [rbp-400]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-712], r11
	mov rbx, qword [rbp-712]
	sub rbx, 1
	mov qword [rbp-712], rbx
	mov r10, qword [rbp-712]
	mov rbx, r10
	mov qword [rbp-456], rbx
	mov r10, qword [rbp-400]
	mov r11, qword [rbp-432]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-600], rbx
	mov rbx, qword [rbp-600]
	sub rbx, 2
	mov qword [rbp-600], rbx
	mov rbx, qword [rbp-600]
	mov r10, rbx
	mov qword [rbp-720], r10
	mov rsi, qword [rbp-304]
	mov rdi, qword [rbp-456]
	call _check_User_Defined_fihriaifhiahidsafans 
	cmp rax, 0
	je l_28
	l_29:
	mov rsi, qword [rbp-304]
	mov rdi, qword [rbp-720]
	call _check_User_Defined_fihriaifhiahidsafans 
	cmp rax, 0
	je l_28
	l_30:
	mov rbx, qword [rbp-456]
	mov r11, qword [rbp-648]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-216], r10
	mov rbx, 1
	mov qword [rbp-608], rbx
	mov rbx, qword [rbp-608]
	neg rbx
	mov qword [rbp-608], rbx
	mov rbx, qword [rbp-720]
	mov r10, qword [rbp-216]
	mov r11, qword [rbp-608]
	cmp qword [r10 + rbx * 8 + 8], r11
	jne l_28
	l_31:
	mov rbx, qword [rbp-496]
	add rbx, 1
	mov qword [rbp-496], rbx
	mov rbx, qword [rbp-616]
	mov r10, qword [rbp-496]
	mov r11, qword [rbp-456]
	mov qword [rbx + r10 * 8 + 8], r11
	mov rbx, qword [rbp-496]
	mov r10, qword [rbp-720]
	mov r11, qword [rbp-432]
	mov qword [r11 + rbx * 8 + 8], r10
	mov rbx, qword [rbp-456]
	mov r10, qword [rbp-648]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-288], r11
	mov r10, qword [rbp-392]
	mov rbx, r10
	mov qword [rbp-16], rbx
	mov rbx, qword [rbp-16]
	add rbx, 1
	mov qword [rbp-16], rbx
	mov rbx, qword [rbp-16]
	mov r10, qword [rbp-720]
	mov r11, qword [rbp-288]
	mov qword [r11 + r10 * 8 + 8], rbx
	mov rbx, qword [rbp-120]
	mov r10, qword [rbp-456]
	cmp r10, rbx
	jne l_32
	l_33:
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-720]
	cmp r10, rbx
	jne l_32
	l_34:
	mov rbx, 1
	mov qword [rbp-336], rbx
	l_32:
	l_28:
	mov r10, qword [rbp-616]
	mov r11, qword [rbp-400]
	mov rbx, qword [r10 + r11 * 8 + 8]
	mov qword [rbp-592], rbx
	mov rbx, qword [rbp-592]
	sub rbx, 1
	mov qword [rbp-592], rbx
	mov rbx, qword [rbp-592]
	mov r10, rbx
	mov qword [rbp-456], r10
	mov rbx, qword [rbp-400]
	mov r11, qword [rbp-432]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-416], r10
	mov rbx, qword [rbp-416]
	add rbx, 2
	mov qword [rbp-416], rbx
	mov rbx, qword [rbp-416]
	mov r10, rbx
	mov qword [rbp-720], r10
	mov rsi, qword [rbp-304]
	mov rdi, qword [rbp-456]
	call _check_User_Defined_fihriaifhiahidsafans 
	cmp rax, 0
	je l_35
	l_36:
	mov rsi, qword [rbp-304]
	mov rdi, qword [rbp-720]
	call _check_User_Defined_fihriaifhiahidsafans 
	cmp rax, 0
	je l_35
	l_37:
	mov rbx, qword [rbp-456]
	mov r11, qword [rbp-648]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-568], r10
	mov rbx, 1
	mov qword [rbp-200], rbx
	mov rbx, qword [rbp-200]
	neg rbx
	mov qword [rbp-200], rbx
	mov rbx, qword [rbp-720]
	mov r10, qword [rbp-200]
	mov r11, qword [rbp-568]
	cmp qword [r11 + rbx * 8 + 8], r10
	jne l_35
	l_38:
	mov rbx, qword [rbp-496]
	add rbx, 1
	mov qword [rbp-496], rbx
	mov rbx, qword [rbp-616]
	mov r10, qword [rbp-496]
	mov r11, qword [rbp-456]
	mov qword [rbx + r10 * 8 + 8], r11
	mov rbx, qword [rbp-496]
	mov r10, qword [rbp-720]
	mov r11, qword [rbp-432]
	mov qword [r11 + rbx * 8 + 8], r10
	mov rbx, qword [rbp-456]
	mov r10, qword [rbp-648]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-552], r11
	mov r10, qword [rbp-392]
	mov rbx, r10
	mov qword [rbp-176], rbx
	mov rbx, qword [rbp-176]
	add rbx, 1
	mov qword [rbp-176], rbx
	mov rbx, qword [rbp-176]
	mov r10, qword [rbp-720]
	mov r11, qword [rbp-552]
	mov qword [r11 + r10 * 8 + 8], rbx
	mov rbx, qword [rbp-120]
	mov r10, qword [rbp-456]
	cmp r10, rbx
	jne l_39
	l_40:
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-720]
	cmp r10, rbx
	jne l_39
	l_41:
	mov rbx, 1
	mov qword [rbp-336], rbx
	l_39:
	l_35:
	mov rbx, qword [rbp-616]
	mov r10, qword [rbp-400]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-152], r11
	mov rbx, qword [rbp-152]
	add rbx, 1
	mov qword [rbp-152], rbx
	mov r10, qword [rbp-152]
	mov rbx, r10
	mov qword [rbp-456], rbx
	mov rbx, qword [rbp-400]
	mov r11, qword [rbp-432]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-480], r10
	mov rbx, qword [rbp-480]
	sub rbx, 2
	mov qword [rbp-480], rbx
	mov r10, qword [rbp-480]
	mov rbx, r10
	mov qword [rbp-720], rbx
	mov rsi, qword [rbp-304]
	mov rdi, qword [rbp-456]
	call _check_User_Defined_fihriaifhiahidsafans 
	cmp rax, 0
	je l_42
	l_43:
	mov rsi, qword [rbp-304]
	mov rdi, qword [rbp-720]
	call _check_User_Defined_fihriaifhiahidsafans 
	cmp rax, 0
	je l_42
	l_44:
	mov rbx, qword [rbp-456]
	mov r11, qword [rbp-648]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-224], r10
	mov rbx, 1
	mov qword [rbp-48], rbx
	mov rbx, qword [rbp-48]
	neg rbx
	mov qword [rbp-48], rbx
	mov rbx, qword [rbp-720]
	mov r10, qword [rbp-48]
	mov r11, qword [rbp-224]
	cmp qword [r11 + rbx * 8 + 8], r10
	jne l_42
	l_45:
	mov rbx, qword [rbp-496]
	add rbx, 1
	mov qword [rbp-496], rbx
	mov rbx, qword [rbp-616]
	mov r10, qword [rbp-496]
	mov r11, qword [rbp-456]
	mov qword [rbx + r10 * 8 + 8], r11
	mov rbx, qword [rbp-496]
	mov r10, qword [rbp-720]
	mov r11, qword [rbp-432]
	mov qword [r11 + rbx * 8 + 8], r10
	mov rbx, qword [rbp-456]
	mov r11, qword [rbp-648]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-296], r10
	mov r10, qword [rbp-392]
	mov rbx, r10
	mov qword [rbp-256], rbx
	mov rbx, qword [rbp-256]
	add rbx, 1
	mov qword [rbp-256], rbx
	mov rbx, qword [rbp-256]
	mov r10, qword [rbp-720]
	mov r11, qword [rbp-296]
	mov qword [r11 + r10 * 8 + 8], rbx
	mov rbx, qword [rbp-120]
	mov r10, qword [rbp-456]
	cmp r10, rbx
	jne l_46
	l_47:
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-720]
	cmp r10, rbx
	jne l_46
	l_48:
	mov rbx, 1
	mov qword [rbp-336], rbx
	l_46:
	l_42:
	mov rbx, qword [rbp-616]
	mov r10, qword [rbp-400]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-320], r11
	mov rbx, qword [rbp-320]
	add rbx, 1
	mov qword [rbp-320], rbx
	mov rbx, qword [rbp-320]
	mov r10, rbx
	mov qword [rbp-456], r10
	mov rbx, qword [rbp-400]
	mov r11, qword [rbp-432]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-440], r10
	mov rbx, qword [rbp-440]
	add rbx, 2
	mov qword [rbp-440], rbx
	mov r10, qword [rbp-440]
	mov rbx, r10
	mov qword [rbp-720], rbx
	mov rsi, qword [rbp-304]
	mov rdi, qword [rbp-456]
	call _check_User_Defined_fihriaifhiahidsafans 
	cmp rax, 0
	je l_49
	l_50:
	mov rsi, qword [rbp-304]
	mov rdi, qword [rbp-720]
	call _check_User_Defined_fihriaifhiahidsafans 
	cmp rax, 0
	je l_49
	l_51:
	mov r10, qword [rbp-456]
	mov r11, qword [rbp-648]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-128], rbx
	mov rbx, 1
	mov qword [rbp-328], rbx
	mov rbx, qword [rbp-328]
	neg rbx
	mov qword [rbp-328], rbx
	mov rbx, qword [rbp-328]
	mov r10, qword [rbp-128]
	mov r11, qword [rbp-720]
	cmp qword [r10 + r11 * 8 + 8], rbx
	jne l_49
	l_52:
	mov rbx, qword [rbp-496]
	add rbx, 1
	mov qword [rbp-496], rbx
	mov rbx, qword [rbp-616]
	mov r10, qword [rbp-496]
	mov r11, qword [rbp-456]
	mov qword [rbx + r10 * 8 + 8], r11
	mov rbx, qword [rbp-496]
	mov r10, qword [rbp-720]
	mov r11, qword [rbp-432]
	mov qword [r11 + rbx * 8 + 8], r10
	mov r10, qword [rbp-456]
	mov r11, qword [rbp-648]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-248], rbx
	mov r10, qword [rbp-392]
	mov rbx, r10
	mov qword [rbp-192], rbx
	mov rbx, qword [rbp-192]
	add rbx, 1
	mov qword [rbp-192], rbx
	mov rbx, qword [rbp-248]
	mov r10, qword [rbp-720]
	mov r11, qword [rbp-192]
	mov qword [rbx + r10 * 8 + 8], r11
	mov rbx, qword [rbp-120]
	mov r10, qword [rbp-456]
	cmp r10, rbx
	jne l_53
	l_54:
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-720]
	cmp r10, rbx
	jne l_53
	l_55:
	mov rbx, 1
	mov qword [rbp-336], rbx
	l_53:
	l_49:
	mov r10, qword [rbp-616]
	mov r11, qword [rbp-400]
	mov rbx, qword [r10 + r11 * 8 + 8]
	mov qword [rbp-168], rbx
	mov rbx, qword [rbp-168]
	sub rbx, 2
	mov qword [rbp-168], rbx
	mov rbx, qword [rbp-168]
	mov r10, rbx
	mov qword [rbp-456], r10
	mov rbx, qword [rbp-400]
	mov r10, qword [rbp-432]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-344], r11
	mov rbx, qword [rbp-344]
	sub rbx, 1
	mov qword [rbp-344], rbx
	mov r10, qword [rbp-344]
	mov rbx, r10
	mov qword [rbp-720], rbx
	mov rsi, qword [rbp-304]
	mov rdi, qword [rbp-456]
	call _check_User_Defined_fihriaifhiahidsafans 
	cmp rax, 0
	je l_56
	l_57:
	mov rsi, qword [rbp-304]
	mov rdi, qword [rbp-720]
	call _check_User_Defined_fihriaifhiahidsafans 
	cmp rax, 0
	je l_56
	l_58:
	mov rbx, qword [rbp-456]
	mov r10, qword [rbp-648]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-696], r11
	mov rbx, 1
	mov qword [rbp-576], rbx
	mov rbx, qword [rbp-576]
	neg rbx
	mov qword [rbp-576], rbx
	mov rbx, qword [rbp-720]
	mov r10, qword [rbp-576]
	mov r11, qword [rbp-696]
	cmp qword [r11 + rbx * 8 + 8], r10
	jne l_56
	l_59:
	mov rbx, qword [rbp-496]
	add rbx, 1
	mov qword [rbp-496], rbx
	mov rbx, qword [rbp-616]
	mov r10, qword [rbp-496]
	mov r11, qword [rbp-456]
	mov qword [rbx + r10 * 8 + 8], r11
	mov rbx, qword [rbp-496]
	mov r10, qword [rbp-720]
	mov r11, qword [rbp-432]
	mov qword [r11 + rbx * 8 + 8], r10
	mov r10, qword [rbp-456]
	mov r11, qword [rbp-648]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-512], rbx
	mov r10, qword [rbp-392]
	mov rbx, r10
	mov qword [rbp-208], rbx
	mov rbx, qword [rbp-208]
	add rbx, 1
	mov qword [rbp-208], rbx
	mov rbx, qword [rbp-512]
	mov r10, qword [rbp-720]
	mov r11, qword [rbp-208]
	mov qword [rbx + r10 * 8 + 8], r11
	mov rbx, qword [rbp-120]
	mov r10, qword [rbp-456]
	cmp r10, rbx
	jne l_60
	l_61:
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-720]
	cmp r10, rbx
	jne l_60
	l_62:
	mov rbx, 1
	mov qword [rbp-336], rbx
	l_60:
	l_56:
	mov r10, qword [rbp-616]
	mov r11, qword [rbp-400]
	mov rbx, qword [r10 + r11 * 8 + 8]
	mov qword [rbp-24], rbx
	mov rbx, qword [rbp-24]
	sub rbx, 2
	mov qword [rbp-24], rbx
	mov rbx, qword [rbp-24]
	mov r10, rbx
	mov qword [rbp-456], r10
	mov rbx, qword [rbp-400]
	mov r11, qword [rbp-432]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-32], r10
	mov rbx, qword [rbp-32]
	add rbx, 1
	mov qword [rbp-32], rbx
	mov r10, qword [rbp-32]
	mov rbx, r10
	mov qword [rbp-720], rbx
	mov rsi, qword [rbp-304]
	mov rdi, qword [rbp-456]
	call _check_User_Defined_fihriaifhiahidsafans 
	cmp rax, 0
	je l_63
	l_64:
	mov rsi, qword [rbp-304]
	mov rdi, qword [rbp-720]
	call _check_User_Defined_fihriaifhiahidsafans 
	cmp rax, 0
	je l_63
	l_65:
	mov rbx, qword [rbp-456]
	mov r11, qword [rbp-648]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-88], r10
	mov rbx, 1
	mov qword [rbp-40], rbx
	mov rbx, qword [rbp-40]
	neg rbx
	mov qword [rbp-40], rbx
	mov rbx, qword [rbp-720]
	mov r10, qword [rbp-40]
	mov r11, qword [rbp-88]
	cmp qword [r11 + rbx * 8 + 8], r10
	jne l_63
	l_66:
	mov rbx, qword [rbp-496]
	add rbx, 1
	mov qword [rbp-496], rbx
	mov rbx, qword [rbp-616]
	mov r10, qword [rbp-496]
	mov r11, qword [rbp-456]
	mov qword [rbx + r10 * 8 + 8], r11
	mov rbx, qword [rbp-496]
	mov r10, qword [rbp-720]
	mov r11, qword [rbp-432]
	mov qword [r11 + rbx * 8 + 8], r10
	mov r10, qword [rbp-456]
	mov r11, qword [rbp-648]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-664], rbx
	mov rbx, qword [rbp-392]
	mov r10, rbx
	mov qword [rbp-360], r10
	mov rbx, qword [rbp-360]
	add rbx, 1
	mov qword [rbp-360], rbx
	mov rbx, qword [rbp-664]
	mov r10, qword [rbp-720]
	mov r11, qword [rbp-360]
	mov qword [rbx + r10 * 8 + 8], r11
	mov rbx, qword [rbp-120]
	mov r10, qword [rbp-456]
	cmp r10, rbx
	jne l_67
	l_68:
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-720]
	cmp r10, rbx
	jne l_67
	l_69:
	mov rbx, 1
	mov qword [rbp-336], rbx
	l_67:
	l_63:
	mov r10, qword [rbp-616]
	mov r11, qword [rbp-400]
	mov rbx, qword [r10 + r11 * 8 + 8]
	mov qword [rbp-408], rbx
	mov rbx, qword [rbp-408]
	add rbx, 2
	mov qword [rbp-408], rbx
	mov rbx, qword [rbp-408]
	mov r10, rbx
	mov qword [rbp-456], r10
	mov rbx, qword [rbp-400]
	mov r11, qword [rbp-432]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-656], r10
	mov rbx, qword [rbp-656]
	sub rbx, 1
	mov qword [rbp-656], rbx
	mov r10, qword [rbp-656]
	mov rbx, r10
	mov qword [rbp-720], rbx
	mov rsi, qword [rbp-304]
	mov rdi, qword [rbp-456]
	call _check_User_Defined_fihriaifhiahidsafans 
	cmp rax, 0
	je l_70
	l_71:
	mov rsi, qword [rbp-304]
	mov rdi, qword [rbp-720]
	call _check_User_Defined_fihriaifhiahidsafans 
	cmp rax, 0
	je l_70
	l_72:
	mov r10, qword [rbp-456]
	mov r11, qword [rbp-648]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-704], rbx
	mov rbx, 1
	mov qword [rbp-232], rbx
	mov rbx, qword [rbp-232]
	neg rbx
	mov qword [rbp-232], rbx
	mov rbx, qword [rbp-704]
	mov r10, qword [rbp-232]
	mov r11, qword [rbp-720]
	cmp qword [rbx + r11 * 8 + 8], r10
	jne l_70
	l_73:
	mov rbx, qword [rbp-496]
	add rbx, 1
	mov qword [rbp-496], rbx
	mov rbx, qword [rbp-616]
	mov r10, qword [rbp-496]
	mov r11, qword [rbp-456]
	mov qword [rbx + r10 * 8 + 8], r11
	mov rbx, qword [rbp-496]
	mov r10, qword [rbp-720]
	mov r11, qword [rbp-432]
	mov qword [r11 + rbx * 8 + 8], r10
	mov r10, qword [rbp-456]
	mov r11, qword [rbp-648]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-368], rbx
	mov rbx, qword [rbp-392]
	mov r10, rbx
	mov qword [rbp-488], r10
	mov rbx, qword [rbp-488]
	add rbx, 1
	mov qword [rbp-488], rbx
	mov rbx, qword [rbp-368]
	mov r10, qword [rbp-720]
	mov r11, qword [rbp-488]
	mov qword [rbx + r10 * 8 + 8], r11
	mov rbx, qword [rbp-120]
	mov r10, qword [rbp-456]
	cmp r10, rbx
	jne l_74
	l_75:
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-720]
	cmp r10, rbx
	jne l_74
	l_76:
	mov rbx, 1
	mov qword [rbp-336], rbx
	l_74:
	l_70:
	mov rbx, qword [rbp-616]
	mov r10, qword [rbp-400]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-64], r11
	mov rbx, qword [rbp-64]
	add rbx, 2
	mov qword [rbp-64], rbx
	mov r10, qword [rbp-64]
	mov rbx, r10
	mov qword [rbp-456], rbx
	mov r10, qword [rbp-400]
	mov r11, qword [rbp-432]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-752], rbx
	mov rbx, qword [rbp-752]
	add rbx, 1
	mov qword [rbp-752], rbx
	mov rbx, qword [rbp-752]
	mov r10, rbx
	mov qword [rbp-720], r10
	mov rsi, qword [rbp-304]
	mov rdi, qword [rbp-456]
	call _check_User_Defined_fihriaifhiahidsafans 
	cmp rax, 0
	je l_77
	l_78:
	mov rsi, qword [rbp-304]
	mov rdi, qword [rbp-720]
	call _check_User_Defined_fihriaifhiahidsafans 
	cmp rax, 0
	je l_77
	l_79:
	mov r10, qword [rbp-456]
	mov r11, qword [rbp-648]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-672], rbx
	mov rbx, 1
	mov qword [rbp-560], rbx
	mov rbx, qword [rbp-560]
	neg rbx
	mov qword [rbp-560], rbx
	mov rbx, qword [rbp-672]
	mov r10, qword [rbp-720]
	mov r11, qword [rbp-560]
	cmp qword [rbx + r10 * 8 + 8], r11
	jne l_77
	l_80:
	mov rbx, qword [rbp-496]
	add rbx, 1
	mov qword [rbp-496], rbx
	mov rbx, qword [rbp-616]
	mov r10, qword [rbp-496]
	mov r11, qword [rbp-456]
	mov qword [rbx + r10 * 8 + 8], r11
	mov rbx, qword [rbp-496]
	mov r10, qword [rbp-720]
	mov r11, qword [rbp-432]
	mov qword [r11 + rbx * 8 + 8], r10
	mov r10, qword [rbp-456]
	mov r11, qword [rbp-648]
	mov rbx, qword [r11 + r10 * 8 + 8]
	mov qword [rbp-688], rbx
	mov rbx, qword [rbp-392]
	mov r10, rbx
	mov qword [rbp-520], r10
	mov rbx, qword [rbp-520]
	add rbx, 1
	mov qword [rbp-520], rbx
	mov rbx, qword [rbp-688]
	mov r10, qword [rbp-720]
	mov r11, qword [rbp-520]
	mov qword [rbx + r10 * 8 + 8], r11
	mov rbx, qword [rbp-120]
	mov r10, qword [rbp-456]
	cmp r10, rbx
	jne l_81
	l_82:
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-720]
	cmp r10, rbx
	jne l_81
	l_83:
	mov rbx, 1
	mov qword [rbp-336], rbx
	l_81:
	l_77:
	mov rbx, qword [rbp-336]
	cmp rbx, 1
	je l_84
	l_85:
	mov rbx, qword [rbp-400]
	add rbx, 1
	mov qword [rbp-400], rbx
	jmp l_25
	l_84:
	l_26:
	mov rbx, qword [rbp-336]
	cmp rbx, 1
	je l_86
	l_87:
	mov rdi, g_0
	call __print 
	jmp l_88
	l_86:
	mov rbx, qword [rbp-120]
	mov r11, qword [rbp-648]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-96], r10
	mov rbx, qword [rbp-80]
	mov r10, qword [rbp-96]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-280], r11
	mov rdi, qword [rbp-280]
	call __toString 
	mov qword [rbp-264], rax
	mov rdi, qword [rbp-264]
	call __println 
	l_88:
	mov rax, 0
	l_89:
	leave 
	ret
	l_23:
	mov r10, qword [rbp-304]
	mov rbx, r10
	mov qword [rbp-472], rbx
	mov rbx, qword [rbp-56]
	mov r10, qword [rbp-472]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-56], rbx
	mov rdi, qword [rbp-56]
	call malloc 
	mov qword [rbp-536], rax
	mov rbx, qword [rbp-536]
	mov r10, qword [rbp-472]
	mov qword [rbx], r10
	l_90:
	mov rbx, qword [rbp-472]
	cmp rbx, 0
	jg l_91
	l_92:
	mov rbx, qword [rbp-728]
	mov r10, qword [rbp-536]
	mov r11, qword [rbp-648]
	mov qword [r11 + rbx * 8 + 8], r10
	mov rbx, 0
	mov qword [rbp-744], rbx
	l_93:
	mov rbx, qword [rbp-744]
	mov r10, qword [rbp-304]
	cmp rbx, r10
	jl l_94
	l_95:
	l_96:
	mov rbx, qword [rbp-728]
	mov r10, rbx
	mov qword [rbp-680], r10
	mov rbx, qword [rbp-728]
	inc rbx
	mov qword [rbp-728], rbx
	mov r10, qword [rbp-680]
	mov rbx, r10
	mov qword [rbp-728], rbx
	jmp l_22
	l_94:
	mov rbx, qword [rbp-728]
	mov r11, qword [rbp-648]
	mov r10, qword [r11 + rbx * 8 + 8]
	mov qword [rbp-424], r10
	mov rbx, 1
	mov qword [rbp-112], rbx
	mov rbx, qword [rbp-112]
	neg rbx
	mov qword [rbp-112], rbx
	mov rbx, qword [rbp-424]
	mov r10, qword [rbp-744]
	mov r11, qword [rbp-112]
	mov qword [rbx + r10 * 8 + 8], r11
	l_97:
	mov r10, qword [rbp-744]
	mov rbx, r10
	mov qword [rbp-736], rbx
	mov rbx, qword [rbp-744]
	inc rbx
	mov qword [rbp-744], rbx
	mov rbx, qword [rbp-736]
	mov r10, rbx
	mov qword [rbp-744], r10
	jmp l_93
	l_91:
	mov rbx, qword [rbp-536]
	mov r10, qword [rbp-472]
	mov qword [rbx + r10 * 8], 0
	mov rbx, qword [rbp-472]
	dec rbx
	mov qword [rbp-472], rbx
	jmp l_90
	l_20:
	mov rbx, qword [rbp-136]
	mov r10, qword [rbp-632]
	mov qword [rbx + r10 * 8], 0
	mov rbx, qword [rbp-632]
	dec rbx
	mov qword [rbp-632], rbx
	jmp l_19
	l_17:
	mov rbx, qword [rbp-728]
	mov r10, qword [rbp-432]
	mov qword [r10 + rbx * 8 + 8], 0
	l_98:
	mov rbx, qword [rbp-728]
	mov r10, rbx
	mov qword [rbp-144], r10
	mov rbx, qword [rbp-728]
	inc rbx
	mov qword [rbp-728], rbx
	mov r10, qword [rbp-144]
	mov rbx, r10
	mov qword [rbp-728], rbx
	jmp l_16
	l_14:
	mov rbx, qword [rbp-376]
	mov r10, qword [rbp-544]
	mov qword [rbx + r10 * 8], 0
	mov rbx, qword [rbp-544]
	dec rbx
	mov qword [rbp-544], rbx
	jmp l_13
	l_11:
	mov rbx, qword [rbp-616]
	mov r10, qword [rbp-728]
	mov qword [rbx + r10 * 8 + 8], 0
	l_99:
	mov rbx, qword [rbp-728]
	mov r10, rbx
	mov qword [rbp-448], r10
	mov rbx, qword [rbp-728]
	inc rbx
	mov qword [rbp-728], rbx
	mov r10, qword [rbp-448]
	mov rbx, r10
	mov qword [rbp-728], rbx
	jmp l_10
	l_8:
	mov rbx, qword [rbp-312]
	mov r10, qword [rbp-72]
	mov qword [rbx + r10 * 8], 0
	mov rbx, qword [rbp-72]
	dec rbx
	mov qword [rbp-72], rbx
	jmp l_7
__init:
	l_100:
	push rbp
	mov rbp, rsp
	sub rsp, 0
	call _main_User_Defined_fihriaifhiahidsafans 
	leave 
	ret
	 section .data
g_0:
	dq 13
	db 6EH, 6FH, 20H, 73H, 6FH, 6CH, 75H, 74H, 69H, 6FH, 6EH, 21H, 0AH, 00H

