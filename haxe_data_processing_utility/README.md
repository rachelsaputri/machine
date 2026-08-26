# Haxe Data Processing Utility

A robust, type-safe data processing utility built with Haxe. This utility provides a modular pipeline architecture for ingesting, transforming, validating, and reporting on data records.

## Features
- **Modular Pipeline**: Distinct classes for Ingestion, Transformation, Validation, and Reporting.
- **Type Safety**: Leverages Haxe's strong typing system for reliable data handling.
- **Flexible Input**: Supports JSON and CSV-like string inputs.
- **Extensible**: Easy to add new transformation rules or validation logic.

## Prerequisites
- [Haxe Compiler](https://haxe.org/download/) (v4.2.5 or higher)
- [OpenFL](https://openfl.org/) or a compatible Haxe target setup (optional, for compilation examples)

## Installation

1. Clone the repository.
2. Navigate to the project directory.
3. Ensure Haxe is installed and added to your PATH.

## Usage

### Compile

To compile the utility to a JavaScript target (example):

```bash
haxe haxe_data_processing_utility.hxml
```

To compile to a Neko target:

```bash
haxe -main DataProcessor -neko output.n
```

### Run

Ensure you have a valid data source file (JSON or CSV format) and execute the main application.

## Architecture

- `DataTypes.hx`: Defines the core structures (`DataRecord`, `ProcessingConfig`, `ProcessingResult`).
- `DataIngestor.hx`: Handles reading raw data into memory.
- `DataTransformer.hx`: Applies business logic to modify records.
- `DataValidator.hx`: Ensures records meet specific criteria.
- `DataReporter.hx`: Generates summaries and final outputs.
- `DataProcessor.hx`: Orchestrates the pipeline.

## License

MIT
