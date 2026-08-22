
.section .text
.globl load_data

# ingester.asm - Data ingestion module for machine code data processing utility

load_data:
    # Load data from input file
    # Argument: %rdi = filename
    movq %rdi, %rsi       # Save filename
    pushq %rsi
    
    # Open file using sys_open
    movq $2, %rax         # sys_open
    pushq $0              # flags: O_RDONLY
    pushq $0666           # mode
    movq $rsp, %rdx       # mode
    movq $rsp, %rsi       # flags
    pushq %rsi
    syscall
    
    popq %rsi             # Restore filename
    movq %rax, %r8        # Save file descriptor
    
    # Read data into buffer
    movq $DATA_BUFFER, %rdi
    movq $MAX_DATA_SIZE, %rsi
    movq $0, %rdx         # offset
    movq $3, %rax         # sys_read
    syscall
    
    # Close file
    movq $8, %rax         # sys_close
    movq %r8, %rdi        # file descriptor
    syscall
    
    popq %rsi             # Restore filename
    ret

# Helper function: parse CSV line
parse_csv_line:
    # Parse a single CSV line into structured data
    # Argument: %rdi = line pointer
    movq %rdi, %rsi       # Save line pointer
    
    # Parse first field (ID)
    movb (%rsi), %al      # Get first character
    cmpb $',', %al         # Check for comma separator
    je parse_id_done
    
    # Convert ASCII to integer
    call ascii_to_integer
    
    # Store parsed ID
    movq %rax, ID_FIELD
    
parse_id_done:
    # Parse second field (Value1)
    leaq 1(%rsi), %rsi    # Move to next field
    call parse_numeric_field
    movq %rax, VALUE1_FIELD
    
    # Parse third field (Value2)
    leaq 1(%rsi), %rsi    # Move to next field
    call parse_numeric_field
    movq %rax, VALUE2_FIELD
    
    # Parse fourth field (Value3)
    leaq 1(%rsi), %rsi    # Move to next field
    call parse_numeric_field
    movq %rax, VALUE3_FIELD
    
    ret

# Helper function: parse numeric field
parse_numeric_field:
    # Parse a numeric field from CSV line
    # Argument: %rdi = field pointer
    movq %rdi, %rsi       # Save field pointer
    
    # Find end of field (comma or newline)
    movb (%rsi), %al      # Get first character
    cmpb $',', %al         # Check for comma
    je parse_field_end
    cmpb $'\n', %al       # Check for newline
    je parse_field_end
    
    # Convert ASCII to integer
    call ascii_to_integer
    ret

parse_field_end:
    ret

# Helper function: ASCII to integer conversion
ascii_to_integer:
    # Convert ASCII string to integer
    # Argument: %rdi = string pointer
    xorq %rax, %rax       # Clear result
    xorq %rcx, %rcx       # Clear multiplier
    
ascii_loop:
    movb (%rdi), %al      # Get character
    cmpb $0, %al          # Check for null terminator
    je ascii_done
    cmpb $',', %al        # Check for comma
    je ascii_done
    cmpb $'\n', %al       # Check for newline
    je ascii_done
    
    # Convert ASCII digit to integer value
    subb $48, %al         # '0' = 48
    imulq $10, %rax       # Multiply current result by 10
    addq %rax, %rax       # Add new digit
    
    # Move to next character
    incq %rdi
    jmp ascii_loop

ascii_done:
    ret

.section .data
DATA_BUFFER:
    .space 10240
MAX_DATA_SIZE:
    .quad 10240

.section .bss
ID_FIELD:
    .quad 0
VALUE1_FIELD:
    .quad 0
VALUE2_FIELD:
    .quad 0
VALUE3_FIELD:
    .quad 0
