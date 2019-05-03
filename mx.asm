





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
extern atoi
extern strncpy
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
        lea     rdi, [rel L_006]
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
        lea     rdi, [rel L_006]
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
        lea     rdi, [rel L_007]
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
        lea     rsi, [rel L_007]
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
        mov     eax, dword [rbp-0CH]
        cdqe
        mov     edx, dword [rbp-1CH]
        movsxd  rdx, edx
        lea     rcx, [rdx+8H]
        mov     rdx, qword [rbp-18H]
        lea     rsi, [rcx+rdx]
        mov     rdx, qword [rbp-8H]
        lea     rcx, [rdx+8H]
        mov     rdx, rax
        mov     rdi, rcx
        call    strncpy
        mov     rax, qword [rbp-8H]
        leave
        ret


__string_parseInt:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     rax, qword [rbp-8H]
        add     rax, 8
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
        jmp     L_003

L_002:  mov     eax, dword [rbp-1CH]
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
L_003:  mov     eax, dword [rbp-1CH]
        cdqe
        cmp     qword [rbp-18H], rax
        jg      L_002
        mov     dword [rbp-1CH], 0
        jmp     L_005

L_004:  mov     eax, dword [rbp-1CH]
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
L_005:  mov     eax, dword [rbp-1CH]
        cdqe
        cmp     qword [rbp-10H], rax
        jg      L_004
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

L_006:
        db 25H, 73H, 00H

L_007:
        db 25H, 6CH, 64H, 00H


;====================================================
	 section .text
_origin_User_Defined_fihriaifhiahidsafans:
	l_0:
	push rbp
	mov rbp, rsp
	sub rsp, 80
	mov qword [rbp-80], rdi
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	mov rbx, qword [rbp-80]
	mov r10, rbx
	mov qword [rbp-48], r10
	mov r10, qword [rbp-48]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-32], rbx
	mov rdi, qword [rbp-32]
	call malloc 
	mov qword [rbp-24], rax
	mov rbx, qword [rbp-24]
	mov r10, qword [rbp-48]
	mov qword [rbx], r10
	l_1:
	mov rbx, qword [rbp-48]
	cmp rbx, 0
	jg l_2
	l_3:
	mov r10, qword [rbp-24]
	mov rbx, r10
	mov qword [g_1], rbx
	mov rbx, 0
	mov qword [g_0], rbx
	l_4:
	mov rbx, qword [rbp-80]
	mov r10, qword [g_0]
	cmp r10, rbx
	jl l_5
	l_6:
	l_7:
	mov rbx, qword [g_0]
	mov qword [g_0], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_2]
	mov qword [g_2], rbx
	leave 
	ret
	l_5:
	mov r10, qword [rbp-80]
	mov rbx, r10
	mov qword [rbp-8], rbx
	mov rbx, qword [rbp-8]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-56], r10
	mov rdi, qword [rbp-56]
	call malloc 
	mov qword [rbp-40], rax
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-40]
	mov qword [r10], rbx
	l_8:
	mov rbx, qword [rbp-8]
	cmp rbx, 0
	jg l_9
	l_10:
	mov rbx, qword [g_1]
	mov r10, qword [g_0]
	mov r11, qword [rbp-40]
	mov qword [rbx + r10 * 8 + 8], r11
	mov rbx, 0
	mov qword [g_2], rbx
	l_11:
	mov rbx, qword [g_2]
	mov r10, qword [rbp-80]
	cmp rbx, r10
	jl l_12
	l_13:
	l_14:
	mov rbx, qword [g_0]
	mov r10, rbx
	mov qword [rbp-64], r10
	mov rbx, qword [g_0]
	inc rbx
	mov qword [g_0], rbx
	jmp l_4
	l_12:
	mov rbx, qword [g_1]
	mov r11, qword [g_0]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-72], r10
	mov rbx, qword [g_2]
	mov r10, qword [rbp-72]
	mov qword [r10 + rbx * 8 + 8], 0
	l_15:
	mov rbx, qword [g_2]
	mov r10, rbx
	mov qword [rbp-16], r10
	mov rbx, qword [g_2]
	inc rbx
	mov qword [g_2], rbx
	jmp l_11
	l_9:
	mov rbx, qword [rbp-8]
	mov r10, qword [rbp-40]
	mov qword [r10 + rbx * 8], 0
	mov rbx, qword [rbp-8]
	dec rbx
	mov qword [rbp-8], rbx
	jmp l_8
	l_2:
	mov rbx, qword [rbp-24]
	mov r10, qword [rbp-48]
	mov qword [rbx + r10 * 8], 0
	mov rbx, qword [rbp-48]
	dec rbx
	mov qword [rbp-48], rbx
	jmp l_1
