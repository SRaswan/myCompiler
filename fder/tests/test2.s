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
    sub rsp, 8*9
    mov [rbp - 8], rdi
    mov r12, rsi 
    jmp fun_finish_A_1
    fun_start_A_1:
        push rbp
    mov rbp, rsp
    sub rsp, 8*6
    fun_body_A_1:
        
        
  
  mov rax, [rbp - 8*-5]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*1], rax
        mov rax, [rbp - 8*-4]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        
        add rax, [rbp - 8*1]
        
  mov rdi, 499
    jo label_error

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

    fun_exit_A_1:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_A_1:
        lea rcx, QWORD [rel fun_start_A_1]
    mov [r12 + 8*0], rcx
mov rcx, 3
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*2], rax
jmp fun_finish_B_2
    fun_start_B_2:
        push rbp
    mov rbp, rsp
    sub rsp, 8*7
    fun_body_B_2:
        mov rax, [rbp+16]
        mov rcx, rax
    and rcx, 5
    cmp rcx, 5
    mov rdi, 299
    jne label_error

    sub rax, 5             ; strip tag
    mov rax, [rax + 8*2] ; read at index
        mov [rbp - 8*1], rax
        
  
  mov rax, [rbp - 8*-5]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*2], rax
        mov rax, 6
    mov [rbp - 8*3], rax
mov rax, 2
    mov [rbp - 8*4], rax
mov rax, 4
    mov [rbp - 8*5], rax
    mov rcx, [rbp - 8*5]
    push rcx
mov rcx, [rbp - 8*4]
    push rcx
mov rcx, [rbp - 8*3]
    push rcx
    mov rax, [rbp - 8*1]
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

        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        
        add rax, [rbp - 8*2]
        
  mov rdi, 499
    jo label_error

        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*2], rax
        mov rax, [rbp - 8*-3]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        
        add rax, [rbp - 8*2]
        
  mov rdi, 499
    jo label_error

    fun_exit_B_2:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_B_2:
        lea rcx, QWORD [rel fun_start_B_2]
    mov [r12 + 8*0], rcx
mov rcx, 4
    mov [r12 + 8*1], rcx
mov rcx, [rbp - 8*2]
    mov [r12 + 8*2], rcx
mov rax, r12
    add r12, 8*3
        add rax, 5

mov [rbp - 8*3], rax
jmp fun_finish_C_3
    fun_start_C_3:
        push rbp
    mov rbp, rsp
    sub rsp, 8*9
    fun_body_C_3:
        mov rax, [rbp+16]
        mov rcx, rax
    and rcx, 5
    cmp rcx, 5
    mov rdi, 299
    jne label_error

    sub rax, 5             ; strip tag
    mov rax, [rax + 8*2] ; read at index
        mov [rbp - 8*1], rax
        mov rax, 0
mov [rbp - 8*2], rax

  
  mov rax, [rbp - 8*-5]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*3], rax
        mov rax, [rbp - 8*-4]
    mov [rbp - 8*4], rax
mov rax, 2
    mov [rbp - 8*5], rax
mov rax, 4
    mov [rbp - 8*6], rax
mov rax, 8
    mov [rbp - 8*7], rax
    mov rcx, [rbp - 8*7]
    push rcx
mov rcx, [rbp - 8*6]
    push rcx
mov rcx, [rbp - 8*5]
    push rcx
mov rcx, [rbp - 8*4]
    push rcx
    mov rax, [rbp - 8*1]
    mov rcx, rax
    and rcx, 5
    cmp rcx, 5
    mov rdi, 299
    jne label_error

    mov rcx, rax
    sub rcx, 5
    mov rcx, [rcx+8]
    cmp rcx, 4
    mov rdi, 199
    jne label_error

    push rax
    sub rax, 5
    call [rax]
    add rsp, 8*4

        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        
        add rax, [rbp - 8*3]
        
  mov rdi, 499
    jo label_error

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

    fun_exit_C_3:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_C_3:
        lea rcx, QWORD [rel fun_start_C_3]
    mov [r12 + 8*0], rcx
mov rcx, 5
    mov [r12 + 8*1], rcx
mov rcx, [rbp - 8*3]
    mov [r12 + 8*2], rcx
mov rax, r12
    add r12, 8*3
        add rax, 5

mov [rbp - 8*4], rax
mov rax, 2
mov [rbp - 8*5], rax
mov rax, [rbp - 8*5]
    mov [rbp - 8*6], rax
mov rax, 4
    mov [rbp - 8*7], rax
mov rax, 6
    mov [rbp - 8*8], rax
mov rax, 8
    mov [rbp - 8*9], rax
mov rax, 10
    mov [rbp - 8*10], rax
    mov rcx, [rbp - 8*10]
    push rcx
mov rcx, [rbp - 8*9]
    push rcx
mov rcx, [rbp - 8*8]
    push rcx
mov rcx, [rbp - 8*7]
    push rcx
mov rcx, [rbp - 8*6]
    push rcx
    mov rax, [rbp - 8*4]
    mov rcx, rax
    and rcx, 5
    cmp rcx, 5
    mov rdi, 299
    jne label_error

    mov rcx, rax
    sub rcx, 5
    mov rcx, [rcx+8]
    cmp rcx, 5
    mov rdi, 199
    jne label_error

    push rax
    sub rax, 5
    call [rax]
    add rsp, 8*5

    mov rsp, rbp
    pop rbp
    ret
time_to_exit:
    ret
