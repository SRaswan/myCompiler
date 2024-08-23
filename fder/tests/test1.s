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
    
  mov rax, 8
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*2], rax
        
  mov rax, 8
        mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, 99
    jne label_error

        mov [rbp - 8*3], rax
        mov rax, 4
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

        
        add rax, [rbp - 8*2]
        
  mov rdi, 499
    jo label_error

    mov rsp, rbp
    pop rbp
    ret
time_to_exit:
    ret
