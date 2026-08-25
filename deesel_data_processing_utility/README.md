# Deesel Data Processing Utility

A fully functional data processing utility written in the Deesel programming language. This utility provides a complete pipeline for ingesting, validating, transforming, and reporting data.

## Features

- **Data Ingestion**: Reads structured data from CSV-like formats.
- **Validation**: Ensures data integrity and schema compliance.
- **Transformation**: Applies configurable transformations to data records.
- **Reporting**: Generates summary reports of processed data.
- **Modular Design**: Clean separation of concerns with dedicated modules for each pipeline stage.

## Usage

To run the utility, compile and execute the main module:

```bash
deesel run main.ds
```

## Modules

- `main.ds`: Entry point and pipeline orchestration.
- `ingester.ds`: Handles raw data input and parsing.
- `validator.ds`: Schema validation and error checking.
- `transformer.ds`: Data transformation logic.
- `reporter.ds`: Output generation and reporting.

## License

MIT License
