```go
package main

import (
    "encoding/json"
    "fmt"
)

type Record struct {
    ID    string `json:"id"`
    Value string `json:"value"`
}

func TransformRecords(records []Record) ([]Record, error) {
    transformed := make([]Record, 0, len(records))
    for _, r := range records {
        // Apply transformation logic
        r.ID = fmt.Sprintf("TRANSFORMED_%s", r.ID)
        transformed = append(transformed, r)
    }
    return transformed, nil
}

func ExportRecords(records []Record, filename string) error {
    data, err := json.MarshalIndent(records, "", "  ")
    if err != nil {
        return err
    }
    return os.WriteFile(filename, data, 0644)
}
```
