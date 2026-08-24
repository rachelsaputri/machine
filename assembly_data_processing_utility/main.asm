;
; main.asm - Entry Point for Assembly Data Processing Utility
;

%include 'io.asm'

section .data
    ; Input/Output paths
    msg_no_args db 'Usage: data_processor <input_file> <output_file>', 10
    len_no_args equ $ - msg_no_args
    
    msg_success db 'Processing complete.', 10
    len_success equ $ - msg_success
    
    msg_read_err db 'Error: Failed to read input file.', 10
    len_read_err equ $ - msg_read_err
    
    msg_write_err db 'Error: Failed to write output file.', 10
    len_write_err equ $ - msg_write_err
    
    stdin_label db 'stdin', 0
    stdout_label db 'stdout', 0

section .bss
    ; Buffers for reading/writing
    input_buf resb 4096
    output_buf resb 4096
    
    ; File descriptors
    input_fd resq 1
    output_fd resq 1
    
    ; Bytes read/written
    bytes_read resq 1
    bytes_written resq 1

section .text
    global _start

_start:
    ; Check command line arguments
    ; rsi = argv, rdx = argc
    cmp rdx, 2
    jge has_args

    ; Print usage
    mov rax, 1 ; sys_write
    mov rdi, 2 ; stderr
    mov rsi, msg_no_args
    mov rdx, len_no_args
    syscall
    
    mov rax, 60 ; sys_exit
    mov rdi, 1
    syscall

has_args:
    ; Get input filename
    mov rsi, [rsi + 8] ; argv[1]
    call open_file
    mov [input_fd], rax
    cmp rax, -1
    jne input_opened_ok
    ; Handle open error
    jmp exit_error

input_opened_ok:
    ; Get output filename
    mov rsi, [rsi + 8] ; argv[2]
    call open_file_write
    mov [output_fd], rax
    cmp rax, -1
    jne output_opened_ok
    ; Handle open error
    jmp exit_error

output_opened_ok:
    ; Main processing loop
.process_loop:
    ; Read chunk from input
    mov rax, 0 ; sys_read
    mov rdi, [input_fd]
    mov rsi, input_buf
    mov rdx, 4096
    syscall
    mov [bytes_read], rax
    
    ; Check for EOF
    cmp rax, 0
    je end_of_input
    
    ; Check for error
    jlt read_error
    
    ; Process data chunk
    mov rsi, input_buf
    mov rdx, [bytes_read]
    call transform_data
    
    ; Write transformed data
    mov rax, 1 ; sys_write
    mov rdi, [output_fd]
    mov rsi, output_buf
    mov rdx, [bytes_read] ; Assuming output size matches input for simplicity
    syscall
    mov [bytes_written], rax
    
    cmp rax, 0
    jne write_ok
    jmp write_error

write_ok:
    jmp .process_loop

end_of_input:
    ; Print success message
    mov rax, 1 ; sys_write
    mov rdi, 1 ; stdout
    mov rsi, msg_success
    mov rdx, len_success
    syscall
    
    ; Close files
    mov rax, 3 ; sys_close
    mov rdi, [input_fd]
    syscall
    
    mov rax, 3 ; sys_close
    mov rdi, [output_fd]
    syscall
    
    ; Exit
    mov rax, 60 ; sys_exit
    mov rdi, 0
    syscall

read_error:
    mov rax, 1 ; sys_write
    mov rdi, 2 ; stderr
    mov rsi, msg_read_err
    mov rdx, len_read_err
    syscall
    jmp exit_error

write_error:
    mov rax, 1 ; sys_write
    mov rdi, 2 ; stderr
    mov rsi, msg_write_err
    mov rdx, len_write_err
    syscall
    jmp exit_error

exit_error:
    mov rax, 60 ; sys_exit
    mov rdi, 1
    syscall

; Function: open_file
; Opens a file for reading
; Input: RSI = filename pointer
; Output: RAX = file descriptor or -1 on error
open_file:
    push rbp
    mov rbp, rsp
    
    mov rax, 2 ; sys_open
    mov rdi, rsi ; filename
    mov rsi, 0 ; O_RDONLY
    xor rdx, rdx ; mode
    syscall
    
    pop rbp
    ret

; Function: open_file_write
; Opens a file for writing
; Input: RSI = filename pointer
; Output: RAX = file descriptor or -1 on error
open_file_write:
    push rbp
    mov rbp, rsp
    
    mov rax, 2 ; sys_open
    mov rdi, rsi ; filename
    mov rsi, 0x241 ; O_WRONLY | O_CREAT | O_TRUNC
    mov rdx, 0644 ; mode
    syscall
    
    pop rbp
    ret
