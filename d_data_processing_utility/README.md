# D Data Processing Utility

A comprehensive, production-ready data processing utility written in D.

## Features
- Modular architecture with separate modules for ingesting, transforming, validating, and reporting data.
- Supports JSON and CSV input formats.
- Configurable data transformation rules.
- Robust error handling and logging.
- Clean, idiomatic D code.

## Project Structure
- `main.d`: Entry point, argument parsing, and orchestration.
- `types.d`: Data structures and types used throughout the utility.
- `ingester.d`: Handles loading data from files (JSON/CSV).
- `transformer.d`: Applies transformation rules to the dataset.
- `validator.d`: Validates data against defined schemas/rules.
- `reporter.d`: Generates output reports in JSON and CSV formats.

## Usage

### Build
```bash
dub build
```

### Run
```bash
./d_data_processing_utility --input data.json --format json --transformers remove_empty,uppercase --output report.json
```

### Arguments
- `--input` (required): Path to the input data file.
- `--format` (optional): Format of the input data. Supported: `json`, `csv`. Default: `json`.
- `--transformers` (optional): Comma-separated list of transformer names to apply. Supported: `remove_empty`, `uppercase`, `lowercase`, `trim_whitespace`. Default: none.
- `--output` (required): Path for the output report file.
- `--report-format` (optional): Format of the output report. Supported: `json`, `csv`. Default: `json`.

## Available Transformers
- `remove_empty`: Removes fields with null or empty values.
- `uppercase`: Converts all string values to uppercase.
- `lowercase`: Converts all string values to lowercase.
- `trim_whitespace`: Trims leading and trailing whitespace from all string values.

## Contributing
Contributions are welcome. Please ensure all code follows the D style guide.

## License
MIT License
