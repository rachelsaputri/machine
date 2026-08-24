# Modula Data Processing Engine

## Overview

This is a robust, structured data processing utility written strictly in **Modula-2**.
It demonstrates core Modula-2 features such as module separation, type definitions, and procedural programming.

## Project Structure

- `README.md`: This documentation file.
- `DataTypes.Mod`: Defines the core structures and types used for data records.
- `Processor.Mod`: Contains the main logic for parsing and transforming the data.
- `Reporter.Mod`: Handles the output generation (simulated file output for standard Modula-2 compatibility).
- `Main.Mod`: The entry point that orchestrates the pipeline.

## Compilation

Requires a standard Modula-2 compiler (e.g., gmpl, PM2, or Modula-2 Studio).

```bash
gmpl -c DataTypes.Mod
gmpl -c Processor.Mod
gmpl -c Reporter.Mod
gmpl -c Main.Mod
gmpl -o data_engine Main.Mod
```

## Usage

Run the compiled binary to process the embedded sample dataset.

## Features

- **Type Safety**: Strongly typed records for data integrity.
- **Modular Design**: Separation of concerns into distinct modules.
- **Standard Compliance**: Adheres to the Modula-2 language standard.
