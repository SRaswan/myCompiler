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
    sub rsp, 8*3
    mov [rbp - 8], rdi
    mov r12, rsi 
    jmp fun_finish_bug_7
    fun_start_bug_7:
        push rbp
    mov rbp, rsp
    sub rsp, 8*3
    fun_body_bug_7:
        
        
mov rax, 7

    cmp rax, 3
    je label_else_6
    mov rax, 0
mov [rbp - 8*1], rax
loop_start_1:
    
mov rax, [rbp - 8*1]
mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

  add rax, 2
  
  mov rdi, 499
    jo label_error
    mov [rbp - 8*1], rax


  mov rax, 10
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

        cmp rax, [rbp - 8*2]
        mov rax, 7
        jg eq_exit_2
        mov rax, 3
      eq_exit_2:

    cmp rax, 3
    je label_else_3
    mov rax, [rbp - 8*1]
    jmp loop_exit_1
    jmp label_exit_3
label_else_3:
    
mov rax, [rbp - 8*1]
  mov rdi, rax
  call snek_print

label_exit_3:

jmp fun_finish_anon_4_5
    fun_start_anon_4_5:
        push rbp
    mov rbp, rsp
    sub rsp, 8*2
    fun_body_anon_4_5:
        
        mov rax, 4
mov [rbp - 8*1], rax


mov rax, [rbp - 8*1]
mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

  add rax, 2
  
  mov rdi, 499
    jo label_error
  mov rdi, rax
  call snek_print

    fun_exit_anon_4_5:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_anon_4_5:
        lea rcx, QWORD [rel fun_start_anon_4_5]
    mov [r12 + 8*0], rcx
mov rcx, 0
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*2], rax

    
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

    jmp loop_start_1
loop_exit_1:
    jmp label_exit_6
label_else_6:
    
mov rax, 814
  mov rdi, rax
  call snek_print

label_exit_6:

    fun_exit_bug_7:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_bug_7:
        lea rcx, QWORD [rel fun_start_bug_7]
    mov [r12 + 8*0], rcx
mov rcx, 0
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*2], rax
jmp fun_finish_apple_8
    fun_start_apple_8:
        push rbp
    mov rbp, rsp
    sub rsp, 8*2
    fun_body_apple_8:
        
        mov rax, 4
mov [rbp - 8*1], rax


mov rax, [rbp - 8*1]
mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

  add rax, 2
  
  mov rdi, 499
    jo label_error
  mov rdi, rax
  call snek_print

    fun_exit_apple_8:
        mov rsp, rbp
    pop rbp
    ret
    fun_finish_apple_8:
        lea rcx, QWORD [rel fun_start_apple_8]
    mov [r12 + 8*0], rcx
mov rcx, 0
    mov [r12 + 8*1], rcx
mov rax, r12
    add r12, 8*2
        add rax, 5

mov [rbp - 8*3], rax

    
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

    mov rsp, rbp
    pop rbp
    ret
time_to_exit:
    ret
