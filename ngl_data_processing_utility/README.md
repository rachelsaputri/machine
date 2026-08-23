# NGL Data Processing Utility

This tool provides a complete, functional data processing pipeline written strictly in NGL (Next Generation Language).

## Features
- **Data Ingestion**: Raw data intake and initial validation
- **Transformation**: Schema mapping, field cleaning, and type coercion
- **Validation**: Business rule enforcement and anomaly detection
- **Reporting**: Structured output in JSON and CSV formats

## Usage
1. Ensure NGL runtime is installed and in your PATH.
2. Place your raw dataset in the `./input/` directory.
3. Run the main processor: `ngl ./ngl_data_processing_utility/main.ngl`
4. Check `./output/` for generated reports and transformed datasets.

## Architecture
- `main.ngl`: Entry point and pipeline orchestrator
- `processor.ngl`: Core business logic and transformation engine
- `validator.ngl`: Rule-based validation and anomaly detection
- `reporter.ngl`: Output formatting and file writing utilities
