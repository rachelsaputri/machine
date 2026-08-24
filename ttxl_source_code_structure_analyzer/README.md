# TXL Source Code Structure Analyzer

This project provides a complete, fully functional source code structure analyzer built strictly in TXL. It parses input source files, extracts structural components (functions, classes, variables, control structures), and outputs a detailed dependency graph and structural report.

## Features
- Parses multiple source code languages via configurable TXL grammar rules.
- Extracts functions, classes, variables, and control flow.
- Generates structural dependency reports in JSON format.
- Validates structural consistency across modules.

## Usage
1. Ensure TXL is installed and accessible in your system PATH.
2. Provide your source code files and a matching TXL grammar.
3. Run the analyzer script to generate the structural report.

## Files
- `analyzer.txl`: The main TXL grammar and transformation rules.
- `reporter.txl`: TXL rules for generating the structural report.
- `validate.txl`: TXL rules for structural consistency validation.
- `run_analysis.sh`: Bash script to execute the analyzer against source files.
