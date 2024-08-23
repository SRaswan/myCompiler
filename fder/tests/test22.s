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
    mov rax, 0
mov [rbp - 8*2], rax
mov rax, 2
mov [rbp - 8*3], rax
mov rax, 0
mov [rbp - 8*4], rax
mov rax, [rbp - 8]
    mov [rbp - 8*2], rax

loop_start_1:
    
  mov rax, [rbp - 8*2]
        and rax, 1
        cmp rax, 0
        jne not_zero_2
        mov rax, 7
        jmp is_zero_2
        not_zero_2:
        mov rax, 3
        is_zero_2:

    cmp rax, 3
    je label_else_22
    
  mov rax, [rbp - 8*2]
        and rax, 1
        cmp rax, 0
        jne not_zero_3
        mov rax, 3
        jmp is_zero_3
        not_zero_3:
        mov rax, 7
        is_zero_3:

    mov [rbp - 8*2], rax


  
mov rax, 3

        mov [rbp - 8*5], rax
        mov rax, [rbp - 8*2]
        mov rdx, rax
        and rdx, 1
        mov rcx, [rbp - 8*5]
        and rcx, 1
        xor rcx, rdx
        mov rdi, 599
        jnz label_error
        cmp rax, [rbp - 8*5]
        mov rax, 3
        jne eq_exit_4
        mov rax, 7
      eq_exit_4:

    cmp rax, 3
    je label_else_21
    loop_start_5:
    
  mov rax, 14
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*5], rax
        mov rax, [rbp - 8*4]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        cmp rax, [rbp - 8*5]
        mov rax, 7
        jle eq_exit_6
        mov rax, 3
      eq_exit_6:

    cmp rax, 3
    je label_else_20
    
  mov rax, [rbp - 8*4]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*5], rax
        mov rax, [rbp - 8*3]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        sar rax, 1
        imul rax, [rbp - 8*5]
        
  mov rdi, 499
    jo label_error

    mov [rbp - 8*3], rax


  mov rax, 2
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*5], rax
        mov rax, [rbp - 8*4]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        
        add rax, [rbp - 8*5]
        
  mov rdi, 499
    jo label_error

    mov [rbp - 8*4], rax


  mov rax, [rbp - 8*2]
        mov [rbp - 8*5], rax
        
mov rax, 3

        mov rdx, rax
        and rdx, 1
        mov rcx, [rbp - 8*5]
        and rcx, 1
        xor rcx, rdx
        mov rdi, 599
        jnz label_error
        cmp rax, [rbp - 8*5]
        mov rax, 3
        jne eq_exit_7
        mov rax, 7
      eq_exit_7:

    mov [rbp - 8*2], rax

    jmp label_exit_20
label_else_20:
    
  
mov rax, 7

        mov [rbp - 8*5], rax
        mov rax, [rbp - 8*2]
        mov rdx, rax
        and rdx, 1
        mov rcx, [rbp - 8*5]
        and rcx, 1
        xor rcx, rdx
        mov rdi, 599
        jnz label_error
        cmp rax, [rbp - 8*5]
        mov rax, 3
        jne eq_exit_8
        mov rax, 7
      eq_exit_8:

    cmp rax, 3
    je label_else_19
    mov rax, 2
    jmp loop_exit_5
    jmp label_exit_19
label_else_19:
    
  mov rax, [rbp - 8*2]
        and rax, 1
        cmp rax, 0
        jne not_zero_9
        mov rax, 7
        jmp is_zero_9
        not_zero_9:
        mov rax, 3
        is_zero_9:

    mov [rbp - 8*2], rax


  
mov rax, 7

        mov [rbp - 8*5], rax
        mov rax, [rbp - 8*2]
        mov rdx, rax
        and rdx, 1
        mov rcx, [rbp - 8*5]
        and rcx, 1
        xor rcx, rdx
        mov rdi, 599
        jnz label_error
        cmp rax, [rbp - 8*5]
        mov rax, 3
        jne eq_exit_10
        mov rax, 7
      eq_exit_10:

    cmp rax, 3
    je label_else_12
    mov rax, [rbp - 8*2]
    jmp loop_exit_5
    jmp label_exit_12
label_else_12:
    
  mov rax, [rbp - 8*2]
        and rax, 1
        cmp rax, 0
        jne not_zero_11
        mov rax, 3
        jmp is_zero_11
        not_zero_11:
        mov rax, 7
        is_zero_11:

label_exit_12:


  
mov rax, 7

        mov [rbp - 8*5], rax
        mov rax, [rbp - 8*2]
        mov rdx, rax
        and rdx, 1
        mov rcx, [rbp - 8*5]
        and rcx, 1
        xor rcx, rdx
        mov rdi, 599
        jnz label_error
        cmp rax, [rbp - 8*5]
        mov rax, 3
        jne eq_exit_13
        mov rax, 7
      eq_exit_13:

    cmp rax, 3
    je label_else_15
    
  mov rax, [rbp - 8*2]
        and rax, 1
        cmp rax, 0
        jne not_zero_14
        mov rax, 7
        jmp is_zero_14
        not_zero_14:
        mov rax, 3
        is_zero_14:

    jmp label_exit_15
label_else_15:
    mov rax, [rbp - 8*2]
    jmp loop_exit_5
label_exit_15:


  
mov rax, 3

        mov [rbp - 8*5], rax
        mov rax, [rbp - 8*2]
        mov rdx, rax
        and rdx, 1
        mov rcx, [rbp - 8*5]
        and rcx, 1
        xor rcx, rdx
        mov rdi, 599
        jnz label_error
        cmp rax, [rbp - 8*5]
        mov rax, 3
        jne eq_exit_16
        mov rax, 7
      eq_exit_16:

    cmp rax, 3
    je label_else_18
    mov rax, [rbp - 8*2]
    jmp loop_exit_5
    jmp label_exit_18
label_else_18:
    
  mov rax, [rbp - 8*2]
        and rax, 1
        cmp rax, 0
        jne not_zero_17
        mov rax, 3
        jmp is_zero_17
        not_zero_17:
        mov rax, 7
        is_zero_17:

label_exit_18:

label_exit_19:

label_exit_20:

    jmp loop_start_5
loop_exit_5:
    jmp label_exit_21
label_else_21:
    mov rax, [rbp - 8*3]
    jmp loop_exit_1
label_exit_21:

    jmp label_exit_22
label_else_22:
    mov rax, [rbp - 8*2]
    jmp loop_exit_1
label_exit_22:

    jmp loop_start_1
loop_exit_1:
    mov rsp, rbp
    pop rbp
    ret
time_to_exit:
    ret
