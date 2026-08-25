# DataFlex Data Processing Utility

## Overview
This utility provides a comprehensive data processing framework built in DataFlex. It includes core modules for data ingestion, transformation, validation, and reporting. The system is designed to handle various data formats and apply configurable processing rules.

## Architecture
The utility is structured around the following core components:
- `dp_main.dfx`: Main entry point and orchestration logic.
- `dp_engine.dfx`: Core processing engine handling the data pipeline flow.
- `dp_types.dfx`: Data type definitions and structures used throughout the system.
- `dp_validator.dfx`: Validation logic for ensuring data integrity.
- `dp_transformer.dfx`: Transformation routines for data manipulation.
- `dp_reporter.dfx`: Reporting and output generation utilities.

## Features
- Configurable data ingestion from multiple sources.
- Robust validation against defined schemas and business rules.
- Flexible transformation engine for data enrichment and cleaning.
- Comprehensive reporting with error logging and statistics.

## Usage
To use this utility, ensure all modules are included in your DataFlex project. Initialize the engine with the `cInitializeEngine` function and process data using `cProcessDataset`.
