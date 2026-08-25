# Easy PL/I Data Processing Utility

A complete, production-ready data processing utility written in Easy PL/I. This tool handles the full data pipeline lifecycle: ingestion, transformation, validation, and reporting.

## Features
- Data Ingestion: Reads structured data from input sources.
- Data Transformation: Applies standardization and cleaning rules.
- Data Validation: Ensures data integrity and schema compliance.
- Reporting: Generates summary reports and exports results.

## Usage
Compile with a standard Easy PL/I compiler and run the main program:
```
epli main.pli
main
```

## Components
- `main.pli`: Entry point, orchestrates the pipeline.
- `parser.pli`: Handles data ingestion and parsing.
- `transformer.pli`: Applies transformation rules.
- `validator.pli`: Validates data against schemas.
- `reporter.pli`: Generates output reports.
- `processor.pli`: Core processing logic.
