# Assembly Data Processing Utility

A low-level, high-performance data processing utility written in pure x86-64 Assembly language.

## Features
- Ingests raw binary data streams
- Transforms data via bit-shifting and arithmetic operations
- Validates checksums and data integrity
- Reports processing statistics

## Usage

### Prerequisites
- NASM (Netwide Assembler)
- Linux (64-bit)

### Building
```bash
nasm -f elf64 main.asm -o main.o
ld main.o -o data_processor
```

### Running
```bash
./data_processor input.dat output.dat
```

## Architecture

- `main.asm`: Entry point, syscall handling, argument parsing.
- `processor.asm`: Core logic for data transformation.
- `validator.asm`: Checksum calculation and integrity verification.
- `reporter.asm`: Output formatting and logging.
- `parser.asm`: Input format detection and parsing.

## License
MIT License
