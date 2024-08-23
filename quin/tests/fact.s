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
         sub rsp, 8*103
 mov [rbp - 8], rdi
 mov r11, rsi               ;; save start of heap in r11
 jmp fun_finish_fact
         fun_start_fact:
           push rbp
         mov rbp, rsp
         sub rsp, 8*105
         fun_body_fact:
           
           mov rax, 2
mov [rbp - 8*1], rax
mov rax, 2
mov [rbp - 8*2], rax
loop_start_1:
                        mov rax, [rbp - 8*1]
                 mov [rbp - 8*3], rax
                 mov rax, [rbp - 8*-3]
                 cmp rax, [rbp - 8*3]
                 mov rax, 3
                 jl eq_exit_3
                 mov rax, 7
               eq_exit_3:
                
                      cmp rax, 3
                      je label_else_3
                      mov rax, [rbp - 8*2]
                 mov rcx, rax
             and rcx, 1
             cmp rcx, 0
             mov rdi, 99
             jne label_error
                 mov [rbp - 24], rax
                 mov rax, [rbp - 8*1]
                 mov rcx, rax
             and rcx, 1
             cmp rcx, 0
             mov rdi, 33
             jne label_error
                 sar rax, 1
                 imul rax, [rbp - 24]
                
                     mov [rbp - 8*2], rax
mov rax, [rbp - 8*1]
                 mov rcx, rax
             and rcx, 1
             cmp rcx, 0
             mov rdi, 99
             jne label_error
                 mov [rbp - 8*3], rax
                 mov rax, 2
                 mov rcx, rax
             and rcx, 1
             cmp rcx, 0
             mov rdi, 33
             jne label_error
                 add rax, [rbp - 8*3]
                
                     mov [rbp - 8*1], rax
                      jmp label_exit_3
                    label_else_3:
                      mov rax, [rbp - 8*2]
                     jmp loop_exit_1
                    label_exit_3:
                        jmp loop_start_1
                     loop_exit_1:
         fun_exit_fact:
           mov rsp, rbp
     pop rbp
     ret
         fun_finish_fact:
           lea rcx, QWORD [rel fun_start_fact]
             mov [r11 + 8*0], rcx
mov rcx, 1
             mov [r11 + 8*1], rcx
mov rax, r11
                      add r11, 8*2
           add rax, 5
        
mov [rbp - 8*2], rax
mov rax, [rbp - 8]
                 mov [rbp - 8*3], rax
                 mov rcx, [rbp - 8*3]
             push rcx
                 mov rax, [rbp - 8*2]
                 mov rcx, rax
         and rcx, 5
         cmp rcx, 5
         mov rdi, 199
         jne label_error
                 mov rcx, rax
         sub rcx, 5         ; remove tag
         mov rcx, [rcx + 8] ; load closure-arity into rcx
         cmp rcx, 1   ; compare with actual #args
         mov rdi, 199       ; mismatched args error
         jne label_error
                 push rax
                 sub rax, 5
                 call [rax]
                 add rsp, 8*1
                 mov [rbp - 8*3], rax
mov rax, [rbp - 8]
                 mov [rbp - 8*4], rax
                 mov rcx, [rbp - 8*4]
             push rcx
                 mov rax, [rbp - 8*2]
                 mov rcx, rax
         and rcx, 5
         cmp rcx, 5
         mov rdi, 199
         jne label_error
                 mov rcx, rax
         sub rcx, 5         ; remove tag
         mov rcx, [rcx + 8] ; load closure-arity into rcx
         cmp rcx, 1   ; compare with actual #args
         mov rdi, 199       ; mismatched args error
         jne label_error
                 push rax
                 sub rax, 5
                 call [rax]
                 add rsp, 8*1
                 mov [rbp - 8*4], rax
                      mov rcx, [rbp - 8*3]
             mov [r11 + 8*0], rcx
mov rcx, [rbp - 8*4]
             mov [r11 + 8*1], rcx
mov rax, r11
                      add r11, 8*2
                      add rax, 0x1
 mov rsp, rbp
     pop rbp
     ret
time_to_exit:
  ret
