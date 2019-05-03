





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
extern strtol
extern strncpy
extern __sprintf_chk
extern __stack_chk_fail
extern memcpy
extern malloc
extern __isoc99_scanf
extern puts
extern __printf_chk
extern _GLOBAL_OFFSET_TABLE_


SECTION .text   6

__print:
        lea     rdx, [rdi+8H]
        lea     rsi, [rel .LC0]
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
        lea     rsi, [rel __buffer.3342]
        lea     rdi, [rel .LC0]
        xor     eax, eax
        sub     rsp, 8
        call    __isoc99_scanf
        lea     rcx, [rel __buffer.3342]
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
        lea     rsi, [rel __buffer.3342]
        mov     qword [rbp], rax
        call    memcpy
        add     rsp, 8
        mov     rax, rbp
        pop     rbx
        pop     rbp
        ret


__getInt:
        sub     rsp, 24
        lea     rdi, [rel .LC1]


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


L_002:
        call    __stack_chk_fail





ALIGN   16

__toString:
        push    rbp
        push    rbx
        mov     rbp, rdi
        mov     edi, 32
        sub     rsp, 8
        call    malloc
        lea     rcx, [rel .LC1]
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
        push    r13
        push    r12
        mov     r13, rdi
        push    rbp
        movsxd  rbp, esi
        push    rbx
        sub     edx, ebp
        lea     ebx, [rdx+1H]
        add     edx, 10
        sub     rsp, 8
        movsxd  rdi, edx
        call    malloc
        movsxd  rdx, ebx
        lea     rsi, [r13+rbp+8H]
        lea     rdi, [rax+8H]
        mov     qword [rax], rdx
        mov     r12, rax
        call    strncpy
        add     rsp, 8
        mov     rax, r12
        pop     rbx
        pop     rbp
        pop     r12
        pop     r13
        ret


        nop





ALIGN   16

__string_parseInt:
        sub     rsp, 8
        add     rdi, 8
        mov     edx, 10
        xor     esi, esi
        call    strtol
        add     rsp, 8
        cdqe
        ret






ALIGN   8

__string_ord:
        movsx   rax, byte [rdi+rsi+8H]
        ret







ALIGN   16

__stringConcat:
        push    r14
        push    r13
        push    r12
        push    rbp
        mov     r12, rdi
        push    rbx
        mov     r13, qword [rdi]
        mov     rbp, rsi
        mov     rbx, qword [rsi]
        lea     r14, [r13+rbx]
        lea     rdi, [r14+9H]
        call    malloc
        test    r13, r13
        mov     qword [rax], r14
        lea     rsi, [r13+8H]
        mov     edx, 8
        jle     L_004




ALIGN   8
L_003:  movzx   ecx, byte [r12+rdx]
        mov     byte [rax+rdx], cl
        add     rdx, 1
        cmp     rsi, rdx
        jnz     L_003
L_004:  test    rbx, rbx
        jle     L_006
        lea     rdi, [rax+r13]
        xor     edx, edx




ALIGN   8
L_005:  movzx   ecx, byte [rbp+rdx+8H]
        mov     byte [rdi+rdx+8H], cl
        add     rdx, 1
        cmp     rdx, rbx
        jnz     L_005
L_006:  add     rbx, rax
        mov     byte [rbx+rsi], 0
        pop     rbx
        pop     rbp
        pop     r12
        pop     r13
        pop     r14
        ret






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

__buffer.3342:
        resb    1048576


SECTION .text.startup 6

main:
        xor     eax, eax
        jmp     __init



SECTION .rodata.str1.1 

.LC0:
        db 25H, 73H, 00H

.LC1:
        db 25H, 6CH, 64H, 00H


