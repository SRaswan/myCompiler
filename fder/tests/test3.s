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
    
  mov rax, 6
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*2], rax
        mov rax, [rbp - 8]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        cmp rax, [rbp - 8*2]
        mov rax, 7
        jle eq_exit_1
        mov rax, 3
      eq_exit_1:

    cmp rax, 3
    je label_else_11
    
mov rax, 3

    jmp label_exit_11
label_else_11:
    mov rax, 4
mov [rbp - 8*2], rax
loop_start_2:
    
  

  mov rax, [rbp - 8*2]
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

mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

  add rax, 2
  
  mov rdi, 499
    jo label_error
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*3], rax
        mov rax, [rbp - 8]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        cmp rax, [rbp - 8*3]
        mov rax, 7
        jle eq_exit_3
        mov rax, 3
      eq_exit_3:

    cmp rax, 3
    je label_else_10
    
mov rax, 7

    jmp loop_exit_2
    jmp label_exit_10
label_else_10:
    mov rax, 2
mov [rbp - 8*3], rax
loop_start_4:
    
  

  mov rax, [rbp - 8*3]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*4], rax
        mov rax, [rbp - 8*2]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        sar rax, 1
        imul rax, [rbp - 8*4]
        
  mov rdi, 499
    jo label_error

mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

  add rax, 2
  
  mov rdi, 499
    jo label_error
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*4], rax
        mov rax, [rbp - 8]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        cmp rax, [rbp - 8*4]
        mov rax, 7
        jle eq_exit_5
        mov rax, 3
      eq_exit_5:

    cmp rax, 3
    je label_else_8
    
mov rax, 3

    jmp loop_exit_4
    jmp label_exit_8
label_else_8:
    
  mov rax, [rbp - 8]
        mov [rbp - 8*4], rax
        
  mov rax, [rbp - 8*3]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*5], rax
        mov rax, [rbp - 8*2]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        sar rax, 1
        imul rax, [rbp - 8*5]
        
  mov rdi, 499
    jo label_error

        mov rdx, rax
        and rdx, 1
        mov rcx, [rbp - 8*4]
        and rcx, 1
        xor rcx, rdx
        mov rdi, 599
        jnz label_error
        cmp rax, [rbp - 8*4]
        mov rax, 3
        jne eq_exit_6
        mov rax, 7
      eq_exit_6:

    cmp rax, 3
    je label_else_7
    
mov rax, 7

    jmp loop_exit_4
    jmp label_exit_7
label_else_7:
    
  mov rax, 2
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*4], rax
        mov rax, [rbp - 8*3]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        
        add rax, [rbp - 8*4]
        
  mov rdi, 499
    jo label_error

    mov [rbp - 8*3], rax

label_exit_7:

label_exit_8:

    jmp loop_start_4
loop_exit_4:
    cmp rax, 3
    je label_else_9
    
mov rax, 3

    jmp loop_exit_2
    jmp label_exit_9
label_else_9:
    
  mov rax, 2
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

        
        add rax, [rbp - 8*3]
        
  mov rdi, 499
    jo label_error

    mov [rbp - 8*2], rax

label_exit_9:

label_exit_10:

    jmp loop_start_2
loop_exit_2:
label_exit_11:

    mov rsp, rbp
    pop rbp
    ret
time_to_exit:
    ret
