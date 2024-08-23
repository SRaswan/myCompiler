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
    jmp fun_finish_inc_3
    fun_start_inc_3:
        push rbp
    mov rbp, rsp
    sub rsp, 8*6
    fun_body_inc_3:
        
        
  
mov rax, 3

        mov [rbp - 8*1], rax
        mov rax, [rbp - 8*-4]
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
    
mov rax, 3

    jmp label_exit_2
label_else_2:
    
  mov rax, [rbp - 8*-3]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*1], rax
        mov rax, [rbp - 8*-4]
    mov rcx, rax
    and rcx, 5
    cmp rcx, 1
    mov rdi, 399
    jne label_error

    sub rax, 1             ; strip tag
    mov rax, [rax + 8*0] ; read at index
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        
        add rax, [rbp - 8*1]
        
  mov rdi, 499
    jo label_error

    mov [rbp - 8*1], rax
mov rax, [rbp - 8*-3]
    mov [rbp - 8*2], rax
mov rax, [rbp - 8*-4]
    mov rcx, rax
    and rcx, 5
    cmp rcx, 1
    mov rdi, 399
    jne label_error

    sub rax, 1             ; strip tag
    mov rax, [rax + 8*1] ; read at index
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
label_exit_2:

    fun_exit_inc_3:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_inc_3:
        lea rcx, QWORD [rel fun_start_inc_3]
    mov [r12 + 8*0], rcx
mov rcx, 2
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*2], rax
mov rax, [rbp - 8]
    mov [rbp - 8*3], rax
mov rax, 20
    mov [rbp - 8*4], rax
mov rax, 40
    mov [rbp - 8*5], rax
mov rax, 60
    mov [rbp - 8*6], rax

mov rax, 3

    mov [rbp - 8*7], rax
    mov rcx, [rbp - 8*6]
    mov [r12 + 8*0], rcx
mov rcx, [rbp - 8*7]
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
    add rax, 0x1
    mov [rbp - 8*6], rax
    mov rcx, [rbp - 8*5]
    mov [r12 + 8*0], rcx
mov rcx, [rbp - 8*6]
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
    add rax, 0x1
    mov [rbp - 8*5], rax
    mov rcx, [rbp - 8*4]
    mov [r12 + 8*0], rcx
mov rcx, [rbp - 8*5]
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
    add rax, 0x1
    mov [rbp - 8*4], rax
    mov rcx, [rbp - 8*4]
    push rcx
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
