section .text
global our_code_starts_here
extern snek_error
extern snek_print
label_error:
    push rsp
    call snek_error
our_code_starts_here:
    push rbp
    mov rbp, rsp
    sub rsp, 8*2
    mov [rbp - 8], rdi
    mov r12, rsi 
    mov rax, 20
mov [rbp - 8*2], rax
mov rax, 184
    mov [rbp - 8*3], rax
    mov rcx, [rbp - 8*3]
    push rcx
    mov rax, [rbp - 8*2]
    mov rcx, rax
    and rcx, 5
    cmp rcx, 5
    mov rdi, 299
    jne label_error

    mov rcx, rax
    sub rcx, 5
    mov rcx, [rcx+8]
    cmp rcx, 1
    mov rdi, 199
    jne label_error

    push rax
    sub rax, 5
    call [rax]
    add rsp, 8*1

    mov rsp, rbp
    pop rbp
    ret
time_to_exit:
    ret
