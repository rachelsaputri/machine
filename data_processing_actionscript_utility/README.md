# Data Processing Utility (ActionScript)

This repository contains a modular, reusable utility for processing, transforming, validating, and exporting data, written strictly in ActionScript 3.0.

## Overview

The `data_processing_actionscript_utility` package provides a robust foundation for handling data pipelines within Flash/AIR applications or server-side ActionScript environments. It separates concerns into distinct components for data ingestion, validation, transformation, and export.

## Components

- **DataProcessor**: The main orchestrator class. It holds the data, applies filters, runs transformations, and manages export operations.
- **DataTransformer**: Handles the actual transformation logic, applying provided functions to data items or entire arrays.
- **DataValidator**: Ensures data integrity. It validates arrays, objects, and can optionally check against a basic schema structure.
- **DataExporter**: Standardizes the output of processed data into different formats (Object or JSON).
- **DataTypes**: Utility class containing constants for data type identification.
- **DataProcessorUnit**: A higher-level wrapper class that bundles the processor with a specific name, making it easy to manage multiple data pipelines concurrently.

## Usage Example

```actionscript
import data_processing_actionscript_utility.DataProcessor;
import data_processing_actionscript_utility.DataProcessorUnit;

// Create a unit with initial data
var initialData:Array = [
    { id: 1, value: "foo", active: true },
    { id: 2, value: "bar", active: false },
    { id: 3, value: "baz", active: true }
];

var unit:DataProcessorUnit = new DataProcessorUnit("MainPipeline", initialData);

// Define a transform function
target = function(item:Object):Object {
    item.value = item.value.toUpperCase();
    item.computed = item.id * 2;
    return item;
}

// Define a filter function
criteria = function(item:Object):Boolean {
    return item.active == true;
}

// Run the pipeline
var results:Array = unit.runPipeline(transformFunction, filterFunction);

// Export results
var exportedData:Object = unit.exportResults("json");
trace(exportedData);
```

## Installation

Simply copy the `.as` files from this directory into your project's source folder and ensure the package structure matches (`data_processing_actionscript_utility`).

## Dependencies

- Flash Player 10+ or Adobe AIR 1.5+ (for JSON support)
- Standard ActionScript 3.0 Language Reference

## License

MIT
