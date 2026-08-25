#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ingestor.c"

typedef struct {
    int valid_count;
    int invalid_count;
    Record *valid_records;
} ValidationResult;

ValidationResult validate_data(Record *records, int count) {
    ValidationResult result;
    result.valid_count = 0;
    result.invalid_count = 0;
    result.valid_records = (Record*)malloc(sizeof(Record) * count);
    if (!result.valid_records) {
        printf("Memory allocation failed for validation.\n");
        result.valid_records = NULL;
        return result;
    }
    
    for (int i = 0; i < count; i++) {
        if (records[i].id > 0 && records[i].value >= 0.0 && records[i].value <= 100.0) {
            result.valid_records[result.valid_count++] = records[i];
        } else {
            result.invalid_count++;
        }
    }
    return result;
}
