include types.e
include ingester.e
include validator.e
include transformer.e
include reporter.e

-- Configuration
constant INPUT_FILE = "data.csv"
constant FILTER_FIELD = "status"
constant FILTER_VALUE = "active"
constant NORMALIZE_FIELD = "score"

sequence data = {}
sequence result = {}

-- Main Execution
procedure main()
    -- 1. Ingest Data
    printf(1, "[INFO] Starting Data Processing Utility...\n")
    data = ingester_load(INPUT_FILE)
    
    if length(data) = 0 then
        printf(1, "[ERROR] Failed to load data from %s\n", INPUT_FILE)
        exit(1)
    end if
    
    printf(1, "[INFO] Loaded %d records.\n", length(data))
    
    -- 2. Validate Data
    boolean valid = validator_validate(data)
    if not valid then
        printf(1, "[WARNING] Data validation encountered issues. Proceeding with caution.\n")
    end if
    
    -- 3. Transform Data
    -- Example: Filter by 'active' status and normalize 'score' field
    result = transformer_filter(data, FILTER_FIELD, FILTER_VALUE)
    
    if length(result) = 0 then
        printf(1, "[INFO] No records matched filter criteria.\n")
    else
        printf(1, "[INFO] Filtered to %d records.\n", length(result))
        
        -- Normalize the score (assuming scores are 0-100)
        result = transformer_normalize_field(result, NORMALIZE_FIELD)
        printf(1, "[INFO] Normalized field '%s'.\n", NORMALIZE_FIELD)
    end if
    
    -- 4. Report
    reporter_generate_report(data, "Original Dataset")
    if length(result) > 0 then
        reporter_generate_report(result, "Processed Dataset")
    end if
    
    printf(1, "[INFO] Processing complete.\n")
end procedure

-- Run
main()
