





default rel

global tak
global main


SECTION .text   

tak:
        push    rbp
        mov     rbp, rsp
        push    r12
        push    rbx
        sub     rsp, 16
        mov     dword [rbp-14H], edi
        mov     dword [rbp-18H], esi
        mov     dword [rbp-1CH], edx
        mov     eax, dword [rbp-18H]
        cmp     eax, dword [rbp-14H]
        jge     L_001
        mov     eax, dword [rbp-1CH]
        lea     ecx, [rax-1H]
        mov     edx, dword [rbp-18H]
        mov     eax, dword [rbp-14H]
        mov     esi, eax
        mov     edi, ecx
        call    tak
        mov     r12d, eax
        mov     eax, dword [rbp-18H]
        lea     ecx, [rax-1H]
        mov     edx, dword [rbp-14H]
        mov     eax, dword [rbp-1CH]
        mov     esi, eax
        mov     edi, ecx
        call    tak
        mov     ebx, eax
        mov     eax, dword [rbp-14H]
        lea     ecx, [rax-1H]
        mov     edx, dword [rbp-1CH]
        mov     eax, dword [rbp-18H]
        mov     esi, eax
        mov     edi, ecx
        call    tak
        mov     edx, r12d
        mov     esi, ebx
        mov     edi, eax
        call    tak
        add     eax, 1
        jmp     L_002

L_001:  mov     eax, dword [rbp-1CH]
L_002:  add     rsp, 16
        pop     rbx
        pop     r12
        pop     rbp
        ret


main:
        push    rbp
        mov     rbp, rsp
        mov     edx, 6
        mov     esi, 12
        mov     edi, 18
        call    tak
        pop     rbp
        ret



SECTION .data   


SECTION .bss    