_search_User_Defined_fihriaifhiahidsafans:
	l_16:
	push rbp
	mov rbp, rsp
	sub rsp, 736
	mov qword [rbp-376], rdi
	mov qword [rbp-152], rsi
	mov qword [rbp-640], rdx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rbx, qword [rbp-152]
	cmp rbx, 0
	jle l_17
	l_18:
	mov rbx, qword [rbp-152]
	cmp rbx, 0
	jl l_17
	jmp l_19
	l_17:
	mov rbx, qword [rbp-376]
	cmp rbx, 0
	je l_19
	jmp l_20
	l_19:
	mov r10, qword [rbp-376]
	mov rbx, r10
	mov qword [rbp-40], rbx
	mov rbx, qword [rbp-40]
	sub rbx, 1
	mov qword [rbp-40], rbx
	mov rbx, qword [g_1]
	mov r10, qword [rbp-40]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-128], r11
	mov r10, qword [rbp-376]
	mov rbx, r10
	mov qword [rbp-496], rbx
	mov rbx, qword [rbp-496]
	sub rbx, 1
	mov qword [rbp-496], rbx
	mov rbx, qword [g_1]
	mov r10, qword [rbp-496]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-64], r11
	mov rbx, qword [rbp-128]
	mov r10, qword [rbx + 8]
	mov qword [rbp-696], r10
	mov rbx, qword [rbp-696]
	mov r10, qword [rbp-64]
	add rbx, qword [r10 + 16]
	mov qword [rbp-696], rbx
	mov r10, qword [rbp-376]
	mov rbx, r10
	mov qword [rbp-88], rbx
	mov rbx, qword [rbp-88]
	sub rbx, 1
	mov qword [rbp-88], rbx
	mov rbx, qword [g_1]
	mov r11, qword [rbp-88]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-592], r10
	mov r10, qword [rbp-696]
	mov rbx, r10
	mov qword [rbp-248], rbx
	mov rbx, qword [rbp-248]
	mov r10, qword [rbp-592]
	add rbx, qword [r10 + 24]
	mov qword [rbp-248], rbx
	mov rbx, qword [rbp-248]
	cmp rbx, 15
	je l_20
	jmp l_21
	l_20:
	mov rbx, qword [rbp-376]
	cmp rbx, 2
	jne l_22
	l_23:
	mov rbx, qword [rbp-152]
	cmp rbx, 2
	jne l_22
	jmp l_24
	l_22:
	mov rbx, qword [rbp-152]
	cmp rbx, 2
	je l_25
	l_26:
	mov rbx, 1
	mov qword [rbp-272], rbx
	l_27:
	mov rbx, qword [rbp-272]
	cmp rbx, 9
	jle l_28
	l_29:
	jmp l_30
	l_28:
	mov rbx, qword [g_3]
	mov r10, qword [rbp-272]
	cmp qword [rbx + r10 * 8 + 8], 0
	jne l_31
	l_32:
	mov rbx, qword [g_3]
	mov r10, qword [rbp-272]
	mov qword [rbx + r10 * 8 + 8], 1
	mov rbx, qword [g_1]
	mov r10, qword [rbp-376]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-24], r11
	mov rbx, qword [rbp-272]
	mov r10, qword [rbp-152]
	mov r11, qword [rbp-24]
	mov qword [r11 + r10 * 8 + 8], rbx
	mov rbx, qword [rbp-152]
	cmp rbx, 2
	je l_33
	l_34:
	mov r10, qword [rbp-152]
	mov rbx, r10
	mov qword [rbp-448], rbx
	mov rbx, qword [rbp-448]
	add rbx, 1
	mov qword [rbp-448], rbx
	mov r10, qword [rbp-640]
	mov rbx, r10
	mov qword [rbp-328], rbx
	mov rbx, qword [rbp-328]
	mov r10, qword [rbp-272]
	add rbx, r10
	mov qword [rbp-328], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rdx, qword [rbp-328]
	mov rsi, qword [rbp-448]
	mov rdi, qword [rbp-376]
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	call _search_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-688], rax
	jmp l_35
	l_33:
	mov r10, qword [rbp-376]
	mov rbx, r10
	mov qword [rbp-408], rbx
	mov rbx, qword [rbp-408]
	add rbx, 1
	mov qword [rbp-408], rbx
	mov r10, qword [rbp-640]
	mov rbx, r10
	mov qword [rbp-488], rbx
	mov rbx, qword [rbp-488]
	mov r10, qword [rbp-272]
	add rbx, r10
	mov qword [rbp-488], rbx
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rdx, qword [rbp-488]
	mov rsi, 0
	mov rdi, qword [rbp-408]
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	call _search_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-384], rax
	l_35:
	mov rbx, qword [g_1]
	mov r11, qword [rbp-376]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-512], r10
	mov rbx, qword [rbp-512]
	mov r10, qword [rbp-152]
	mov qword [rbx + r10 * 8 + 8], 0
	mov rbx, qword [g_3]
	mov r10, qword [rbp-272]
	mov qword [rbx + r10 * 8 + 8], 0
	l_31:
	l_36:
	mov rbx, qword [rbp-272]
	mov r10, rbx
	mov qword [rbp-112], r10
	mov rbx, qword [rbp-272]
	inc rbx
	mov qword [rbp-272], rbx
	jmp l_27
	l_25:
	mov rbx, qword [g_1]
	mov r11, qword [rbp-376]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-16], r10
	mov rbx, qword [g_1]
	mov r11, qword [rbp-376]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-144], r10
	mov rbx, 15
	mov qword [rbp-664], rbx
	mov rbx, qword [rbp-144]
	mov r10, qword [rbp-664]
	sub r10, qword [rbx + 8]
	mov qword [rbp-664], r10
	mov rbx, qword [g_1]
	mov r11, qword [rbp-376]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-56], r10
	mov r10, qword [rbp-664]
	mov rbx, r10
	mov qword [rbp-264], rbx
	mov rbx, qword [rbp-264]
	mov r10, qword [rbp-56]
	sub rbx, qword [r10 + 16]
	mov qword [rbp-264], rbx
	mov rbx, qword [rbp-264]
	mov r10, qword [rbp-16]
	mov r11, qword [rbp-152]
	mov qword [r10 + r11 * 8 + 8], rbx
	mov rbx, qword [g_1]
	mov r11, qword [rbp-376]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-32], r10
	mov rbx, qword [rbp-32]
	mov r10, qword [rbp-152]
	cmp qword [rbx + r10 * 8 + 8], 0
	jle l_37
	l_38:
	mov rbx, qword [g_1]
	mov r10, qword [rbp-376]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-736], r11
	mov rbx, qword [rbp-152]
	mov r10, qword [rbp-736]
	cmp qword [r10 + rbx * 8 + 8], 10
	jge l_37
	l_39:
	mov rbx, qword [g_1]
	mov r11, qword [rbp-376]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-120], r10
	mov rbx, qword [rbp-152]
	mov r10, qword [rbp-120]
	mov r11, qword [r10 + rbx * 8 + 8]
	mov qword [rbp-72], r11
	mov rbx, qword [g_3]
	mov r10, qword [rbp-72]
	cmp qword [rbx + r10 * 8 + 8], 0
	jne l_37
	l_40:
	mov rbx, qword [g_1]
	mov r11, qword [rbp-376]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-280], r10
	mov rbx, qword [rbp-280]
	mov r10, qword [rbp-152]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-352], r11
	mov rbx, qword [g_3]
	mov r10, qword [rbp-352]
	mov qword [rbx + r10 * 8 + 8], 1
	mov rbx, qword [rbp-152]
	cmp rbx, 2
	je l_41
	l_42:
	mov rbx, qword [rbp-152]
	mov r10, rbx
	mov qword [rbp-304], r10
	mov rbx, qword [rbp-304]
	add rbx, 1
	mov qword [rbp-304], rbx
	mov rbx, qword [g_1]
	mov r11, qword [rbp-376]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-368], r10
	mov rbx, qword [rbp-640]
	mov r10, rbx
	mov qword [rbp-480], r10
	mov rbx, qword [rbp-368]
	mov r10, qword [rbp-152]
	mov r11, qword [rbp-480]
	add r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-480], r11
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rdx, qword [rbp-480]
	mov rsi, qword [rbp-304]
	mov rdi, qword [rbp-376]
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	call _search_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-704], rax
	jmp l_43
	l_41:
	mov r10, qword [rbp-376]
	mov rbx, r10
	mov qword [rbp-672], rbx
	mov rbx, qword [rbp-672]
	add rbx, 1
	mov qword [rbp-672], rbx
	mov rbx, qword [g_1]
	mov r11, qword [rbp-376]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-464], r10
	mov rbx, qword [rbp-640]
	mov r10, rbx
	mov qword [rbp-544], r10
	mov rbx, qword [rbp-464]
	mov r10, qword [rbp-152]
	mov r11, qword [rbp-544]
	add r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-544], r11
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rdx, qword [rbp-544]
	mov rsi, 0
	mov rdi, qword [rbp-672]
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	call _search_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-360], rax
	l_43:
	mov rbx, qword [g_1]
	mov r11, qword [rbp-376]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-288], r10
	mov rbx, qword [rbp-288]
	mov r10, qword [rbp-152]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-504], r11
	mov rbx, qword [g_3]
	mov r10, qword [rbp-504]
	mov qword [rbx + r10 * 8 + 8], 0
	l_37:
	l_30:
	jmp l_44
	l_24:
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 24]
	mov qword [rbp-96], r10
	mov rbx, 45
	mov qword [rbp-392], rbx
	mov rbx, qword [rbp-640]
	mov r10, qword [rbp-392]
	sub r10, rbx
	mov qword [rbp-392], r10
	mov rbx, qword [rbp-392]
	mov r10, qword [rbp-96]
	mov qword [r10 + 24], rbx
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 8]
	mov qword [rbp-680], r10
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 8]
	mov qword [rbp-616], r10
	mov rbx, qword [rbp-680]
	mov r10, qword [rbx + 8]
	mov qword [rbp-240], r10
	mov rbx, qword [rbp-616]
	mov r10, qword [rbp-240]
	add r10, qword [rbx + 16]
	mov qword [rbp-240], r10
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 8]
	mov qword [rbp-200], r10
	mov r10, qword [rbp-240]
	mov rbx, r10
	mov qword [rbp-192], rbx
	mov rbx, qword [rbp-200]
	mov r10, qword [rbp-192]
	add r10, qword [rbx + 24]
	mov qword [rbp-192], r10
	mov rbx, qword [rbp-192]
	mov r10, rbx
	mov qword [rbp-224], r10
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 16]
	mov qword [rbp-520], r10
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 16]
	mov qword [rbp-560], r10
	mov r10, qword [rbp-520]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-320], rbx
	mov rbx, qword [rbp-320]
	mov r10, qword [rbp-560]
	add rbx, qword [r10 + 16]
	mov qword [rbp-320], rbx
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 16]
	mov qword [rbp-648], r10
	mov rbx, qword [rbp-320]
	mov r10, rbx
	mov qword [rbp-256], r10
	mov rbx, qword [rbp-256]
	mov r10, qword [rbp-648]
	add rbx, qword [r10 + 24]
	mov qword [rbp-256], rbx
	mov rbx, qword [rbp-256]
	mov r10, qword [rbp-224]
	cmp rbx, r10
	jne l_45
	l_46:
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 24]
	mov qword [rbp-8], r10
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 24]
	mov qword [rbp-728], r10
	mov rbx, qword [rbp-8]
	mov r10, qword [rbx + 8]
	mov qword [rbp-632], r10
	mov rbx, qword [rbp-728]
	mov r10, qword [rbp-632]
	add r10, qword [rbx + 16]
	mov qword [rbp-632], r10
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 24]
	mov qword [rbp-104], r10
	mov r10, qword [rbp-632]
	mov rbx, r10
	mov qword [rbp-176], rbx
	mov rbx, qword [rbp-176]
	mov r10, qword [rbp-104]
	add rbx, qword [r10 + 24]
	mov qword [rbp-176], rbx
	mov rbx, qword [rbp-176]
	mov r10, qword [rbp-224]
	cmp rbx, r10
	jne l_45
	l_47:
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 8]
	mov qword [rbp-216], r10
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 16]
	mov qword [rbp-80], r10
	mov r10, qword [rbp-216]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-168], rbx
	mov rbx, qword [rbp-168]
	mov r10, qword [rbp-80]
	add rbx, qword [r10 + 8]
	mov qword [rbp-168], rbx
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 24]
	mov qword [rbp-208], r10
	mov rbx, qword [rbp-168]
	mov r10, rbx
	mov qword [rbp-400], r10
	mov rbx, qword [rbp-208]
	mov r10, qword [rbp-400]
	add r10, qword [rbx + 8]
	mov qword [rbp-400], r10
	mov rbx, qword [rbp-400]
	mov r10, qword [rbp-224]
	cmp rbx, r10
	jne l_45
	l_48:
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 8]
	mov qword [rbp-232], r10
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 16]
	mov qword [rbp-608], r10
	mov r10, qword [rbp-232]
	mov rbx, qword [r10 + 16]
	mov qword [rbp-440], rbx
	mov rbx, qword [rbp-440]
	mov r10, qword [rbp-608]
	add rbx, qword [r10 + 16]
	mov qword [rbp-440], rbx
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 24]
	mov qword [rbp-584], r10
	mov rbx, qword [rbp-440]
	mov r10, rbx
	mov qword [rbp-184], r10
	mov rbx, qword [rbp-184]
	mov r10, qword [rbp-584]
	add rbx, qword [r10 + 16]
	mov qword [rbp-184], rbx
	mov rbx, qword [rbp-184]
	mov r10, qword [rbp-224]
	cmp rbx, r10
	jne l_45
	l_49:
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 8]
	mov qword [rbp-472], r10
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 16]
	mov qword [rbp-656], r10
	mov r10, qword [rbp-472]
	mov rbx, qword [r10 + 24]
	mov qword [rbp-336], rbx
	mov rbx, qword [rbp-336]
	mov r10, qword [rbp-656]
	add rbx, qword [r10 + 24]
	mov qword [rbp-336], rbx
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 24]
	mov qword [rbp-424], r10
	mov rbx, qword [rbp-336]
	mov r10, rbx
	mov qword [rbp-136], r10
	mov rbx, qword [rbp-136]
	mov r10, qword [rbp-424]
	add rbx, qword [r10 + 24]
	mov qword [rbp-136], rbx
	mov rbx, qword [rbp-136]
	mov r10, qword [rbp-224]
	cmp rbx, r10
	jne l_45
	l_50:
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 8]
	mov qword [rbp-416], r10
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 16]
	mov qword [rbp-568], r10
	mov r10, qword [rbp-416]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-720], rbx
	mov rbx, qword [rbp-568]
	mov r10, qword [rbp-720]
	add r10, qword [rbx + 16]
	mov qword [rbp-720], r10
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 24]
	mov qword [rbp-536], r10
	mov rbx, qword [rbp-720]
	mov r10, rbx
	mov qword [rbp-552], r10
	mov rbx, qword [rbp-536]
	mov r10, qword [rbp-552]
	add r10, qword [rbx + 24]
	mov qword [rbp-552], r10
	mov rbx, qword [rbp-552]
	mov r10, qword [rbp-224]
	cmp rbx, r10
	jne l_45
	l_51:
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 24]
	mov qword [rbp-712], r10
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 16]
	mov qword [rbp-160], r10
	mov r10, qword [rbp-712]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-624], rbx
	mov rbx, qword [rbp-160]
	mov r10, qword [rbp-624]
	add r10, qword [rbx + 16]
	mov qword [rbp-624], r10
	mov rbx, qword [g_1]
	mov r10, qword [rbx + 8]
	mov qword [rbp-600], r10
	mov r10, qword [rbp-624]
	mov rbx, r10
	mov qword [rbp-312], rbx
	mov rbx, qword [rbp-312]
	mov r10, qword [rbp-600]
	add rbx, qword [r10 + 24]
	mov qword [rbp-312], rbx
	mov rbx, qword [rbp-312]
	mov r10, qword [rbp-224]
	cmp rbx, r10
	jne l_45
	l_52:
	mov r10, qword [g_4]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-528], rbx
	mov rbx, qword [rbp-528]
	add rbx, 1
	mov qword [rbp-528], rbx
	mov rbx, qword [rbp-528]
	mov r10, qword [g_4]
	mov qword [r10 + 8], rbx
	mov rbx, 0
	mov qword [rbp-272], rbx
	l_53:
	mov rbx, qword [rbp-272]
	cmp rbx, 2
	jle l_54
	l_55:
	mov rdi, g_5
	call __print 
	l_45:
	l_44:
	l_21:
	mov rax, 0
	l_56:
	mov rbx, qword [g_1]
	mov qword [g_1], rbx
	mov rbx, qword [g_3]
	mov qword [g_3], rbx
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	leave 
	ret
	l_54:
	mov rbx, 0
	mov qword [rbp-344], rbx
	l_57:
	mov rbx, qword [rbp-344]
	cmp rbx, 2
	jle l_58
	l_59:
	mov rdi, g_6
	call __print 
	l_60:
	mov r10, qword [rbp-272]
	mov rbx, r10
	mov qword [rbp-576], rbx
	mov rbx, qword [rbp-272]
	inc rbx
	mov qword [rbp-272], rbx
	jmp l_53
	l_58:
	mov rbx, qword [g_1]
	mov r11, qword [rbp-272]
	mov r10, qword [rbx + r11 * 8 + 8]
	mov qword [rbp-48], r10
	mov rbx, qword [rbp-48]
	mov r10, qword [rbp-344]
	mov r11, qword [rbx + r10 * 8 + 8]
	mov qword [rbp-296], r11
	mov rdi, qword [rbp-296]
	call __toString 
	mov qword [rbp-432], rax
	mov rdi, qword [rbp-432]
	call __print 
	mov rdi, g_7
	call __print 
	l_61:
	mov r10, qword [rbp-344]
	mov rbx, r10
	mov qword [rbp-456], rbx
	mov rbx, qword [rbp-344]
	inc rbx
	mov qword [rbp-344], rbx
	jmp l_57
