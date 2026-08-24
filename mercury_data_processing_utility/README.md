# Mercury Data Processing Utility

This utility provides a set of tools for data ingestion, transformation, validation, and reporting in the Mercury programming language.

## Components

- **main.mr**: Entry point for the data processing pipeline.
- **ingester.mr**: Handles data ingestion from various sources.
- **transformer.mr**: Applies transformations to the ingested data.
- **validator.mr**: Validates the transformed data against predefined rules.
- **reporter.mr**: Generates reports based on the processed data.

## Usage

1. Ensure you have the Mercury compiler installed.
2. Compile the modules using the `mer` compiler.
3. Run the main module to execute the data processing pipeline.

## Example

To compile and run the utility:

```bash
merr main.mr
gen -m main main.exe
./main.exe
```
