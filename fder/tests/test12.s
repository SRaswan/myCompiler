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
    sub rsp, 8*5
    mov [rbp - 8], rdi
    mov r12, rsi 
    jmp fun_finish_hi_1
    fun_start_hi_1:
        push rbp
    mov rbp, rsp
    sub rsp, 8*2
    fun_body_hi_1:
        
        mov rax, 6
    mov [rbp - 8*1], rax
    mov rcx, [rbp - 8*1]
    push rcx
    mov rax, [rbp - 8*-3]
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

    fun_exit_hi_1:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_hi_1:
        lea rcx, QWORD [rel fun_start_hi_1]
    mov [r12 + 8*0], rcx
mov rcx, 1
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*2], rax
jmp fun_finish_big_3
    fun_start_big_3:
        push rbp
    mov rbp, rsp
    sub rsp, 8*1
    fun_body_big_3:
        
        loop_start_2:
    mov rax, 6
    jmp loop_exit_2
    jmp loop_start_2
loop_exit_2:
    fun_exit_big_3:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_big_3:
        lea rcx, QWORD [rel fun_start_big_3]
    mov [r12 + 8*0], rcx
mov rcx, 3
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*3], rax
mov rax, 6
    mov [rbp - 8*4], rax
mov rax, 4
    mov [rbp - 8*5], rax
mov rax, 4
    mov [rbp - 8*6], rax
    mov rcx, [rbp - 8*6]
    push rcx
mov rcx, [rbp - 8*5]
    push rcx
mov rcx, [rbp - 8*4]
    push rcx
    mov rax, [rbp - 8*3]
    mov rcx, rax
    and rcx, 5
    cmp rcx, 5
    mov rdi, 299
    jne label_error

    mov rcx, rax
    sub rcx, 5
    mov rcx, [rcx+8]
    cmp rcx, 3
    mov rdi, 199
    jne label_error

    push rax
    sub rax, 5
    call [rax]
    add rsp, 8*3

    mov [rbp - 8*4], rax
    mov rcx, [rbp - 8*4]
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
