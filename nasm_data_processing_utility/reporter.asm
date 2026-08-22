section .data
    msg_report db 'Reporting results...', 10
    msg_report_len equ $ - msg_report

section .text
    global report_results

report_results:
    ; Print report start message
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    lea rsi, [msg_report]
    mov rdx, msg_report_len
    syscall

    ret
