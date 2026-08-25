#include "transformer.h"

void transform_record(DataRecord *record) {
    if (!record) return;
    // Example transformation: uppercase first field
    if (record->field1) {
        char *temp = strdup(record->field1);
        for (int i = 0; temp[i]; i++) {
            if (temp[i] >= 'a' && temp[i] <= 'z') {
                temp[i] -= 32;
            }
        }
        free(record->field1);
        record->field1 = temp;
    }
}

void transform_batch(DataBatch *batch) {
    for (int i = 0; i < batch->count; i++) {
        transform_record(batch->records[i]);
    }
}
