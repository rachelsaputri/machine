"""
Main entry point for the MillScript Data Processing Utility.
This script orchestrates the data processing pipeline.
"""

import {
    loadConfig,
    logInfo,
    logError,
    exitSuccess,
    exitFailure
} from './core.ms';

import {
    ingestData
} from './ingester.ms';

import {
    validateData
} from './validator.ms';

import {
    transformData
} from './transformer.ms';

import {
    generateReport
} from './reporter.ms';

// Define the main function
function main() {
    let configPath = './config.json';
    let inputDataPath = './input_data.json';
    let outputReportPath = './output_report.json';

    // Load configuration
    logInfo("Loading configuration...");
    let config = loadConfig(configPath);
    if (config == null) {
        logError("Failed to load configuration. Exiting.");
        exitFailure(1);
    }

    // Ingest Data
    logInfo("Ingesting data...");
    let rawData = ingestData(inputDataPath, config);
    if (rawData == null) {
        logError("Data ingestion failed. Exiting.");
        exitFailure(1);
    }

    // Validate Data
    logInfo("Validating data...");
    let isValid = validateData(rawData, config);
    if (!isValid) {
        logError("Data validation failed. Exiting.");
        exitFailure(1);
    }

    // Transform Data
    logInfo("Transforming data...");
    let transformedData = transformData(rawData, config);
    if (transformedData == null) {
        logError("Data transformation failed. Exiting.");
        exitFailure(1);
    }

    // Generate Report
    logInfo("Generating report...");
    let reportSuccess = generateReport(transformedData, outputReportPath, config);
    if (!reportSuccess) {
        logError("Report generation failed. Exiting.");
        exitFailure(1);
    }

    logInfo("Data processing completed successfully.");
    exitSuccess();
}

// Execute main function
main();
