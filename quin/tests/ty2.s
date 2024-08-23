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
 jmp fun_finish_id
         fun_start_id:
           push rbp
         mov rbp, rsp
         sub rsp, 8*102
         fun_body_id:
           
           mov rax, [rbp - 8*-3]
         fun_exit_id:
           mov rsp, rbp
     pop rbp
     ret
         fun_finish_id:
           lea rcx, QWORD [rel fun_start_id]
             mov [r11 + 8*0], rcx
mov rcx, 1
             mov [r11 + 8*1], rcx
mov rax, r11
                      add r11, 8*2
           add rax, 5
        
mov [rbp - 8*2], rax
mov rax, 14
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
mov rax, 7
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
mov rax, 7
 mov rsp, rbp
     pop rbp
     ret
time_to_exit:
  ret
