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
    jmp fun_finish_bruh_1
    fun_start_bruh_1:
        push rbp
    mov rbp, rsp
    sub rsp, 8*1
    fun_body_bruh_1:
        
        mov rax, 6
    fun_exit_bruh_1:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_bruh_1:
        lea rcx, QWORD [rel fun_start_bruh_1]
    mov [r12 + 8*0], rcx
mov rcx, 0
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*2], rax
jmp fun_finish_anon_2_3
    fun_start_anon_2_3:
        push rbp
    mov rbp, rsp
    sub rsp, 8*1
    fun_body_anon_2_3:
        
        mov rax, 16
    fun_exit_anon_2_3:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_anon_2_3:
        lea rcx, QWORD [rel fun_start_anon_2_3]
    mov [r12 + 8*0], rcx
mov rcx, 0
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*3], rax

  
    
    mov rax, [rbp - 8*3]
    mov rcx, rax
    and rcx, 5
    cmp rcx, 5
    mov rdi, 299
    jne label_error

    mov rcx, rax
    sub rcx, 5
    mov rcx, [rcx+8]
    cmp rcx, 0
    mov rdi, 199
    jne label_error

    push rax
    sub rax, 5
    call [rax]
    add rsp, 8*0

        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*4], rax
        
    
    mov rax, [rbp - 8*2]
    mov rcx, rax
    and rcx, 5
    cmp rcx, 5
    mov rdi, 299
    jne label_error

    mov rcx, rax
    sub rcx, 5
    mov rcx, [rcx+8]
    cmp rcx, 0
    mov rdi, 199
    jne label_error

    push rax
    sub rax, 5
    call [rax]
    add rsp, 8*0

        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        
        add rax, [rbp - 8*4]
        
  mov rdi, 499
    jo label_error

    mov rsp, rbp
    pop rbp
    ret
time_to_exit:
    ret
