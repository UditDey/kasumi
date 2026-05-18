[BITS 64]
org 0x400000

.1:
    mov rcx, 400000000
.2:
    dec rcx
    jnz .2

    mov rax, 0
    mov rdi, msg
    syscall

    jmp .1

msg: db `Hello from userspace!\n`, 0
