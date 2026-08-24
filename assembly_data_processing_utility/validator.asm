;
; validator.asm - Data Integrity and Checksum Validation
;

global validate_checksum

section .text

; Calculates a simple CRC-like checksum
; Input:
; RSI = pointer to data
; RDX = length
; Output:
; RAX = checksum value
validate_checksum:
    push rbp
    mov rbp, rsp
    
    xor rax, rax ; Checksum accumulator
    xor rcx, rcx ; Index
    mov r8, rdx  ; Length

    test r8, r8
    jz .done

.validate_loop:
    movzx rbx, byte [rsi + rcx]
    
    ; Simple checksum algorithm: sum of bytes
    add al, bl
    adc ah, 0
    
    inc rcx
    cmp rcx, r8
    jne .validate_loop

.done:
    pop rbp
    ret
