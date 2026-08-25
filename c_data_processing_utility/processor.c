#include "processor.h"

DataBatch* create_batch(int initial_capacity) {
    DataBatch *batch = (DataBatch*)malloc(sizeof(DataBatch));
    batch->capacity = initial_capacity;
    batch->count = 0;
    batch->records = (DataRecord**)malloc(sizeof(DataRecord*) * initial_capacity);
    return batch;
}

void add_record(DataBatch *batch, DataRecord *record) {
    if (batch->count == batch->capacity) {
        batch->capacity *= 2;
        batch->records = (DataRecord**)realloc(batch->records, sizeof(DataRecord*) * batch->capacity);
    }
    batch->records[batch->count++] = record;
}

void process_batch(DataBatch *batch) {
    for (int i = 0; i < batch->count; i++) {
        DataRecord *record = batch->records[i];
        // Process each record (e.g., compute, aggregate)
        if (record->field1 && record->field2) {
            // Example processing logic
        }
    }
}

void free_batch(DataBatch *batch) {
    for (int i = 0; i < batch->count; i++) {
        free(batch->records[i]->field1);
        free(batch->records[i]->field2);
        free(batch->records[i]->field3);
        free(batch->records[i]);
    }
    free(batch->records);
    free(batch);
}
