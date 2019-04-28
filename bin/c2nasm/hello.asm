





default rel

global main


SECTION .text   

main:
        push    rbp
        mov     rbp, rsp
        mov     dword [rbp-0CH], 5
        mov     eax, dword [rbp-0CH]
        lea     edx, [rax+1H]
        mov     dword [rbp-0CH], edx
        mov     dword [rbp-8H], eax
        mov     eax, dword [rbp-8H]
        mov     dword [rbp-4H], eax
        mov     edx, dword [rbp-4H]
        mov     eax, dword [rbp-8H]
        add     edx, eax
        mov     eax, dword [rbp-0CH]
        add     eax, edx
        pop     rbp
        ret



SECTION .data   


SECTION .bss    


