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
         sub rsp, 8*107
 mov [rbp - 8], rdi
 mov r11, rsi               ;; save start of heap in r11
 jmp fun_finish_cons
         fun_start_cons:
           push rbp
         mov rbp, rsp
         sub rsp, 8*104
         fun_body_cons:
           
           mov rax, [rbp - 8*-3]
                 mov [rbp - 8*1], rax
mov rax, [rbp - 8*-4]
                 mov [rbp - 8*2], rax
                      mov rcx, [rbp - 8*1]
             mov [r11 + 8*0], rcx
mov rcx, [rbp - 8*2]
             mov [r11 + 8*1], rcx
mov rax, r11
                      add r11, 8*2
                      add rax, 0x1
         fun_exit_cons:
           mov rsp, rbp
     pop rbp
     ret
         fun_finish_cons:
           lea rcx, QWORD [rel fun_start_cons]
             mov [r11 + 8*0], rcx
mov rcx, 2
             mov [r11 + 8*1], rcx
mov rax, r11
                      add r11, 8*2
           add rax, 5
        
mov [rbp - 8*2], rax
jmp fun_finish_nil
         fun_start_nil:
           push rbp
         mov rbp, rsp
         sub rsp, 8*101
         fun_body_nil:
           
           mov rax, 3
         fun_exit_nil:
           mov rsp, rbp
     pop rbp
     ret
         fun_finish_nil:
           lea rcx, QWORD [rel fun_start_nil]
             mov [r11 + 8*0], rcx
mov rcx, 0
             mov [r11 + 8*1], rcx
mov rax, r11
                      add r11, 8*2
           add rax, 5
        
mov [rbp - 8*3], rax
jmp fun_finish_swapList
         fun_start_swapList:
           push rbp
         mov rbp, rsp
         sub rsp, 8*103
         fun_body_swapList:
           
           mov rax, [rbp - 8*-3]
                 ;; TODO: check rax is pointer
             sub rax, 1             ; strip tag
             mov rax, [rax + 8*1] ; read at index
                 mov [rbp - 8*1], rax
mov rax, [rbp - 8*-3]
                 ;; TODO: check rax is pointer
             sub rax, 1             ; strip tag
             mov rax, [rax + 8*0] ; read at index
                 mov [rbp - 8*2], rax
                      mov rcx, [rbp - 8*1]
             mov [r11 + 8*0], rcx
mov rcx, [rbp - 8*2]
             mov [r11 + 8*1], rcx
mov rax, r11
                      add r11, 8*2
                      add rax, 0x1
         fun_exit_swapList:
           mov rsp, rbp
     pop rbp
     ret
         fun_finish_swapList:
           lea rcx, QWORD [rel fun_start_swapList]
             mov [r11 + 8*0], rcx
mov rcx, 1
             mov [r11 + 8*1], rcx
mov rax, r11
                      add r11, 8*2
           add rax, 5
        
mov [rbp - 8*4], rax
mov rax, 2
                 mov [rbp - 8*5], rax

                 
                 mov rax, [rbp - 8*3]
                 mov rcx, rax
         and rcx, 5
         cmp rcx, 5
         mov rdi, 199
         jne label_error
                 mov rcx, rax
         sub rcx, 5         ; remove tag
         mov rcx, [rcx + 8] ; load closure-arity into rcx
         cmp rcx, 0   ; compare with actual #args
         mov rdi, 199       ; mismatched args error
         jne label_error
                 push rax
                 sub rax, 5
                 call [rax]
                 add rsp, 8*0
                 mov [rbp - 8*6], rax
                 mov rcx, [rbp - 8*6]
             push rcx
mov rcx, [rbp - 8*5]
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
mov [rbp - 8*5], rax
mov rax, 7
                 mov [rbp - 8*6], rax

                 
                 mov rax, [rbp - 8*3]
                 mov rcx, rax
         and rcx, 5
         cmp rcx, 5
         mov rdi, 199
         jne label_error
                 mov rcx, rax
         sub rcx, 5         ; remove tag
         mov rcx, [rcx + 8] ; load closure-arity into rcx
         cmp rcx, 0   ; compare with actual #args
         mov rdi, 199       ; mismatched args error
         jne label_error
                 push rax
                 sub rax, 5
                 call [rax]
                 add rsp, 8*0
                 mov [rbp - 8*7], rax
                 mov rcx, [rbp - 8*7]
             push rcx
mov rcx, [rbp - 8*6]
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
mov [rbp - 8*6], rax
mov rax, [rbp - 8*5]
                 mov [rbp - 8*7], rax
mov rax, [rbp - 8*6]
                 mov [rbp - 8*8], rax
                      mov rcx, [rbp - 8*7]
             mov [r11 + 8*0], rcx
mov rcx, [rbp - 8*8]
             mov [r11 + 8*1], rcx
mov rax, r11
                      add r11, 8*2
                      add rax, 0x1
                 mov [rbp - 8*7], rax
                 mov rcx, [rbp - 8*7]
             push rcx
                 mov rax, [rbp - 8*4]
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
 mov rsp, rbp
     pop rbp
     ret
time_to_exit:
  ret
