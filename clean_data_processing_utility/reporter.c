#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ingestor.c"
#include "validator.c"
#include "transformer.c"

void report_results(ValidationResult *validation, TransformedRecord *transformed, int count) {
    printf("===== DATA PROCESSING REPORT =====\n");
    printf("Total Records Ingested: %d\n", validation->valid_count + validation->invalid_count);
    printf("Valid Records: %d\n", validation->valid_count);
    printf("Invalid Records: %d\n", validation->invalid_count);
    printf("==================================\n\n");
    
    printf("Transformed Data Preview:\n");
    int limit = (count < 5) ? count : 5;
    for (int i = 0; i < limit; i++) {
        printf("ID: %d, Name: %s, Normalized Value: %.4f\n", 
               transformed[i].id, 
               transformed[i].transformed_name, 
               transformed[i].normalized_value);
    }
    if (count > 5) {
        printf("... and %d more records.\n", count - 5);
    }
}
