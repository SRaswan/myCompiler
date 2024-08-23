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
         sub rsp, 8*104
 mov [rbp - 8], rdi
 mov r11, rsi               ;; save start of heap in r11
 jmp fun_finish_f
         fun_start_f:
           push rbp
         mov rbp, rsp
         sub rsp, 8*103
         fun_body_f:
           
           mov rax, [rbp - 8*-4]
                 mov [rbp - 8*1], rax
                 mov rcx, [rbp - 8*1]
             push rcx
                 mov rax, [rbp - 8*-3]
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
         fun_exit_f:
           mov rsp, rbp
     pop rbp
     ret
         fun_finish_f:
           lea rcx, QWORD [rel fun_start_f]
             mov [r11 + 8*0], rcx
mov rcx, 2
             mov [r11 + 8*1], rcx
mov rax, r11
                      add r11, 8*2
           add rax, 5
        
mov [rbp - 8*2], rax
jmp fun_finish_fac
         fun_start_fac:
           push rbp
         mov rbp, rsp
         sub rsp, 8*105
         fun_body_fac:
           
           mov rax, [rbp - 8*-3]
                 mov [rbp - 8*1], rax
                 mov rax, 0
                 cmp rax, [rbp - 8*1]
                 mov rax, 3
                 jne eq_exit_2
                 mov rax, 7
               eq_exit_2:
                
                      cmp rax, 3
                      je label_else_2
                      mov rax, 2
                      jmp label_exit_2
                    label_else_2:
                      mov rax, [rbp - 8*-3]
                 mov rcx, rax
             and rcx, 1
             cmp rcx, 0
             mov rdi, 99
             jne label_error
                 mov [rbp - 8], rax
                 mov rax, [rbp - 8*-3]
                 mov rcx, rax
             and rcx, 1
             cmp rcx, 0
             mov rdi, 99
             jne label_error
                 mov [rbp - 8*2], rax
                 mov rax, 2
                 mov rcx, rax
             and rcx, 1
             cmp rcx, 0
             mov rdi, 33
             jne label_error
                 mov rcx, rax
                 mov rax, [rbp - 8*2]
                 sub rax, rcx
                 mov [rbp - 8*2], rax
                 mov rcx, [rbp - 8*2]
             push rcx
                 mov rax, [rbp - 8*-2]
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
                 mov rcx, rax
             and rcx, 1
             cmp rcx, 0
             mov rdi, 33
             jne label_error
                 sar rax, 1
                 imul rax, [rbp - 8]
                
                    label_exit_2:
         fun_exit_fac:
           mov rsp, rbp
     pop rbp
     ret
         fun_finish_fac:
           lea rcx, QWORD [rel fun_start_fac]
             mov [r11 + 8*0], rcx
mov rcx, 1
             mov [r11 + 8*1], rcx
mov rax, r11
                      add r11, 8*2
           add rax, 5
        
mov [rbp - 8*3], rax
mov rax, [rbp - 8*3]
                 mov [rbp - 8*4], rax
mov rax, [rbp - 8]
                 mov [rbp - 8*5], rax
                 mov rcx, [rbp - 8*5]
             push rcx
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
         cmp rcx, 2   ; compare with actual #args
         mov rdi, 199       ; mismatched args error
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
