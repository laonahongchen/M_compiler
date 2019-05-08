





default rel

global main

extern __stack_chk_fail
extern __printf_chk
extern __isoc99_scanf
extern _GLOBAL_OFFSET_TABLE_


SECTION .text   

main:
        sub     rsp, 24


        mov     rax, qword [fs:abs 28H]
        mov     qword [rsp+8H], rax
        xor     eax, eax
        lea     rdx, [rsp+4H]
        mov     rsi, rsp
        lea     rdi, [rel .LC0]
        call    __isoc99_scanf
        mov     eax, dword [rsp+4H]
        cmp     dword [rsp], eax
        setg    dl
        movzx   edx, dl
        lea     rsi, [rel .LC1]
        mov     edi, 1
        mov     eax, 0
        call    __printf_chk
        mov     rcx, qword [rsp+8H]


        xor     rcx, qword [fs:abs 28H]
        jnz     L_001
        mov     eax, 0
        add     rsp, 24
        ret


L_001:

        call    __stack_chk_fail


SECTION .data   


SECTION .bss    


SECTION .rodata.str1.1 

.LC0:
        db 25H, 64H, 25H, 64H, 00H

.LC1:
        db 25H, 64H, 0AH, 00H


