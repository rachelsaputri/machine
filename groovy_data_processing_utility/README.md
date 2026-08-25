# Groovy Data Processing Utility

## Overview
A complete, production-ready data processing utility written in Groovy. It provides a modular pipeline for ingesting, validating, transforming, and reporting on data records.

## Features
- **Data Ingestion**: Reads data from standard input or files.
- **Validation**: Enforces schema and rule-based validation on records.
- **Transformation**: Applies configurable transformations to data.
- **Reporting**: Generates comprehensive reports on processing results.
- **Modular Design**: Easy to extend with new processors, validators, or transformers.

## Prerequisites
- Java Development Kit (JDK) 8 or higher
- Apache Groovy

## Usage

### 1. Compile the Code
Ensure you are in the `groovy_data_processing_utility` directory.
```bash
groovyc *.groovy
```

### 2. Run the Utility
Provide a JSON file containing your data records as an argument.
```bash
groovy Main.groovy input_data.json
```

### 3. Input Format
The input file should be a JSON array of objects. Example:
```json
[
  {"id": 1, "name": "Alice", "score": 85},
  {"id": 2, "name": "Bob", "score": 92},
  {"id": 3, "name": "Charlie", "score": 78}
]
```

### 4. Output
The utility will process the data and print a summary report to the console. Invalid records will be logged with specific error messages.

## Architecture
- `Main.groovy`: Entry point that orchestrates the pipeline.
- `DataIngestor.groovy`: Handles reading data from files or standard input.
- `DataValidator.groovy`: Validates records against predefined rules.
- `DataTransformer.groovy`: Transforms validated records (e.g., normalization, enrichment).
- `DataReporter.groovy`: Generates and displays processing reports.

## Extending the Utility
To add custom validation rules or transformations:
1. Implement the respective interface or extend the base class in the `groovy_data_processing_utility` directory.
2. Update the `Main.groovy` configuration to include your new processor.

## License
MIT
