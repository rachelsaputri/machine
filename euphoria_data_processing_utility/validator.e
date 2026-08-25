-- validator.e
-- Validates data integrity and structure.

include types.e
include std/string.e

public function validator_validate(sequence data)
    integer errors = 0
    
    if length(data) = 0 then
        printf(1, "[VALIDATION ERROR] Dataset is empty.\n")
        return false
    end if
    
    integer first_row_len = length(data[1])
    
    for i = 1 to length(data) do
        sequence row = data[i]
        
        -- Check row length consistency
        if length(row) != first_row_len then
            printf(1, "[VALIDATION WARNING] Row %d has %d fields, expected %d.\n", 
                   i, length(row), first_row_len)
            errors += 1
        end if
        
        -- Check for null/empty rows
        if length(row) = 0 then
            printf(1, "[VALIDATION ERROR] Row %d is empty.\n", i)
            errors += 1
        end if
    end for
    
    if errors > 0 then
        printf(1, "[VALIDATION SUMMARY] Found %d issue(s).\n", errors)
        return false
    else
        printf(1, "[VALIDATION SUCCESS] All %d rows validated.\n", length(data))
        return true
    end if
end function
