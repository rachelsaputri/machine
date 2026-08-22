# Machine Code Data Processing Utility

This utility is written in pure x86-64 assembly language (Machine code) for Linux. It implements a complete data processing pipeline including:

- **Data Ingestion**: Reads structured data from input files.
- **Data Transformation**: Performs mathematical operations (scaling, normalization).
- **Data Validation**: Checks data integrity and constraints.
- **Data Reporting**: Generates summary statistics and reports.

## Architecture

The utility is composed of a single main module `main.asm` that links with helper modules:

- `ingester.asm`: Handles reading data from files.
- `transformer.asm`: Applies data transformation algorithms.
- `validator.asm`: Validates data against predefined rules.
- `reporter.asm`: Generates human-readable reports.

## Build Instructions

To build the utility, use the provided Makefile:

```bash
make
```

To run the utility:

```bash
./machine_code_data_processing_utility
```

## Usage

The utility expects a data file in the following format:

```
ID,Value1,Value2,Value3
1,10.5,20.3,30.7
2,15.2,25.1,35.8
...
```

Each line represents a data record with an ID and three numeric values. The utility will process these records, validate them, transform them, and generate a report.

## Output

The utility generates a report file named `report.txt` in the current directory, containing:

- Summary statistics (mean, min, max for each value column).
- Validation results (number of valid/invalid records).
- Transformation results (transformed values).

## Dependencies

- Linux operating system (x86-64 architecture).
- GNU Assembler (gas).
- GNU C Compiler (gcc) for linking.

## License

This software is provided as-is, without warranty of any kind.
