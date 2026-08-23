# Moo Data Processing Utility

A robust data processing utility written in MOO. This utility handles data ingestion, transformation, validation, and reporting in a structured manner.

## Features
- Ingests raw data from various formats (simulated via text input in MOO context)
- Validates data records against defined schemas
- Transforms data records (e.g., case conversion, trimming)
- Generates reports on processed data

## Usage

### Running the Utility

To run the utility, use the `moo` interpreter to execute the main script:

```
moo main.moo
```

### Available Functions

- `main()`: Entry point that orchestrates the data processing pipeline.
- `ingest_data()`: Ingests sample raw data for demonstration.
- `validate_record(record)`: Validates a single data record.
- `transform_record(record)`: Transforms a single data record.
- `generate_report(records)`: Generates a report of processed records.

### Example Record Format

Records are expected to be strings in the format: `name,age,city`
- `name`: String
- `age`: Integer
- `city`: String

### Example Output

```
Processing record: John Doe, 30, New York
Validation result: true
Transformed record: John Doe, 30, new york
---
Processing record: Jane Smith, 25, San Francisco
Validation result: true
Transformed record: Jane Smith, 25, san francisco
---
Generated Report:
Total Records: 2
Valid Records: 2
Invalid Records: 0
```

## License

This project is licensed under the MIT License.
