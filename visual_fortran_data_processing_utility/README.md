# Visual Fortran Data Processing Utility

A complete, production-ready data processing utility written in Visual Fortran.

## Features

- **Data Ingestion**: Reads structured text files with configurable delimiters
- **Validation**: Checks data types, ranges, and structural integrity
- **Transformation**: Applies mathematical and string transformations to datasets
- **Reporting**: Generates summary statistics and formatted output reports
- **Configuration**: External JSON-like configuration for pipeline settings

## Requirements

- Visual Studio (for Intel Fortran compiler `ifort` or `fortcom`)
- Fortran 95 compatible

## Usage

### Build

```bash
ifort main.f90 data_types.f90 parser.f90 transformer.f90 validator.f90 reporter.f90 -o dp_utility.exe
```

### Run

```bash
dp_utility.exe config.json input_data.txt output_report.txt
```

## File Structure

- `main.f90` - Entry point and pipeline orchestration
- `data_types.f90` - Module defining data structures
- `parser.f90` - File I/O and parsing logic
- `validator.f90` - Data validation rules
- `transformer.f90` - Data transformation operations
- `reporter.f90` - Report generation and statistics
- `config.json` - Example configuration file

## Configuration

The utility reads a configuration file in JSON format:

```json
{
  "input_delimiter": ",",
  "header_row": true,
  "transformations": [
    {"column": 1, "type": "normalize"},
    {"column": 2, "type": "round", "precision": 2}
  ],
  "validation_rules": [
    {"column": 1, "type": "numeric"},
    {"column": 2, "type": "range", "min": 0.0, "max": 1.0}
  ]
}
```

## License

MIT License
