/* Object REXX Data Processing Utility - Reporter */

/* Generate processing reports */
generateReport: procedure expose config.
    call log 'INFO' 'Starting report generation'
    
    -- Open output file
    call stream config.dstFile 'C' 'REPLACE'
    
    -- Write report header
    call writeReportHeader
    
    -- Write summary statistics
    call writeSummaryStatistics
    
    -- Write detailed results
    call writeDetailedResults
    
    -- Close output file
    call stream config.dstFile 'C' 'CLOSE'
    
    call log 'INFO' 'Report generation completed to' config.dstFile
    return

writeReportHeader: procedure
    -- Write header to output file
    say '===== DATA PROCESSING REPORT =====' to .std
    say 'Generated:' date()
    say 'Source:' config.srcFile
    say 'Destination:' config.dstFile
    
    return

writeSummaryStatistics: procedure
    -- Write summary statistics
    say ''
    say '--- Summary Statistics ---'
    say 'Total records processed:' totalRecords
    say 'Valid records:' validRecords~items
    say 'Invalid records:' invalidRecords~items
    say 'Transformation errors:' transformErrors
    
    return

writeDetailedResults: procedure
    -- Write detailed results if needed
    if reportDetail = 'YES' then do
        say ''
        say '--- Detailed Results ---'
        
        -- Write transformed records
        do i = 1 to transformedData~items
            record = transformedData~item(i)
            say 'Record' i ':' record~items
        end
    end
    
    return
