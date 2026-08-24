#!/bin/bash

# TXL Source Code Structure Analyzer Runner
# Usage: ./run_analysis.sh [source_files...] [config_file]

set -e

# Default configuration
CONFIG_FILE="config.json"
OUTPUT_DIR="./output"
TXL_RULES_DIR="./"

# Parse arguments
SOURCE_FILES=("$@")
if [ ${#SOURCE_FILES[@]} -eq 0 ]; then
    echo "Usage: $0 [source_files...] [config_file]"
    echo "Example: $0 main.c utils.h config.json"
    exit 1
fi

# Check if config file was provided
if [ ${#SOURCE_FILES[@]} -gt 0 ]; then
    if [[ "${SOURCE_FILES[@]}" == *"config.json"* ]]; then
        CONFIG_FILE="config.json"
    else
        CONFIG_FILE="${SOURCE_FILES[${#SOURCE_FILES[@]}-1]}"
    fi
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo "Starting TXL Source Code Structure Analysis..."
echo "Config file: $CONFIG_FILE"
echo "Output directory: $OUTPUT_DIR"

# Run TXL analyzer for functions
echo "Analyzing functions..."
txl -i "$TXL_RULES_DIR/analyzer.txl" -o "$OUTPUT_DIR/functions_report.json" "${SOURCE_FILES[@]}" 2>/dev/null || echo "Warning: analyzer.txl execution failed."

# Run TXL reporter
echo "Generating structural report..."
txl -i "$TXL_RULES_DIR/reporter.txl" -o "$OUTPUT_DIR/structure_report.json" "$OUTPUT_DIR/functions_report.json" 2>/dev/null || echo "Warning: reporter.txl execution failed."

# Run TXL validator
echo "Validating structure..."
txl -i "$TXL_RULES_DIR/validate.txl" -o "$OUTPUT_DIR/validation_report.json" "$OUTPUT_DIR/structure_report.json" 2>/dev/null || echo "Warning: validate.txl execution failed."

echo "Analysis complete. Results saved to $OUTPUT_DIR"
echo "- Functions Report: $OUTPUT_DIR/functions_report.json"
echo "- Structure Report: $OUTPUT_DIR/structure_report.json"
echo "- Validation Report: $OUTPUT_DIR/validation_report.json"
