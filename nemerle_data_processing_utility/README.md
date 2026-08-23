# Nemerle Data Processing Utility

A comprehensive data processing utility written in **Nemerle**, a multi-paradigm language that combines features of functional, object-oriented, and imperative programming.

## Features

- **Data Ingestion**: Reads data from various formats (CSV, JSON, Text).
- **Data Transformation**: Applies configurable transformations (mapping, filtering, cleaning).
- **Data Validation**: Validates data against schema or custom rules.
- **Data Reporting**: Generates summary reports of processed data.
- **Functional & OOP Hybrid**: Leverages Nemerle's unique strengths for robust data handling.

## Prerequisites

- **.NET SDK 6.0+** (or .NET Core 3.1+)
- **Nemerle Compiler**: Ensure `ncc` is available in your PATH.

## Building

```bash
ncc -target:exe -out:nemerle_data_processing_utility.exe main.n 
```

## Usage

```bash
./nemerle_data_processing_utility input.csv output.json
```

## Project Structure

- `main.n`: Entry point and orchestration.
- `ingestor.n`: Data ingestion logic.
- `transformer.n`: Data transformation logic.
- `validator.n`: Data validation logic.
- `reporter.n`: Data reporting logic.
- `models.n`: Data models and types.

## License

MIT License
