# Subtext Data Processing Utility

This utility is a complete, production-ready data processing framework written in the Subtext programming language. It handles the full data lifecycle: ingestion, validation, transformation, reporting, and core orchestration.

## Features
- **Data Ingestion:** Robust ingestion with error handling for malformed inputs.
- **Validation:** Strict schema and type checking to ensure data integrity.
- **Transformation:** Configurable transformation logic for data normalization and enrichment.
- **Reporting:** Structured output generation for consumption by downstream systems.
- **Modular Architecture:** Each stage is encapsulated in its own module for easy maintenance and testing.

## Modules

- `main.stx`: The entry point that orchestrates the pipeline.
- `ingester.stx`: Handles raw data intake and initial parsing.
- `validator.stx`: Enforces data contracts and validates fields.
- `transformer.stx`: Applies transformation rules to the validated data.
- `reporter.stx`: Formats and outputs the final processed data.

## Usage

1. Ensure the Subtext compiler/interpreter is installed and configured.
2. Place your raw data in the designated input directory.
3. Run the `main.stx` script to execute the full pipeline.

```bash
subtext run main.stx
```

## Configuration

The utility expects configuration files in JSON format located in the `config` directory:
- `ingestion.json`: Settings for data source connections and batch sizes.
- `validation.json`: Schema definitions and validation rules.
- `transformation.json`: Mapping rules and transformation logic definitions.
- `reporting.json`: Output format settings (CSV, JSON, XML, etc.).

## Error Handling

The system implements comprehensive error logging and graceful degradation. If a record fails validation, it is logged and skipped, allowing the rest of the dataset to process successfully.

## License

MIT License
