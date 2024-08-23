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
    sub rsp, 8*4
    mov [rbp - 8], rdi
    mov r12, rsi 
    jmp fun_finish_f_1
    fun_start_f_1:
        push rbp
    mov rbp, rsp
    sub rsp, 8*3
    fun_body_f_1:
        
        mov rax, [rbp - 8*-4]
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

    fun_exit_f_1:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_f_1:
        lea rcx, QWORD [rel fun_start_f_1]
    mov [r12 + 8*0], rcx
mov rcx, 2
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*2], rax
jmp fun_finish_fac_4
    fun_start_fac_4:
        push rbp
    mov rbp, rsp
    sub rsp, 8*5
    fun_body_fac_4:
        
        
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
        jne eq_exit_2
        mov rax, 7
      eq_exit_2:

    cmp rax, 3
    je label_else_3
    mov rax, 2
    jmp label_exit_3
label_else_3:
    
  
  mov rax, -2
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*1], rax
        mov rax, [rbp - 8*-3]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        
        add rax, [rbp - 8*1]
        
  mov rdi, 499
    jo label_error

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

        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*1], rax
        mov rax, [rbp - 8*-3]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        sar rax, 1
        imul rax, [rbp - 8*1]
        
  mov rdi, 499
    jo label_error

label_exit_3:

    fun_exit_fac_4:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_fac_4:
        lea rcx, QWORD [rel fun_start_fac_4]
    mov [r12 + 8*0], rcx
mov rcx, 1
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*3], rax
mov rax, [rbp - 8*3]
    mov [rbp - 8*4], rax
mov rax, [rbp - 8]
    mov [rbp - 8*5], rax
    mov rcx, [rbp - 8*5]
    push rcx
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
    cmp rcx, 2
    mov rdi, 199
    jne label_error

    push rax
    sub rax, 5
    call [rax]
    add rsp, 8*2

    mov rsp, rbp
    pop rbp
    ret
time_to_exit:
    ret
