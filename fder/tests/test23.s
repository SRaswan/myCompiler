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
    sub rsp, 8*7
    mov [rbp - 8], rdi
    mov r12, rsi 
    mov rax, 20
mov [rbp - 8*2], rax
mov rax, 40
mov [rbp - 8*3], rax
mov rax, 60
mov [rbp - 8*4], rax

  mov rax, 4
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

    mov [rbp - 8*2], rax


  mov rax, [rbp - 8*2]
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

        
        add rax, [rbp - 8*5]
        
  mov rdi, 499
    jo label_error

    mov [rbp - 8*3], rax


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

        cmp rax, [rbp - 8*5]
        mov rax, 7
        jg eq_exit_1
        mov rax, 3
      eq_exit_1:

    cmp rax, 3
    je label_else_7
    
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

        
        sub rax, [rbp - 8*5]
        
  mov rdi, 499
    jo label_error

    mov [rbp - 8*3], rax


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

mov [rbp - 8*5], rax

  mov rax, 400
        mov [rbp - 8*6], rax
        mov rax, [rbp - 8*5]
        mov rdx, rax
        and rdx, 1
        mov rcx, [rbp - 8*6]
        and rcx, 1
        xor rcx, rdx
        mov rdi, 599
        jnz label_error
        cmp rax, [rbp - 8*6]
        mov rax, 3
        jne eq_exit_2
        mov rax, 7
      eq_exit_2:

    cmp rax, 3
    je label_else_6
    mov rax, 0
mov [rbp - 8*6], rax
loop_start_3:
    
  mov rax, 10
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*7], rax
        mov rax, [rbp - 8*6]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        cmp rax, [rbp - 8*7]
        mov rax, 7
        jge eq_exit_4
        mov rax, 3
      eq_exit_4:

    cmp rax, 3
    je label_else_5
    mov rax, [rbp - 8*5]
    jmp loop_exit_3
    jmp label_exit_5
label_else_5:
    
  mov rax, [rbp - 8*6]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*7], rax
        mov rax, [rbp - 8*5]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        
        add rax, [rbp - 8*7]
        
  mov rdi, 499
    jo label_error

    mov [rbp - 8*5], rax


  mov rax, 2
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*7], rax
        mov rax, [rbp - 8*6]
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        
        add rax, [rbp - 8*7]
        
  mov rdi, 499
    jo label_error

    mov [rbp - 8*6], rax

label_exit_5:

    jmp loop_start_3
loop_exit_3:
    jmp label_exit_6
label_else_6:
    mov rax, 0
label_exit_6:

    jmp label_exit_7
label_else_7:
    mov rax, [rbp - 8*4]
label_exit_7:

    mov rsp, rbp
    pop rbp
    ret
time_to_exit:
    ret
