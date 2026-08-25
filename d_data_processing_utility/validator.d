module validator;

import std.stdio;
import std.string;
import std.json;
import std.algorithm;
import std.array;

import types;

/**
 * Validates all records in the dataset.
 * Basic validations:
 * - Records must not be completely empty (no fields at all).
 * - If a field exists, it should not be null (after remove_empty, this might be redundant, but good for completeness).
 * - String fields should not contain only whitespace (again, after trim_whitespace).
 * 
 * In a real application, you would load a schema and validate against it.
 * For this utility, we perform basic sanity checks.
 */
ValidationResult validateData(DataSet dataset)
{
    string[] errors;
    string[] warnings;
    
    foreach (i; 0..dataset.records.length)
    {
        auto record = dataset.records[i];
        
        // Check if record has at least one field
        if (record.keys.empty)
        {
            errors ~= "Record at index ".format(i, " has no fields.");
            continue;
        }
        
        // Check for null values in fields
        foreach (j; 0..record.keys.length)
        {
            if (record.values[j].type == JNull)
            {
                warnings ~= "Record at index ".format(i, " has a null value for field \'\'.").format(record.keys[j]);
            }
        }
        
        // Check for empty strings in fields
        foreach (j; 0..record.keys.length)
        {
            if (record.values[j].type == JString)
            {
                if (record.values[j].string.strip().empty)
                {
                    warnings ~= "Record at index ".format(i, " has an empty string value for field \'\'.").format(record.keys[j]);
                }
            }
        }
    }
    
    return ValidationResult(errors, warnings);
}
