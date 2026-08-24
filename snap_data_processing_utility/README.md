# Snap! Data Processing Utility

A modular data processing pipeline built using Snap!, a block-based visual programming language. This utility ingests, transforms, validates, and reports on data streams using visual block logic.

## Features
- Visual Drag-and-Drop Logic
- Data Ingestion from JSON/CSV
- Data Transformation & Filtering
- Validation & Error Handling
- Report Generation

## Usage
1. Open the `main.sb3` file in the Snap! IDE.
2. Run the `Start Pipeline` procedure.
3. Monitor the `Status Log` sprite for progress.
4. Check the `DataReporter` sprite for final outputs.

## Structure
- `main.sb3`: The main project file containing all sprite logic and extensions.
- `calculate_stats.snap`: Helper blocks for statistical calculations.
- `filter_nulls.snap`: Helper blocks for data cleansing.
- `pipeline.snap`: Core processing logic for ingestion and transformation.
- `validate_data.snap`: Helper blocks for data validation.

## License
MIT License
