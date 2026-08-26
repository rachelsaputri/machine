"""
Data transformation module for the MillScript Data Processing Utility.
Transforms data according to specified rules.
"""

import {
    logInfo,
    logError
} from './core.ms';

function transformData(data, config) {
    logInfo("Transforming data...");
    // Simulate transformation: double the value and add a status field
    let transformedData = [];
    for (let item in data) {
        let newItem = {
            id: item.id,
            name: item.name,
            value: item.value * 2,
            status: "processed"
        };
        transformedData.push(newItem);
    }
    logInfo("Data transformation completed.");
    return transformedData;
}
