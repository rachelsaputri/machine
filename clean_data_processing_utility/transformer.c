#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ingestor.c"

typedef struct {
    int id;
    char transformed_name[60];
    double normalized_value;
} TransformedRecord;

TransformedRecord* transform_data(Record *records, int count) {
    TransformedRecord *transformed = (TransformedRecord*)malloc(sizeof(TransformedRecord) * count);
    if (!transformed) {
        printf("Memory allocation failed for transformation.\n");
        return NULL;
    }
    
    for (int i = 0; i < count; i++) {
        transformed[i].id = records[i].id;
        snprintf(transformed[i].transformed_name, 60, "TRANSFORMED_%s", records[i].name);
        transformed[i].normalized_value = records[i].value / 100.0;
    }
    return transformed;
}
