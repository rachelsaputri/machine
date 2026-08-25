-- reporter.e
-- Generates statistical and structural reports of the data.

include types.e
include std/string.e
include std/math.e

public procedure reporter_generate_report(sequence data, string report_title)
    printf(1, "\n==========================================================\n")
    printf(1, "REPORT: %s\n", report_title)
    printf(1, "==========================================================\n")
    
    if length(data) = 0 then
        printf(1, "[EMPTY] No data to report.\n")
        return
    end if
    
    -- Summary Stats
    integer total_rows = length(data)
    integer total_cols = length(data[1])
    integer data_rows = total_rows - 1 -- Assuming header
    
    printf(1, "Rows: %d | Columns: %d\n", total_rows, total_cols)
    printf(1, "----------------------------------------------------------\n")
    
    -- Print Header
    sequence header = data[1]
    for i = 1 to length(header) do
        printf(1, "%-15s", header[i])
    end for
    printf(1, "\n")
    
    -- Print Data (Limit to first 10 rows for brevity)
    integer limit = min(10, total_rows)
    for i = 2 to limit do
        sequence row = data[i]
        for j = 1 to length(header) do
            string val = row[j]
            if length(val) > 15 then val = substring(val, 1, 12) & "..." end if
            printf(1, "%-15s", val)
        end for
        printf(1, "\n")
    end for
    
    if total_rows > 11 then
        printf(1, "... (%d more rows)\n", total_rows - 11)
    end if
    
    printf(1, "----------------------------------------------------------\n")
    printf(1, "End of Report\n")
end procedure
