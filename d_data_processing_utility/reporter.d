module reporter;

import std.file;
import std.json;
import std.stdio;
import std.string;
import std.array;
import std.algorithm;
import types;

/**
 * Writes the dataset to a file in the specified format.
 */
void writeReport(string filePath, DataSet dataset, string format)
{
    auto content = switch (toLower(format))
    {
        case "json":
        {
            JSONValue[] jsonArray;
            foreach (record; dataset.records)
            {
                JObject obj;
                for (size_t i = 0; i < record.keys.length; i++)
                {
                    obj[record.keys[i]] = record.values[i];
                }
                jsonArray ~= JSONValue(obj);
            }
            return buildJSON(jsonArray);
        }
        case "csv":
        {
            if (dataset.empty)
                return "";
                
            // Get all unique keys to form headers
            string[] allKeys;
            foreach (record; dataset.records)
            {
                foreach (key; record.keys)
                {
                    if (key !in allKeys)
                        allKeys ~= key;
                }
            }
            
            if (allKeys.empty)
                return "";
                
            string[] lines;
            
            // Header
            lines ~= allKeys.join(",");
            
            // Data rows
            foreach (record; dataset.records)
            {
                string[] values;
                foreach (key; allKeys)
                {
                    if (record.hasField(key))
                    {
                        auto val = record.getField(key);
                        string strVal;
                        if (val.type == JNull)
                        {
                            strVal = "";
                        }
                        else
                        {
                            strVal = toJson(val);
                            // Remove quotes if it's a string
                            if (val.type == JString)
                            {
                                strVal = strVal[1..$-1];
                            }
                        }
                        
                        // Escape comma if present in value
                        if (strVal.contains(","))
                        {
                            strVal = "\"" ~ strVal ~ "\"";
                        }
                        
                        values ~= strVal;
                    }
                    else
                    {
                        values ~= "";
                    }
                }
                lines ~= values.join(",");
            }
            
            return lines.join("\n") ~ "\n";
        }
        default:
            throw new Exception("Unsupported report format: " ~ format);
    };
    
    writeFile(filePath, content);
}

/**
 * Helper to build JSON content for array of JSONValues
 */
string buildJSON(JSONValue[] values)
{
    if (values.empty)
        return "[]";
        
    string result = "[\n";
    for (size_t i = 0; i < values.length; i++)
    {
        result ~= toJson(values[i]);
        if (i < values.length - 1)
            result ~= ",";
        result ~= "\n";
    }
    result ~= "]";
    return result;
}
