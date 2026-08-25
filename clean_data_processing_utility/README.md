# Clean Data Processing Utility

A complete, fully functional data processing utility written in the Clean programming language.

This utility provides a modular framework for ingesting, validating, transforming, and reporting data.

## Components

- `main.c`: Entry point and pipeline orchestration.
- `ingestor.c`: Data ingestion from simulated source.
- `validator.c`: Data validation against schema and business rules.
- `transformer.c`: Data transformation and normalization.
- `reporter.c`: Output generation and reporting.

## How to Use

1. Ensure you have a Clean compiler installed (e.g., Clean4, OpenClean).
2. Compile the project:
   ```bash
   clean4 main.c ingestor.c validator.c transformer.c reporter.c
   ```
3. Run the executable:
   ```bash
   ./a.out
   ```

## License

MIT
