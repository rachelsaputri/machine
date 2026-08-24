# Visual Prolog Data Processing Utility

A complete, functional data processing utility implemented in Visual Prolog. This system handles data ingestion, validation, transformation, and reporting with full type safety and declarative logic.

## Features
- **Data Ingestion**: Load data from structured text files (CSV format).
- **Validation**: Ensure data integrity based on predefined schemas.
- **Transformation**: Apply business rules to transform records.
- **Reporting**: Generate formatted output files.

## Project Structure
- `domain.vp`: Defines data types and interfaces.
- `predicates.vp`: Core processing logic (parse, validate, transform).
- `interface.vp`: Public API for the processor.
- `main.vp`: Entry point for execution.

## Usage
1. Ensure you have Visual Prolog Community Edition installed.
2. Create a new Visual Prolog Project.
3. Add the provided source files to the project.
4. Add a sample data file named `input_data.csv` to the project directory.
5. Run the application.

## Sample Input (`input_data.csv`)
```
John Doe, 30, Engineer, Active
Jane Smith, 25, Designer, Inactive
Bob Johnson, 45, Manager, Active
```
