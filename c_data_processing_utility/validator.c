#include "validator.h"

int validate_record(DataRecord *record) {
    if (!record) return 0;
    if (!record->field1 || strlen(record->field1) == 0) return 0;
    if (!record->field2 || strlen(record->field2) == 0) return 0;
    return 1;
}

int validate_batch(DataBatch *batch) {
    for (int i = 0; i < batch->count; i++) {
        if (!validate_record(batch->records[i])) {
            fprintf(stderr, "Validation failed at record %d\n", i);
            return 0;
        }
    }
    return 1;
}
