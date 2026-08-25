# Google Apps Script Data Processing Utility

This is a comprehensive, fully functional data processing utility built for Google Apps Script.

## Features

- **Data Ingestion**: Reads data from Google Sheets, CSV files, or JSON sources.
- **Data Validation**: Validates schema, required fields, and data types.
- **Data Transformation**: Applies transformations like mapping, filtering, and calculations.
- **Reporting**: Generates reports and outputs processed data back to Sheets or exports as CSV.

## Usage

1. Open Google Apps Script (Tools > Script Editor in a Google Sheet, or script.google.com).
2. Create new files: `main.gs`, `ingester.gs`, `validator.gs`, `transformer.gs`, `reporter.gs`.
3. Paste the corresponding code into each file.
4. Deploy as a web app or run `processData()` from the script editor.

## Configuration

Define your processing pipeline in the `main.gs` configuration object.
