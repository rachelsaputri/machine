"""
Data validation module for the MillScript Data Processing Utility.
Validates ingested data against rules or schemas.
"""

import {
    logInfo,
    logError
} from './core.ms';

function validateData(data, config) {
    logInfo("Validating data...");
    // Simple validation: check if data is an array and not empty
    if (!isArray(data) || length(data) == 0) {
        logError("Validation failed: Data is empty or not an array.");
        return false;
    }
    // Check for required fields in each item
    for (let item in data) {
        if (!hasProperty(item, 'id') || !hasProperty(item, 'name') || !hasProperty(item, 'value')) {
            logError("Validation failed: Item missing required fields.");
            return false;
        }
        if (typeof(item.value) != 'number') {
            logError("Validation failed: Item value is not a number.");
            return false;
        }
    }
    logInfo("Data validation passed.");
    return true;
}

function isArray(obj) {
    return type(obj) == 'array';
}

function length(arr) {
    return arr.length;
}

function hasProperty(obj, prop) {
    return obj.hasOwnProperty(prop);
}

function typeof(obj) {
    return type(obj);
}
