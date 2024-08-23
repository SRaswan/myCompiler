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
    jmp fun_finish_fun1_3
    fun_start_fun1_3:
        push rbp
    mov rbp, rsp
    sub rsp, 8*4
    fun_body_fun1_3:
        
        
  mov rax, 0
        mov [rbp - 8*1], rax
        mov rax, [rbp - 8*-3]
        mov rdx, rax
        and rdx, 1
        mov rcx, [rbp - 8*1]
        and rcx, 1
        xor rcx, rdx
        mov rdi, 599
        jnz label_error
        cmp rax, [rbp - 8*1]
        mov rax, 3
        jne eq_exit_1
        mov rax, 7
      eq_exit_1:

    cmp rax, 3
    je label_else_2
    mov rax, 8
    mov [rbp - 8*1], rax
    mov rcx, [rbp - 8*1]
    push rcx
    mov rax, [rbp - 8*-2]
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

    jmp label_exit_2
label_else_2:
    mov rax, 0
label_exit_2:

    fun_exit_fun1_3:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_fun1_3:
        lea rcx, QWORD [rel fun_start_fun1_3]
    mov [r12 + 8*0], rcx
mov rcx, 1
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*2], rax
mov rax, 0
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
