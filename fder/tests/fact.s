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
    jmp fun_finish_fact_4
    fun_start_fact_4:
        push rbp
    mov rbp, rsp
    sub rsp, 8*5
    fun_body_fact_4:
        
        mov rax, 2
mov [rbp - 8*1], rax
mov rax, 2
mov [rbp - 8*2], rax
loop_start_1:
    
  mov rax, [rbp - 8*-3]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*3], rax
        mov rax, [rbp - 8*1]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        cmp rax, [rbp - 8*3]
        mov rax, 7
        jle eq_exit_2
        mov rax, 3
      eq_exit_2:

    cmp rax, 3
    je label_else_3
    
  mov rax, [rbp - 8*1]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*3], rax
        mov rax, [rbp - 8*2]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        sar rax, 1
        imul rax, [rbp - 8*3]
        
  mov rdi, 499
    jo label_error

    mov [rbp - 8*2], rax


  mov rax, 2
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*3], rax
        mov rax, [rbp - 8*1]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        
        add rax, [rbp - 8*3]
        
  mov rdi, 499
    jo label_error

    mov [rbp - 8*1], rax

    jmp label_exit_3
label_else_3:
    mov rax, [rbp - 8*2]
    jmp loop_exit_1
label_exit_3:

    jmp loop_start_1
loop_exit_1:
    fun_exit_fact_4:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_fact_4:
        lea rcx, QWORD [rel fun_start_fact_4]
    mov [r12 + 8*0], rcx
mov rcx, 1
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*2], rax
mov rax, [rbp - 8]
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
