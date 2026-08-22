```go
package main

import (
    "fmt"
    "os"
    "path/filepath"

    "gopkg.in/yaml.v3"
)

type Config struct {
    DataSource struct {
        Type string `yaml:"type"`
        Path string `yaml:"path"`
    } `yaml:"data_source"`
}

func LoadConfig(path string) (Config, error) {
    var config Config
    file, err := os.ReadFile(path)
    if err != nil {
        return config, err
    }
    err = yaml.Unmarshal(file, &config)
    return config, err
}

func main() {
    config, err := LoadConfig("config.yaml")
    if err != nil {
        fmt.Fprintf(os.Stderr, "Error loading config: %v\n", err)
        os.Exit(1)
    }
    fmt.Printf("Loaded config: %+v\n", config)
    // Add data ingestion logic here
}
```
