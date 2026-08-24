# Batch Data Processing Utility

A comprehensive, fully functional data processing utility written entirely in Batch (Windows/DOS). This script provides robust data manipulation capabilities including data ingestion, validation, transformation, and reporting without requiring any external dependencies beyond a standard Windows environment.

## Features

- **Data Ingestion**: Reads structured data from CSV files
- **Data Validation**: Checks data integrity and format compliance
- **Data Transformation**: Performs common data manipulations (trimming, case conversion, date formatting)
- **Data Reporting**: Generates summary reports and outputs processed data
- **Error Handling**: Comprehensive error handling with meaningful messages
- **Logging**: Detailed execution logging

## Requirements

- Windows 7 or later
- Command Prompt (cmd.exe)
- No external dependencies or installations required

## Usage

### Basic Usage

```batch
batch_data_processing_utility.bat [input_file] [output_file] [options]
```

### Parameters

- `input_file` - Path to the input CSV file (optional, defaults to "input.csv")
- `output_file` - Path to the output CSV file (optional, defaults to "output.csv")
- `options` - Processing options:
  - `--validate` - Only validate data without transforming
  - `--transform` - Apply default transformations
  - `--report` - Generate summary report
  - `--verbose` - Enable verbose output
  - `--help` - Display help information

### Examples

```batch
# Process a CSV file with default settings
batch_data_processing_utility.bat data.csv processed_data.csv

# Validate data only
batch_data_processing_utility.bat data.csv --validate

# Transform and generate report
batch_data_processing_utility.bat data.csv processed_data.csv --transform --report

# Verbose processing with custom settings
batch_data_processing_utility.bat data.csv processed_data.csv --verbose --transform --report
```

## Data Format

The utility expects CSV files with the following characteristics:
- First row contains headers
- Comma-separated values
- Standard encoding (UTF-8 or ASCII)

## Configuration

The utility can be configured by modifying the following variables at the top of the script:

- `MAX_LINE_LENGTH` - Maximum allowed line length (default: 8192)
- `MAX_ROWS` - Maximum number of rows to process (default: 100000)
- `DELIMITER` - Field delimiter (default: comma)
- `LOG_FILE` - Log file path (default: "processing.log")

## Output

The utility generates the following outputs:

- **Processed Data**: Output CSV file with transformed data
- **Report**: Summary report file (when --report is specified)
- **Log**: Execution log file

## Error Handling

The utility provides detailed error messages for common issues:
- File not found
- Invalid CSV format
- Data validation errors
- Permission denied
- Memory limits exceeded

## Notes

- This utility is designed for text-based data processing
- For large files, processing may take some time due to Batch language limitations
- All transformations are applied row by row to maintain memory efficiency
- The utility creates backup files for input data when processing

## License

This utility is provided as-is for educational and practical purposes.

## Contributing

Feel free to submit issues and enhancement requests.

## Author

Batch Data Processing Utility Team
