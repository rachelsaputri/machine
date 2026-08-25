#include <stdio.h>
#include <stdlib.h>
#include "ingestor.c"
#include "validator.c"
#include "transformer.c"
#include "reporter.c"

int main() {
    printf("Starting Data Processing Pipeline...\n");
    
    int count = 0;
    Record *raw_data = ingest_batch(&count);
    if (!raw_data) {
        printf("Failed to ingest data. Exiting.\n");
        return 1;
    }
    printf("Ingested %d records.\n", count);
    
    ValidationResult validation = validate_data(raw_data, count);
    if (!validation.valid_records) {
        printf("Validation failed or memory error. Exiting.\n");
        free(raw_data);
        return 1;
    }
    printf("Validation complete. %d valid, %d invalid.\n", validation.valid_count, validation.invalid_count);
    
    TransformedRecord *transformed_data = transform_data(validation.valid_records, validation.valid_count);
    if (!transformed_data) {
        printf("Transformation failed or memory error. Exiting.\n");
        free(raw_data);
        free(validation.valid_records);
        return 1;
    }
    printf("Transformation complete.\n");
    
    report_results(&validation, transformed_data, validation.valid_count);
    
    // Cleanup
    free(raw_data);
    free(validation.valid_records);
    free(transformed_data);
    
    printf("Pipeline finished successfully.\n");
    return 0;
}
