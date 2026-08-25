# NQC Data Processing Utility

## Overview
This project implements a robust data processing utility using **Not Quite C (nqc)**. It is designed to handle data ingestion, transformation, validation, and reporting within constrained embedded environments where standard C libraries may be limited.

## Features
- **Data Ingestion**: Reads raw data from input streams or files.
- **Validation**: Ensures data integrity and format compliance.
- **Transformation**: Applies configurable transformations to data records.
- **Reporting**: Generates summary reports and statistics.

## Structure
- `main.nqc`: Entry point and main control loop.
- `ingester.nqc`: Handles data ingestion logic.
- `processor.nqc`: Core data processing and transformation logic.
- `reporter.nqc`: Generates output reports.

## Usage
Compile the project using the standard Not Quite C compiler.
```bash
nqc main.nqc
```

## Configuration
Edit `config.cfg` to set input/output paths and processing parameters.

## License
MIT License
