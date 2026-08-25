# Factor Data Processing Utility

A modular, high-performance data processing utility built using **Factor**, a concatenative, dynamically-typed, multi-paradigm programming language.

This utility provides a robust pipeline for ingesting, validating, transforming, and reporting on structured data (JSON, CSV, and custom delimited formats). It is designed for reliability and extensibility, leveraging Factor's word-based architecture for clear, composable logic.

## Features

- **Multi-format Support**: Natively handles JSON and CSV data streams.
- **Strict Validation**: Schema-aware validation for critical fields and data types.
- **Transformable Pipeline**: Easy-to-compose transformation logic.
- **Comprehensive Reporting**: Generates human-readable summary reports.
- **Extensible**: Modular design allows for easy addition of new words and stages.

## Prerequisites

- [Factor](https://factorcode.org/) installed and configured.
- `io` vocabulary (standard in Factor).
- `json` vocabulary (standard in Factor).
- `csv` vocabulary (standard in Factor, or installed via `factor-land` if not built-in).

## Usage

1. **Load the main vocabulary:**
   ```factor
   USING: factor-data-processing utility ;
   ```

2. **Process Data:**
   ```factor
   :> "path/to/data.json" load-data 
   validate-data 
   transform-data 
   generate-report
   ```

## Project Structure

- `factor_data_processing_utility.factor`: Main entry point and orchestration logic.
- `ingester.factor`: Handles data loading from various sources.
- `validator.factor`: Contains validation logic and error handling.
- `transformer.factor`: Applies data transformations.
- `reporter.factor`: Generates output reports.

## License

MIT License
