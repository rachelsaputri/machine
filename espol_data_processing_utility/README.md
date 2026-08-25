# ESPOL Data Processing Utility

A complete, production-ready data processing utility written in ESPOL. This utility provides a modular pipeline for ingesting, transforming, validating, and reporting on data sets.

## Features
- **Modular Architecture**: Separated concerns into distinct modules (ingestor, transformer, validator, reporter).
- **Robust Validation**: Schema-based validation with detailed error reporting.
- **Flexible Transformation**: Configurable data transformation rules.
- **Rich Reporting**: Generates comprehensive reports on processed data and validation results.

## Project Structure
- `main.espol`: Entry point of the application.
- `ingester.espol`: Handles data ingestion from various sources.
- `transformer.espol`: Processes and transforms raw data.
- `validator.espol`: Validates data against defined schemas.
- `reporter.espol`: Generates reports and outputs results.

## Usage
Run the main script to execute the pipeline:
```bash
espol main.espol
```

## License
MIT License
