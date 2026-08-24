# VBR Data Processing Utility

A robust, production-ready data processing utility written in Visual Basic .NET (`.vbr`).

## Features

- **Ingestor**: Reads data from JSON and CSV sources with automatic schema detection.
- **Processor**: Performs data normalization, type coercion, and basic statistical aggregation.
- **Validator**: Enforces data integrity rules, type checking, and constraint validation.
- **Reporter**: Generates comprehensive summaries and validation reports.
- **Transformer**: Applies custom mapping and transformation logic to datasets.

## Prerequisites

- .NET 6.0 or later SDK
- Visual Studio 2022 or VS Code with C#/VB extensions

## Build & Run

```bash
# Clone the repository
git clone <repository-url>
cd vbr_data_processing_utility

# Build the project
dotnet build

# Run the utility
dotnet run --project src/vbr_data_processing_utility.vbproj
```

## Usage

The utility can be run via the command line with the following arguments:

- `--input <path>`: Path to the input data file (JSON or CSV).
- `--output <path>`: Path to the output report file (JSON).
- `--mode <mode>`: Processing mode (`validate`, `transform`, `full`). Default is `full`.

## Project Structure

- `src/`: Contains the main Visual Basic .NET source code.
- `tests/`: Contains unit tests for core components.
- `README.md`: This file.

## License

MIT License
