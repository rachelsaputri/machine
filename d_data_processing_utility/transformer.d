module transformer;

import std.algorithm;
import std.array;
import std.json;
import std.stdio;
import std.string;

import types;

/**
 * Applies a list of transformer names to the dataset.
 */
DataSet transformData(DataSet dataset, string[] transformerNames)
{
    DataSet result = dataset;
    
    foreach (name; transformerNames)
    {
        result = applyTransformer(result, name);
    }
    
    return result;
}

/**
 * Applies a single transformer to the dataset.
 */
DataSet applyTransformer(DataSet dataset, string name)
{
    return switch (name)
    {
        case "remove_empty":
            return removeEmptyFields(dataset);
        case "uppercase":
            return toUppercase(dataset);
        case "lowercase":
            return toLowercase(dataset);
        case "trim_whitespace":
            return trimWhitespace(dataset);
        default:
            throw new Exception("Unknown transformer: " ~ name);
    };
}

/**
 * Removes fields with null or empty values from all records.
 */
DataSet removeEmptyFields(DataSet dataset)
{
    DataRecord[] newRecords;
    
    foreach (record; dataset.records)
    {
        string[] newKeys;
        JSONValue[] newValues;
        
        foreach (i; 0..record.keys.length)
        {
            bool isEmpty = false;
            if (record.values[i].type == JNull)
            {
                isEmpty = true;
            }
            else if (record.values[i].type == JString)
            {
                auto str = record.values[i].string;
                if (str.strip().empty)
                {
                    isEmpty = true;
                }
            }
            
            if (!isEmpty)
            {
                newKeys ~= record.keys[i];
                newValues ~= record.values[i];
            }
        }
        
        newRecords ~= DataRecord(newKeys, newValues);
    }
    
    return DataSet(newRecords);
}

/**
 * Converts all string values to uppercase.
 */
DataSet toUppercase(DataSet dataset)
{
    DataRecord[] newRecords;
    
    foreach (record; dataset.records)
    {
        string[] newKeys = record.keys;
        JSONValue[] newValues;
        
        foreach (val; record.values)
        {
            if (val.type == JString)
            {
                newValues ~= JSONValue(toUpper(val.string));
            }
            else
            {
                newValues ~= val;
            }
        }
        
        newRecords ~= DataRecord(newKeys, newValues);
    }
    
    return DataSet(newRecords);
}

/**
 * Converts all string values to lowercase.
 */
DataSet toLowercase(DataSet dataset)
{
    DataRecord[] newRecords;
    
    foreach (record; dataset.records)
    {
        string[] newKeys = record.keys;
        JSONValue[] newValues;
        
        foreach (val; record.values)
        {
            if (val.type == JString)
            {
                newValues ~= JSONValue(toLower(val.string));
            }
            else
            {
                newValues ~= val;
            }
        }
        
        newRecords ~= DataRecord(newKeys, newValues);
    }
    
    return DataSet(newRecords);
}

/**
 * Trims leading and trailing whitespace from all string values.
 */
DataSet trimWhitespace(DataSet dataset)
{
    DataRecord[] newRecords;
    
    foreach (record; dataset.records)
    {
        string[] newKeys = record.keys;
        JSONValue[] newValues;
        
        foreach (val; record.values)
        {
            if (val.type == JString)
            {
                newValues ~= JSONValue(val.string.strip());
            }
            else
            {
                newValues ~= val;
            }
        }
        
        newRecords ~= DataRecord(newKeys, newValues);
    }
    
    return DataSet(newRecords);
}
