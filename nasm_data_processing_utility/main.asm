section .data
    msg_start db 'Data Processing Started...', 10
    msg_start_len equ $ - msg_start
    msg_end db 'Data Processing Finished.', 10
    msg_end_len equ $ - msg_end

section .text
    global _start

_start:
    ; Print start message
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    lea rsi, [msg_start]
    mov rdx, msg_start_len
    syscall

    ; Call processor
    extern process_data
    call process_data

    ; Call transformer
    extern transform_data
    call transform_data

    ; Call validator
    extern validate_data
    call validate_data

    ; Call reporter
    extern report_results
    call report_results

    ; Print end message
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    lea rsi, [msg_end]
    mov rdx, msg_end_len
    syscall

    ; Exit
    mov rax, 60         ; sys_exit
    xor rdi, rdi        ; exit code 0
    syscall
