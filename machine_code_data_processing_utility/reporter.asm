
.section .text
.globl generate_report

# reporter.asm - Report generation module for machine code data processing utility

generate_report:
    # Generate report from processed data
    movq $REPORT_FILENAME, %rdi
    call open_file_for_writing
    
    movq $REPORT_BUFFER, %rdi
    movq $REPORT_SIZE, %rsi
    call write_report_content
    
    # Close report file
    call close_file
    ret

# Helper function: open file for writing
open_file_for_writing:
    # Open file for writing
    # Argument: %rdi = filename
    movq %rdi, %rsi       # Save filename
    pushq %rsi
    
    movq $2, %rax         # sys_open
    pushq $1              # flags: O_WRONLY|O_CREAT
    pushq $0666           # mode
    movq $rsp, %rdx       # mode
    movq $rsp, %rsi       # flags
    pushq %rsi
    syscall
    
    popq %rsi             # Restore filename
    ret

# Helper function: write report content
write_report_content:
    # Write report content to file
    # Argument: %rdi = buffer, %rsi = size
    movq %rdi, %r8        # Save buffer pointer
    movq %rsi, %r9        # Save size
    
    movq $1, %rax         # sys_write
    movq $1, %rdi         # file descriptor (stdout for demo)
    syscall
    
    ret

# Helper function: close file
close_file:
    # Close file descriptor
    movq $8, %rax         # sys_close
    movq $1, %rdi         # file descriptor
    syscall
    ret

# Helper function: format report header
format_report_header:
    # Format report header section
    movq $REPORT_BUFFER, %rdi
    
    # Write header text
    movq $HEADER_STRING, %rsi
    call write_string_to_buffer
    
    ret

# Helper function: format report footer
format_report_footer:
    # Format report footer section
    movq $REPORT_BUFFER, %rdi
    
    # Write footer text
    movq $FOOTER_STRING, %rsi
    call write_string_to_buffer
    
    ret

# Helper function: write string to buffer
write_string_to_buffer:
    # Write string to buffer
    # Argument: %rdi = buffer pointer, %rsi = string pointer
    movq %rdi, %rax       # Buffer pointer
    movq %rsi, %rdx       # String pointer
    
    # Copy string to buffer
    movb (%rdx), %al      # Get character
    cmpb $0, %al          # Check for null terminator
    je string_done
    
    movb %al, (%rax)      # Store character
    incq %rax             # Move to next buffer position
    incq %rdx             # Move to next string character
    jmp write_string_to_buffer

string_done:
    ret

.section .data
REPORT_FILENAME:
    .string "report.txt"
REPORT_BUFFER:
    .space 4096
REPORT_SIZE:
    .quad 4096

.section .rodata
HEADER_STRING:
    .string "=== Data Processing Report ===\n"
FOOTER_STRING:
    .string "=== End of Report ===\n"

.section .bss
OUTPUT_FILE_DESCRIPTOR:
    .quad 0
