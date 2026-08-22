
.section .text
.globl transform_data

# transformer.asm - Data transformation module for machine code data processing utility

transform_data:
    # Transform validated data
    movq $DATA_BUFFER, %rdi
    movq $DATA_COUNT, %rax  # Number of records
    
    # Transform each record
    xorq %rcx, %rcx       # Record counter
transform_loop:
    cmpq %rax, %rcx       # Check if all records processed
    jge transform_done
    
    # Get current record pointer
    leaq DATA_BUFFER(%rcx, %rsi, 8), %rdi
    
    # Apply transformation algorithm
    call apply_transformation
    
    # Increment record counter
    incq %rcx
    jmp transform_loop

transform_done:
    ret

# Helper function: apply transformation to individual record
apply_transformation:
    # Apply mathematical transformation to data values
    # Argument: %rdi = record pointer
    movq %rdi, %rsi       # Save record pointer
    
    # Load values into registers
    movq VALUE1_FIELD(%rsi), %rax
    movq VALUE2_FIELD(%rsi), %rbx
    movq VALUE3_FIELD(%rsi), %rcx
    
    # Apply transformation: normalize values to [0, 1] range
    # Find max value first
    movq %rax, %r8        # Max = Value1
    cmpq %rbx, %r8        # Compare with Value2
    jge check_value3
    movq %rbx, %r8        # Max = Value2
    
check_value3:
    cmpq %rcx, %r8        # Compare with Value3
    jge normalize_values
    movq %rcx, %r8        # Max = Value3
    
normalize_values:
    # Normalize each value by dividing by max
    cmpq $0, %r8          # Check for division by zero
    je skip_normalization
    
    movq %rax, %rdi       # Numerator = Value1
    movq %r8, %rsi        # Denominator = Max
    call perform_normalization
    movq %rax, VALUE1_FIELD(%rsi)
    
    movq %rbx, %rdi       # Numerator = Value2
    movq %r8, %rsi        # Denominator = Max
    call perform_normalization
    movq %rax, VALUE2_FIELD(%rsi)
    
    movq %rcx, %rdi       # Numerator = Value3
    movq %r8, %rsi        # Denominator = Max
    call perform_normalization
    movq %rax, VALUE3_FIELD(%rsi)
    
skip_normalization:
    ret

# Helper function: perform normalization calculation
perform_normalization:
    # Perform division for normalization
    # Argument: %rdi = numerator, %rsi = denominator
    movq %rdi, %rax       # Numerator
    movq %rsi, %rdx       # Denominator
    
    # Check for division by zero
    cmpq $0, %rdx
    je normalize_done
    
    # Perform division
    cqto                  # Sign extend %rax into %rdx:%rax
    idivq %rdx            # %rax = %rdx:%rax / %rdx
    
normalize_done:
    ret

# Helper function: apply mathematical operation
apply_math_operation:
    # Apply mathematical operation to values
    # Argument: %rdi = record pointer, %rsi = operation code
    movq %rdi, %rax       # Record pointer
    movq %rsi, %rbx       # Operation code
    
    # Load values
    movq VALUE1_FIELD(%rax), %rcx
    movq VALUE2_FIELD(%rax), %rdx
    movq VALUE3_FIELD(%rax), %r8
    
    # Apply operation based on code
    cmpq $1, %rbx         # Operation 1: Sum
    je apply_sum
    cmpq $2, %rbx         # Operation 2: Average
    je apply_average
    cmpq $3, %rbx         # Operation 3: Product
    je apply_product
    
    # Default: no operation
    ret

apply_sum:
    addq %rcx, %rdx       # Sum = Value1 + Value2
    addq %rdx, %r8        # Sum = Sum + Value3
    movq %r8, RESULT_FIELD(%rax)
    ret

apply_average:
    addq %rcx, %rdx       # Sum = Value1 + Value2
    addq %rdx, %r8        # Sum = Sum + Value3
    sarq $2, %r8          # Divide by 4 (average of 3 values)
    movq %r8, RESULT_FIELD(%rax)
    ret

apply_product:
    imulq %rcx, %rdx      # Product = Value1 * Value2
    imulq %r8, %rdx       # Product = Product * Value3
    movq %rdx, RESULT_FIELD(%rax)
    ret

.section .data
DATA_BUFFER:
    .space 10240
DATA_COUNT:
    .quad 100

.section .bss
VALUE1_FIELD:
    .quad 0
VALUE2_FIELD:
    .quad 0
VALUE3_FIELD:
    .quad 0
RESULT_FIELD:
    .quad 0
