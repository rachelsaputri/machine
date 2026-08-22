```go
package main

import (
    "fmt"
    "log"
    "os"
)

type Report struct {
    TotalRecords   int `json:"total_records"`
    ValidRecords   int `json:"valid_records"`
    ErrorCount     int `json:"error_count"`
}

func GenerateReport(total, valid, errors int) Report {
    return Report{
        TotalRecords: total,
        ValidRecords: valid,
        ErrorCount:   errors,
    }
}

func LogReport(report Report) {
    log.Printf("Processing Complete: Total=%d, Valid=%d, Errors=%d", report.TotalRecords, report.ValidRecords, report.ErrorCount)
    
    reportFile, err := os.Create("report.json")
    if err != nil {
        log.Fatalf("Failed to create report file: %v", err)
    }
    defer reportFile.Close()
    
    // Simple JSON writing for demonstration
    fmt.Fprintf(reportFile, "{\"total_records\": %d, \"valid_records\": %d, \"error_count\": %d}\n", report.TotalRecords, report.ValidRecords, report.ErrorCount)
    fmt.Println("Report generated successfully.")
}
```
