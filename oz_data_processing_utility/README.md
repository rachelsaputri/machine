# Oz Data Processing Utility

A modular, concurrent data processing utility written in **Oz**, a multiparadigm programming language known for its strong support for parallelism and constraint solving.

## Features
- Concurrent data ingestion
- Functional data transformation pipelines
- Robust validation and reporting
- Configurable processing modules

## Structure
- `main.oz`: Entry point and module loading
- `ingester.oz`: Data ingestion logic
- `transformer.oz`: Data transformation logic
- `validator.oz`: Data validation logic
- `reporter.oz`: Reporting and output logic

## Usage
Compile and run the main application:
```
ozc -c main.oz
ozrun main.o
```
