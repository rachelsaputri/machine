# CL Compliance Data Processor

This directory contains a data processing utility written in CL (Control Language), primarily designed for IBM i (AS/400) environments. The utility is part of a larger ecosystem of compliance and data processing tools.

## Purpose
To process raw dataset records, validate them against predefined compliance schemas, transform them into audit-ready formats, and generate summary reports.

## Components
- `main.cl`: The entry point for the data processing job.
- `parser.cl`: Contains logic to parse raw input streams.
- `processor.cl`: Handles the core data transformation and business logic.
- `reporter.cl`: Generates formatted reports of the processed data.
- `validator.cl`: Validates data integrity and compliance.

## Usage
To run the processor, call the main module with appropriate parameters for input and output datasets.

## Dependencies
- IBM i OS
- Standard CL APIs (QCMDEXC, QUSRMBRD, etc.)

## License
Internal Use Only
