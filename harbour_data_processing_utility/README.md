# Harbour Data Processing Utility

This repository contains a comprehensive data processing utility written in Harbour (xHarbour/Xailer compatible).

## Features
- **Data Ingestion**: Reads data from various sources (files, CSV, simple text).
- **Validation**: Ensures data integrity and format compliance.
- **Transformation**: Applies rules to clean and transform data.
- **Reporting**: Generates summary reports of processing results.

## Project Structure
- `main.prw`: Main entry point and application logic.
- `config.prg`: Configuration management.
- `data_ingester.prg`: Handles data loading.
- `data_validator.prg`: Validates data against schemas.
- `data_transformer.prg`: Transforms raw data.
- `data_reporter.prg`: Generates final reports.

## Usage
Compile the project using the Harbour compiler:
```
xharbour main.prw config.prg data_ingester.prg data_validator.prg data_transformer.prg data_reporter.prg
```

Run the resulting executable:
```
./main
```

## License
MIT
