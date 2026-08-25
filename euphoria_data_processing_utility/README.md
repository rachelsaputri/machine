# Euphoria Data Processing Utility

A complete, modular, and fully functional data processing utility built in Euphoria.

## Features
- **Data Ingestion**: Reads CSV and text-based datasets.
- **Data Validation**: Checks row counts, data types, and missing values.
- **Data Transformation**: Supports normalization, filtering, and field extraction.
- **Data Reporting**: Generates structured statistical reports.
- **Execution**: Simple, script-driven entry point.

## Requirements
- Euphoria 4.x or higher

## Usage

### 1. Prepare Data
Create a `data.csv` file in the same directory:
```csv
id,name,score,status
1,Alice,85.5,active
2,Bob,92.0,active
3,Charlie,78.2,inactive
4,Diana,88.9,active
5,Eve,65.4,inactive
```

### 2. Run Utility
```bash
eui main.e
```

## Architecture
- `main.e`: Entry point and orchestration.
- `types.e`: Structure definitions for rows and records.
- `ingester.e`: Logic for loading files into memory.
- `validator.e`: Checks data integrity.
- `transformer.e`: Modifies data (filtering/normalizing).
- `reporter.e`: Generates analysis reports.
