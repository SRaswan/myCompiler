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
    jmp fun_finish_head_1
    fun_start_head_1:
        push rbp
    mov rbp, rsp
    sub rsp, 8*2
    fun_body_head_1:
        
        mov rax, [rbp - 8*-3]
    mov rcx, rax
    and rcx, 5
    cmp rcx, 1
    mov rdi, 399
    jne label_error

    sub rax, 1             ; strip tag
    mov rax, [rax + 8*0] ; read at index
    fun_exit_head_1:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_head_1:
        lea rcx, QWORD [rel fun_start_head_1]
    mov [r12 + 8*0], rcx
mov rcx, 1
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*2], rax
jmp fun_finish_tail_2
    fun_start_tail_2:
        push rbp
    mov rbp, rsp
    sub rsp, 8*2
    fun_body_tail_2:
        
        mov rax, [rbp - 8*-3]
    mov rcx, rax
    and rcx, 5
    cmp rcx, 1
    mov rdi, 399
    jne label_error

    sub rax, 1             ; strip tag
    mov rax, [rax + 8*1] ; read at index
    fun_exit_tail_2:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_tail_2:
        lea rcx, QWORD [rel fun_start_tail_2]
    mov [r12 + 8*0], rcx
mov rcx, 1
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*3], rax
jmp fun_finish_emp_4
    fun_start_emp_4:
        push rbp
    mov rbp, rsp
    sub rsp, 8*3
    fun_body_emp_4:
        
        
  
mov rax, 3

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
        jne eq_exit_3
        mov rax, 7
      eq_exit_3:

    fun_exit_emp_4:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_emp_4:
        lea rcx, QWORD [rel fun_start_emp_4]
    mov [r12 + 8*0], rcx
mov rcx, 1
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*4], rax
jmp fun_finish_range_7
    fun_start_range_7:
        push rbp
    mov rbp, rsp
    sub rsp, 8*6
    fun_body_range_7:
        
        
  mov rax, [rbp - 8*-4]
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
        jne eq_exit_5
        mov rax, 7
      eq_exit_5:

    cmp rax, 3
    je label_else_6
    
mov rax, 3

    jmp label_exit_6
label_else_6:
    mov rax, [rbp - 8*-3]
    mov [rbp - 8*1], rax

  mov rax, 2
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

    mov [rbp - 8*2], rax
mov rax, [rbp - 8*-4]
    mov [rbp - 8*3], rax
    mov rcx, [rbp - 8*3]
    push rcx
mov rcx, [rbp - 8*2]
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
    cmp rcx, 2
    mov rdi, 199
    jne label_error

    push rax
    sub rax, 5
    call [rax]
    add rsp, 8*2

    mov [rbp - 8*2], rax
    mov rcx, [rbp - 8*1]
    mov [r12 + 8*0], rcx
mov rcx, [rbp - 8*2]
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
    add rax, 0x1
label_exit_6:

    fun_exit_range_7:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_range_7:
        lea rcx, QWORD [rel fun_start_range_7]
    mov [r12 + 8*0], rcx
mov rcx, 2
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*5], rax
jmp fun_finish_fold_9
    fun_start_fold_9:
        push rbp
    mov rbp, rsp
    sub rsp, 8*10
    fun_body_fold_9:
        mov rax, [rbp+16]
        mov rcx, rax
    and rcx, 5
    cmp rcx, 5
    mov rdi, 299
    jne label_error

    sub rax, 5             ; strip tag
    mov rax, [rax + 8*2] ; read at index
        mov [rbp - 8*1], rax
mov rax, [rbp+16]
        mov rcx, rax
    and rcx, 5
    cmp rcx, 5
    mov rdi, 299
    jne label_error

    sub rax, 5             ; strip tag
    mov rax, [rax + 8*3] ; read at index
        mov [rbp - 8*2], rax
mov rax, [rbp+16]
        mov rcx, rax
    and rcx, 5
    cmp rcx, 5
    mov rdi, 299
    jne label_error

    sub rax, 5             ; strip tag
    mov rax, [rax + 8*4] ; read at index
        mov [rbp - 8*3], rax
        mov rax, [rbp - 8*-5]
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

    cmp rax, 3
    je label_else_8
    mov rax, [rbp - 8*-4]
    jmp label_exit_8
label_else_8:
    mov rax, [rbp - 8*-3]
    mov [rbp - 8*4], rax
mov rax, [rbp - 8*-4]
    mov [rbp - 8*5], rax
mov rax, [rbp - 8*-5]
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
    mov rcx, [rbp - 8*6]
    push rcx
mov rcx, [rbp - 8*5]
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
    cmp rcx, 2
    mov rdi, 199
    jne label_error

    push rax
    sub rax, 5
    call [rax]
    add rsp, 8*2

    mov [rbp - 8*5], rax
mov rax, [rbp - 8*-5]
    mov [rbp - 8*6], rax
    mov rcx, [rbp - 8*6]
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
    cmp rcx, 1
    mov rdi, 199
    jne label_error

    push rax
    sub rax, 5
    call [rax]
    add rsp, 8*1

    mov [rbp - 8*6], rax
    mov rcx, [rbp - 8*6]
    push rcx
mov rcx, [rbp - 8*5]
    push rcx
mov rcx, [rbp - 8*4]
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
    cmp rcx, 3
    mov rdi, 199
    jne label_error

    push rax
    sub rax, 5
    call [rax]
    add rsp, 8*3

label_exit_8:

    fun_exit_fold_9:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_fold_9:
        lea rcx, QWORD [rel fun_start_fold_9]
    mov [r12 + 8*0], rcx
mov rcx, 3
    mov [r12 + 8*1], rcx
mov rcx, [rbp - 8*3]
    mov [r12 + 8*2], rcx
mov rcx, [rbp - 8*4]
    mov [r12 + 8*3], rcx
mov rcx, [rbp - 8*2]
    mov [r12 + 8*4], rcx
mov rax, r12
    add r12, 8*5
        add rax, 5

mov [rbp - 8*6], rax
mov rax, 2
    mov [rbp - 8*7], rax

  mov rax, 2
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*8], rax
        mov rax, [rbp - 8]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        
        add rax, [rbp - 8*8]
        
  mov rdi, 499
    jo label_error

    mov [rbp - 8*8], rax
    mov rcx, [rbp - 8*8]
    push rcx
mov rcx, [rbp - 8*7]
    push rcx
    mov rax, [rbp - 8*5]
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

mov [rbp - 8*7], rax
jmp fun_finish_anon_10_11
    fun_start_anon_10_11:
        push rbp
    mov rbp, rsp
    sub rsp, 8*4
    fun_body_anon_10_11:
        
        
  mov rax, [rbp - 8*-4]
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

    fun_exit_anon_10_11:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_anon_10_11:
        lea rcx, QWORD [rel fun_start_anon_10_11]
    mov [r12 + 8*0], rcx
mov rcx, 2
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

    mov [rbp - 8*8], rax
mov rax, 0
    mov [rbp - 8*9], rax
mov rax, [rbp - 8*7]
    mov [rbp - 8*10], rax
    mov rcx, [rbp - 8*10]
    push rcx
mov rcx, [rbp - 8*9]
    push rcx
mov rcx, [rbp - 8*8]
    push rcx
    mov rax, [rbp - 8*6]
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

    mov rsp, rbp
    pop rbp
    ret
time_to_exit:
    ret
