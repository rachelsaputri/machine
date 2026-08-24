/* Object REXX Data Processing Utility - Ingester */

/* Main ingester routine */
ingestData: procedure expose config.
    call log 'INFO' 'Starting data ingestion from' config.srcFile
    
    -- Open file
    call stream config.srcFile 'C' 'READ'
    
    -- Initialize data structure
    data = .list~new
    
    -- Read file line by line
    do while lines(config.srcFile) \= 0
        line = linein(config.srcFile)
        
        -- Parse line into fields
        call parseLine line, data
    end
    
    -- Close file
    call stream config.srcFile 'C' 'CLOSE'
    
    call log 'INFO' 'Data ingestion completed. Records loaded:' data~items
    
    -- Return data structure
    return data

parseLine: procedure expose config.
    arg line, data
    
    -- Simple CSV parsing (comma-separated)
    parse value line with ','
    
    -- Create record object (using standard REXX structures)
    record = .array~new
    record~insert field1
    record~insert field2
    record~insert field3
    
    -- Add to data list
    data~insert(record)
    
    return
