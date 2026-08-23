# R Data Processing Utility

A complete, production-ready data processing utility written in R.

## Features

- Data Ingestion: Load CSV, JSON, and Parquet files.
- Data Transformation: Clean, filter, and aggregate data using `dplyr` and `tidyr`.
- Data Validation: Schema validation and outlier detection.
- Reporting: Generate summary statistics and export results.

## Prerequisites

- R >= 4.0.0
- `tidyverse`, `jsonlite`, `arrow`, `readr`, `readxl`, `openxlsx`, `stringr`, `lubridate`, `zoo`, `checkmate`, `data.table` packages.

## Installation

1. Install R from [https://cran.r-project.org/](https://cran.r-project.org/).
2. Install required packages:
   ```bash
   Rscript install_packages.R
   ```

## Usage

### Basic Processing

```r
library(r_data_processing_utility)

# Load data
df <- load_data("input.csv")

# Transform data
df_clean <- clean_data(df, columns = c("name", "value"))

# Validate data
valid <- validate_data(df_clean, schema = list(name = "character", value = "numeric"))

# Generate report
report <- generate_report(df_clean)
print(report)
```

### Command Line

```bash
Rscript main.R --input data.csv --output report.csv --clean true
```

## Structure

- `loader.R`: Functions for loading data from various formats.
- `transformer.R`: Functions for cleaning and transforming data.
- `validator.R`: Functions for validating data integrity.
- `reporter.R`: Functions for generating reports.
- `main.R`: Entry point for CLI usage.
- `install_packages.R`: Script to install dependencies.

## License

MIT
