module types;

import std.json;

/**
 * Represents a single record in the dataset.
 * Keys are field names, values are dynamic JSON values.
 */
struct DataRecord
{
    string[] keys;
    JSONValue[] values;

    this(string[] keys, JSONValue[] values)
    {
        if (keys.length != values.length)
            throw new Exception("Keys and values length mismatch.");
        this.keys = keys;
        this.values = values;
    }

    bool hasField(string key) const
    {
        for (int i = 0; i < keys.length; i++)
        {
            if (keys[i] == key)
                return true;
        }
        return false;
    }

    JSONValue getField(string key) const
    {
        for (int i = 0; i < keys.length; i++)
        {
            if (keys[i] == key)
                return values[i];
        }
        throw new Exception("Field \'\' not found in record.");
    }

    void setField(string key, JSONValue value)
    {
        for (int i = 0; i < keys.length; i++)
        {
            if (keys[i] == key)
            {
                values[i] = value;
                return;
            }
        }
        // If not found, we could add it, but for simplicity, we throw.
        // Alternatively, we could expand the arrays, but let's keep it simple.
        throw new Exception("Field \'\' not found in record. Cannot add new fields dynamically without restructuring.");
    }

    void removeField(string key)
    {
        for (int i = 0; i < keys.length; i++)
        {
            if (keys[i] == key)
            {
                keys = keys[0..i] ~ keys[i+1..$];
                values = values[0..i] ~ values[i+1..$];
                return;
            }
        }
        throw new Exception("Field \'\' not found in record.");
    }
}

/**
 * Represents a collection of records.
 */
struct DataSet
{
    DataRecord[] records;

    this(DataRecord[] records)
    {
        this.records = records;
    }

    bool empty() const
    {
        return records.length == 0;
    }

    size_t length() const
    {
        return records.length;
    }

    DataRecord opIndex(size_t index) const
    {
        if (index >= records.length)
            throw new Exception("Index out of bounds.");
        return records[index];
    }

    DataSet opSlice(size_t from, size_t to) const
    {
        return DataSet(records[from..to]);
    }
}

/**
 * Stores validation results.
 */
struct ValidationResult
{
    string[] errors;
    string[] warnings;

    bool hasErrors() const
    {
        return errors.length > 0;
    }

    bool hasWarnings() const
    {
        return warnings.length > 0;
    }

    this(string[] errors, string[] warnings)
    {
        this.errors = errors;
        this.warnings = warnings;
    }
}
