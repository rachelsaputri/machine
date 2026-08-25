# COBOL Data Processing Utility

This is a complete, production-ready data processing utility written in COBOL (Common Business-Oriented Language).

## Features

- **Data Ingestion**: Reads data from flat files (CSV or fixed-width).
- **Validation**: Checks for data integrity and format compliance.
- **Transformation**: Applies business rules to transform data.
- **Reporting**: Generates summary reports of processed data.
- **Error Handling**: Comprehensive error handling with detailed logging.

## File Structure

- `main.cbl`: Main entry point and control flow.
- `ingester.cbl`: Handles reading and parsing input data files.
- `validator.cbl`: Validates data against defined rules.
- `transformer.cbl`: Transforms data according to business logic.
- `reporter.cbl`: Generates output reports and logs.
- `config.json`: Configuration file (optional, can be hardcoded).

## Usage

1. Ensure you have a COBOL compiler installed (e.g., GnuCOBOL).
2. Compile the files:
   ```bash
   cobc -x -free main.cbl ingester.cbl validator.cbl transformer.cbl reporter.cbl -o data_processor
   ```
3. Run the utility:
   ```bash
   ./data_processor
   ```

## Configuration

Edit `config.json` or modify the constants in `main.cbl` to adjust:
- Input file path
- Output file path
- Validation rules
- Transformation rules

## Example Input

A sample CSV file (`input.csv`):
```
ID,Name,Amount,Date
1,Item1,100.00,2023-01-01
2,Item2,200.00,2023-01-02
```

## License

MIT License
