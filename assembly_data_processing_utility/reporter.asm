;
; reporter.asm - Output and Logging
;

section .data
    msg_stats db 'Bytes processed: ', 0
    len_stats equ $ - msg_stats
    
    msg_end_line db 10, 0
    len_end_line equ $ - msg_end_line

section .text
    global print_stats

; Prints statistics about the processed data
; Input:
; RDI = number of bytes processed
print_stats:
    push rbp
    mov rbp, rsp
    
    ; Print label
    mov rax, 1 ; sys_write
    mov rdi, 1 ; stdout
    mov rsi, msg_stats
    mov rdx, len_stats
    syscall
    
    ; Convert RDI (bytes) to string
    ; This is a simplified conversion for demonstration
    ; In a full implementation, you'd handle multi-digit numbers
    mov rax, rdi
    call int_to_string
    
    ; Print number string
    ; Note: print_buffer points to where int_to_string wrote
    mov rsi, print_buffer
    mov rdx, string_len
    mov rdx, string_len ; Adjust length based on actual digits
    syscall
    
    ; Newline
    mov rax, 1 ; sys_write
    mov rdi, 1
    mov rsi, msg_end_line
    mov rdx, len_end_line
    syscall
    
    pop rbp
    ret

section .bss
    print_buffer resb 20
    string_len resq 1

section .text
    global int_to_string

; Converts integer in RAX to string at print_buffer
; Returns length in string_len
int_to_string:
    push rbp
    mov rbp, rsp
    
    mov rsi, print_buffer + 19 ; Pointer to end of buffer
    mov byte [rsi], 0
    dec rsi
    mov rcx, 10
    
    ; Handle zero
    test rax, rax
    jnz .loop
    mov byte [rsi], '0'
    dec rsi
    jmp .len

.loop:
    xor rdx, rdx
    div rcx
    add dl, '0'
    mov [rsi], dl
    dec rsi
    test rax, rax
    jnz .loop

.len:
    inc rsi ; Point to first digit
    mov rax, print_buffer + 19
    sub rax, rsi
    mov [string_len], rax
    
    pop rbp
    ret
