# Mary Data Processing Utility

A robust and functional data processing utility written in **Mary**. 

## Features
- **Ingestion**: Reads raw data from standard input or files.
- **Validation**: Checks data structure and types.
- **Transformation**: Applies mapping and cleaning rules.
- **Reporting**: Generates summary statistics and output logs.

## Usage
1. Ensure `mary` interpreter is installed and in your PATH.
2. Run the main module: `mary main.mry`
3. Configure settings in `config.mry` as needed.

## Directory Structure
- `main.mry`: Entry point.
- `parser.mry`: Input parsing logic.
- `processor.mry`: Core transformation logic.
- `validator.mry`: Data integrity checks.
- `reporter.mry`: Output generation.
- `config.mry`: Configuration constants.
