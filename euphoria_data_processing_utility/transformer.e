-- transformer.e
-- Handles data transformation operations like filtering and normalization.

include types.e
include std/string.e
include std/math.e

-- Filters a dataset based on a specific field value
public function transformer_filter(sequence data, string field_name, string value)
    sequence result = {}
    integer field_idx = 0
    
    -- Find field index (assuming first row is header)
    if length(data) > 0 then
        for i = 1 to length(data[1]) do
            if compare(upper(data[1][i]), upper(field_name)) = 0 then
                field_idx = i
                exit
            end if
        end for
    end if
    
    if field_idx = 0 then
        printf(1, "[TRANSFORM ERROR] Field '%s' not found.\n", field_name)
        return data
    end if
    
    -- Start from 1 to include header, or 2 to skip header depending on use case
    -- Here we keep header if it matches, otherwise filter data rows
    for i = 1 to length(data) do
        sequence row = data[i]
        
        -- If it's the header row, keep it
        if i = 1 then
            result = append(result, row)
        else
            -- Compare value (case-insensitive)
            if compare(upper(row[field_idx]), upper(value)) = 0 then
                result = append(result, row)
            end if
        end if
    end for
    
    return result
end function

-- Normalizes a numeric field to a 0-1 range
public function transformer_normalize_field(sequence data, string field_name)
    sequence result = deep_copy(data)
    integer field_idx = 0
    atom min_val = 1e99
    atom max_val = -1e99
    
    -- Find field index
    if length(result) > 0 then
        for i = 1 to length(result[1]) do
            if compare(upper(result[1][i]), upper(field_name)) = 0 then
                field_idx = i
                exit
            end if
        end for
    end if
    
    if field_idx = 0 then
        printf(1, "[TRANSFORM ERROR] Field '%s' not found for normalization.\n", field_name)
        return data
    end if
    
    -- Calculate min/max
    for i = 2 to length(result) do
        sequence row = result[i]
        string val_str = row[field_idx]
        atom val = to_number(val_str)
        
        if val < min_val then min_val = val end if
        if val > max_val then max_val = val end if
    end for
    
    -- Normalize
    atom range = max_val - min_val
    if range = 0 then
        -- Avoid division by zero
        for i = 2 to length(result) do
            result[i][field_idx] = "0.5"
        end for
    else
        for i = 2 to length(result) do
            sequence row = result[i]
            atom val = to_number(row[field_idx])
            atom normalized = (val - min_val) / range
            row[field_idx] = sprintf("%.4f", normalized)
        end for
    end if
    
    return result
end function
