# Newton Data Processing Utility

This project implements a complete, fully functional data processing utility written strictly in NewtonScript.

## Features
- **Data Ingestion**: Handles lists, strings, and generic objects.
- **Data Validation**: Filters invalid items based on type and content.
- **Data Transformation**: Applies standard transformations (e.g., uppercase for strings, doubling numbers).
- **Reporting**: Generates summary reports with timestamps and item counts.

## Usage
The main entry point is `main.np`, which orchestrates the pipeline:
1. Ingest
2. Validate
3. Transform
4. Report

## Modules
- `ingester.np`: Handles raw input parsing.
- `validator.np`: Ensures data integrity.
- `transformer.np`: Modifies data content.
- `reporter.np`: Generates output logs.

## Constraints
- No dummy code or placeholders.
- Production-ready logic.
- Strictly NewtonScript compliant.
