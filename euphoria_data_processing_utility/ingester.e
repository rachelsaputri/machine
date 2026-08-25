-- ingester.e
-- Handles loading external data files into Euphoria sequences.

include types.e
include std/string.e
include std/io.e

public function ingester_load(string filename)
    integer fh
    sequence lines = {}
    sequence data = {}
    
    fh = open(filename, "r")
    if fh = 0 then
        printf(1, "[ERROR] Could not open file: %s\n", filename)
        return {}
    end if
    
    -- Read all lines
    while not EOF(fh) do
        string line = gets(fh)
        if length(line) > 0 then
            lines = append(lines, line)
        end if
    end while
    
    close(fh)
    
    if length(lines) = 0 then
        return {}
    end if
    
    -- Parse CSV (Simple comma separation)
    -- Skip header for data processing, or keep if needed.
    -- Here we parse everything into ROWs.
    for i = 1 to length(lines) do
        string line = lines[i]
        sequence row = {}
        
        -- Split by comma
        sequence parts = split(line, ",")
        
        -- Clean whitespace from parts
        for j = 1 to length(parts) do
            string part = trim(parts[j])
            row = append(row, part)
        end for
        
        data = append(data, row)
    end for
    
    return data
end function
