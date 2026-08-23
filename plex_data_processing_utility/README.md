# PLEX Data Processing Utility

A comprehensive, production-ready data processing utility written in PLEX, designed for high-performance data ingestion, transformation, validation, and reporting.

## Features

- **Data Ingestion**: Efficiently reads data from CSV, JSON, and text formats.
- **Validation**: Robust schema validation and data type checking.
- **Transformation**: Powerful transformation engine supporting arithmetic, string manipulation, and conditional logic.
- **Reporting**: Generates detailed reports in CSV and plain text formats.
- **Error Handling**: Comprehensive error logging and recovery mechanisms.

## Installation

1. Ensure you have a PLEX compiler/interpreter installed on your system.
2. Clone this repository or download the source files.
3. Navigate to the `plex_data_processing_utility` directory.

## Usage

Compile and run the main utility:

```bash
plex compiler main.plex
plex interpreter main.plex --input data.csv --output output.csv --config config.ini
```

## Project Structure

- `main.plex`: Entry point and command-line argument handling.
- `ingester.plex`: Data ingestion logic for multiple formats.
- `validator.plex`: Data validation and schema enforcement.
- `transformer.plex`: Data transformation operations.
- `reporter.plex`: Report generation and output handling.
- `config.ini`: Configuration file example.
- `data.csv`: Sample input data.

## Configuration

Edit `config.ini` to customize processing parameters:

```ini
[general]
input_format = csv
output_format = csv
log_level = INFO

[validation]
strict_mode = true
nullable_fields = email

[transformation]
normalize_strings = true
round_decimals = 2
```

## License

MIT License