_main_User_Defined_fihriaifhiahidsafans:
	l_62:
	push rbp
	mov rbp, rsp
	sub rsp, 32
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rbx, qword [g_4]
	mov qword [rbx + 8], 0
	mov rdi, 3
	call _origin_User_Defined_fihriaifhiahidsafans 
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	mov rdx, 0
	mov rsi, 0
	mov rdi, 0
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	call _search_User_Defined_fihriaifhiahidsafans 
	mov qword [rbp-8], rax
	mov r10, qword [g_4]
	mov rbx, qword [r10 + 8]
	mov qword [rbp-24], rbx
	mov rdi, qword [rbp-24]
	call __toString 
	mov qword [rbp-16], rax
	mov rdi, qword [rbp-16]
	call __println 
	mov rax, 0
	l_63:
	mov rbx, qword [g_4]
	mov qword [g_4], rbx
	leave 
	ret
__init:
	l_64:
	push rbp
	mov rbp, rsp
	sub rsp, 48
	mov rbx, 10
	mov qword [rbp-16], rbx
	mov rbx, qword [rbp-16]
	lea r10, [rbx * 8 + 8]
	mov qword [rbp-24], r10
	mov rdi, qword [rbp-24]
	call malloc 
	mov qword [rbp-48], rax
	mov rbx, qword [rbp-16]
	mov r10, qword [rbp-48]
	mov qword [r10], rbx
	l_65:
	mov rbx, qword [rbp-16]
	cmp rbx, 0
	jg l_66
	l_67:
	mov r10, qword [rbp-48]
	mov rbx, r10
	mov qword [g_3], rbx
	mov rbx, 1
	mov qword [rbp-8], rbx
	mov r10, qword [rbp-8]
	lea rbx, [r10 * 8 + 8]
	mov qword [rbp-40], rbx
	mov rdi, qword [rbp-40]
	call malloc 
	mov qword [rbp-32], rax
	mov rbx, qword [rbp-32]
	mov r10, qword [rbp-8]
	mov qword [rbx], r10
	l_68:
	mov rbx, qword [rbp-8]
	cmp rbx, 0
	jg l_69
	l_70:
	mov rbx, qword [rbp-32]
	mov r10, rbx
	mov qword [g_4], r10
	call _main_User_Defined_fihriaifhiahidsafans 
	leave 
	ret
	l_69:
	mov rbx, qword [rbp-32]
	mov r10, qword [rbp-8]
	mov qword [rbx + r10 * 8], 0
	mov rbx, qword [rbp-8]
	dec rbx
	mov qword [rbp-8], rbx
	jmp l_68
	l_66:
	mov rbx, qword [rbp-16]
	mov r10, qword [rbp-48]
	mov qword [r10 + rbx * 8], 0
	mov rbx, qword [rbp-16]
	dec rbx
	mov qword [rbp-16], rbx
	jmp l_65
	 section .data
g_1:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_3:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_4:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_0:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_2:
	db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
g_7:
	dq 1
	db 20H, 00H
g_6:
	dq 1
	db 0AH, 00H
g_5:
	dq 1
	db 0AH, 00H

