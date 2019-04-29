





default rel

global s3
global s2
global s1
global main

extern puts
extern strcat
extern memcpy
extern _GLOBAL_OFFSET_TABLE_


SECTION .text   

main:
        push    rbp
        mov     rbp, rsp
        mov     edx, 5
        lea     rsi, [rel L_001]
        lea     rdi, [rel s1]
        call    memcpy
        mov     edx, 5
        lea     rsi, [rel L_002]
        lea     rdi, [rel s2]
        call    memcpy
        lea     rsi, [rel s2]
        lea     rdi, [rel s1]
        call    strcat
        lea     rdi, [rel s1]
        call    puts
        mov     eax, 0
        pop     rbp
        ret



SECTION .data   


SECTION .bss    


SECTION .rodata 

L_001:
        db 68H, 65H, 6CH, 6CH, 6FH, 00H

L_002:
        db 77H, 6FH, 72H, 6CH, 64H, 00H


