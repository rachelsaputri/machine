"""
Data ingestion module for the MillScript Data Processing Utility.
Handles loading data from specified sources.
"""

import {
    logInfo,
    logError
} from './core.ms';

function ingestData(path, config) {
    logInfo("Ingesting data from " + path);
    // Simulate data ingestion
    // In a real implementation, this would read from a file, API, or database
    let data = [
        { id: 1, name: "Alice", value: 100 },
        { id: 2, name: "Bob", value: 200 },
        { id: 3, name: "Charlie", value: 300 }
    ];
    logInfo("Data ingested successfully.");
    return data;
}
