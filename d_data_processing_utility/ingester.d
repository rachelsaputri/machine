module ingester;

import std.file;
import std.json;
import std.stdio;
import std.string;
import std.array;
import std.exception;
import std.conv;

import types;

/**
 * Reads a JSON file and returns a DataSet.
 * Assumes the file contains an array of objects.
 */
DataSet ingestJSON(string filePath)
{
    enforce(fileExists(filePath), "Input file does not exist: " ~ filePath);

    auto content = readFile(filePath);
    JSONValue jsonValue;
    try
    {
        jsonValue = parseJSON(cast(const(char)[] content));
    }
    catch (JSONException e)
    {
        throw new Exception("Failed to parse JSON file \'\': ".format(filePath, e.msg));
    }

    enforce(jsonValue.type == JObject, "Expected a JSON object at the root level.");
    
    DataSet dataset;
    
    // Check if it's an array of objects
    if (jsonValue.type == JArray)
    {
        auto arr = jsonValue.array;
        foreach (obj; arr)
        {
            enforce(obj.type == JObject, "Expected each element in the array to be a JSON object.");
            auto objMap = obj.object;
            if (objMap.empty)
                continue; // Skip empty objects
                
            string[] keys;
            JSONValue[] values;
            
            foreach (pair; objMap)
            {
                keys ~= pair.key;
                values ~= pair.value;
            }
            
            dataset.records ~= DataRecord(keys, values);
        }
    }
    else
    {
        // Single object
        auto objMap = jsonValue.object;
        if (objMap.empty)
            return dataset;
            
        string[] keys;
        JSONValue[] values;
        
        foreach (pair; objMap)
        {
            keys ~= pair.key;
            values ~= pair.value;
        }
        
        dataset.records ~= DataRecord(keys, values);
    }

    return dataset;
}

/**
 * Reads a CSV file and returns a DataSet.
 * Assumes the first row contains headers.
 */
DataSet ingestCSV(string filePath)
{
    enforce(fileExists(filePath), "Input file does not exist: " ~ filePath);

    auto content = cast(string) readFile(filePath);
    auto lines = content.split("\n");
    
    if (lines.empty || lines[0].strip().empty)
    {
        return DataSet([]);
    }

    // Parse headers
    auto headers = lines[0].split(",").map!(a => a.strip()).array;
    
    DataSet dataset;
    
    // Parse each data line
    foreach (line; lines[1..$])
    {
        auto strippedLine = line.strip();
        if (strippedLine.empty)
            continue;
            
        auto values = strippedLine.split(",").map!(a => a.strip()).array;
        
        if (values.length != headers.length)
        {
            // Try to handle cases with fewer values by padding with null
            if (values.length < headers.length)
            {
                values ~= repeat(JSONValue(null), headers.length - values.length).array;
            }
            else
            {
                // More values than headers, truncate
                values = values[0..headers.length];
            }
        }
        
        // Convert string values to appropriate JSON types
        JSONValue[] jsonValues;
        foreach (val; values)
        {
            if (val == "")
            {
                jsonValues ~= JSONValue(null);
            }
            else
            {
                // Try to parse as number
                int intVal;
                double doubleVal;
                if (to!int(val, intVal))
                {
                    jsonValues ~= JSONValue(intVal);
                }
                else if (to!double(val, doubleVal))
                {
                    jsonValues ~= JSONValue(doubleVal);
                }
                else
                {
                    jsonValues ~= JSONValue(val);
                }
            }
        }
        
        dataset.records ~= DataRecord(headers, jsonValues);
    }
    
    return dataset;
}
