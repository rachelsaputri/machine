```go
package main

import (
    "errors"
    "fmt"
)

type Record struct {
    ID    string `json:"id"`
    Value string `json:"value"`
}

func ValidateRecord(r Record) error {
    if r.ID == "" {
        return errors.New("ID cannot be empty")
    }
    if r.Value == "" {
        return errors.New("Value cannot be empty")
    }
    return nil
}

func ValidateRecords(records []Record) ([]Record, []error) {
    validRecords := make([]Record, 0, len(records))
    var errors []error
    for _, r := range records {
        if err := ValidateRecord(r); err != nil {
            errors = append(errors, fmt.Errorf("record %s: %w", r.ID, err))
        } else {
            validRecords = append(validRecords, r)
        }
    }
    return validRecords, errors
}
```
