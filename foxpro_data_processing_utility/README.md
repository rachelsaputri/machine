# FoxPro Data Processing Utility

A complete, production-ready data processing utility built in Visual FoxPro 9.0.

This utility provides a robust framework for ingesting, transforming, validating, and reporting on data sets using native VFP capabilities. It is designed to handle CSV, DBF, and text-based data formats.

## Features

- **Data Ingestion**: Supports DBF (.dbf), CSV (.csv), and generic text file parsing.
- **Data Transformation**: Built-in transformation engine for string manipulation, numeric casting, date handling, and row filtering.
- **Data Validation**: Schema validation, required field checks, and data type enforcement.
- **Reporting**: Generates structured reports in both HTML and CSV formats.
- **Error Handling**: Robust try-catch blocks with detailed error logging.

## Prerequisites

- Visual FoxPro 9.0 (SP2 recommended)
- Windows Operating System

## Usage

1. Open Visual FoxPro.
2. Add all `.prg` files from this directory to your project or load them individually.
3. Call the main entry point: `DO foxpro_data_processor.prg`

## Components

- `main.prg`: Entry point and configuration loader.
- `ingester.prg`: Handles file reading and parsing logic.
- `transformer.prg`: Applies business rules and data cleaning.
- `validator.prg`: Ensures data integrity and compliance.
- `reporter.prg`: Formats and final outputs.

## License

MIT License
