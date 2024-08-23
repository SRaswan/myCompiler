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
    sub rsp, 8*6
    mov [rbp - 8], rdi
    mov r12, rsi 
    jmp fun_finish_anon_1_4
    fun_start_anon_1_4:
        push rbp
    mov rbp, rsp
    sub rsp, 8*2
    fun_body_anon_1_4:
        
        jmp fun_finish_anon_2_3
    fun_start_anon_2_3:
        push rbp
    mov rbp, rsp
    sub rsp, 8*4
    fun_body_anon_2_3:
        mov rax, [rbp+16]
        mov rcx, rax
    and rcx, 5
    cmp rcx, 5
    mov rdi, 299
    jne label_error

    sub rax, 5             ; strip tag
    mov rax, [rax + 8*2] ; read at index
        mov [rbp - 8*1], rax
        
  mov rax, [rbp - 8*-3]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*2], rax
        mov rax, [rbp - 8*1]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        
        add rax, [rbp - 8*2]
        
  mov rdi, 499
    jo label_error

    fun_exit_anon_2_3:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_anon_2_3:
        lea rcx, QWORD [rel fun_start_anon_2_3]
    mov [r12 + 8*0], rcx
mov rcx, 1
    mov [r12 + 8*1], rcx
mov rcx, [rbp - 8*18446744073709551613]
    mov [r12 + 8*2], rcx
mov rax, r12
    add r12, 8*3
        add rax, 5

    fun_exit_anon_1_4:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_anon_1_4:
        lea rcx, QWORD [rel fun_start_anon_1_4]
    mov [r12 + 8*0], rcx
mov rcx, 1
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*2], rax
jmp fun_finish_anon_5_6
    fun_start_anon_5_6:
        push rbp
    mov rbp, rsp
    sub rsp, 8*2
    fun_body_anon_5_6:
        
        mov rax, 10
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

    fun_exit_anon_5_6:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_anon_5_6:
        lea rcx, QWORD [rel fun_start_anon_5_6]
    mov [r12 + 8*0], rcx
mov rcx, 1
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*3], rax
mov rax, 2
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

mov [rbp - 8*4], rax
mov rax, 20
    mov [rbp - 8*5], rax
    mov rcx, [rbp - 8*5]
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

mov [rbp - 8*5], rax
mov rax, [rbp - 8*4]
    mov [rbp - 8*6], rax
    mov rcx, [rbp - 8*6]
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
    cmp rcx, 1
    mov rdi, 199
    jne label_error

    push rax
    sub rax, 5
    call [rax]
    add rsp, 8*1

    mov [rbp - 8*6], rax
mov rax, [rbp - 8*5]
    mov [rbp - 8*7], rax
    mov rcx, [rbp - 8*7]
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
    cmp rcx, 1
    mov rdi, 199
    jne label_error

    push rax
    sub rax, 5
    call [rax]
    add rsp, 8*1

    mov [rbp - 8*7], rax
    mov rcx, [rbp - 8*6]
    mov [r12 + 8*0], rcx
mov rcx, [rbp - 8*7]
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
    add rax, 0x1
    mov rsp, rbp
    pop rbp
    ret
time_to_exit:
    ret
