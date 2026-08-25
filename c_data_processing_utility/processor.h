#ifndef PROCESSOR_H
#define PROCESSOR_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *field1;
    char *field2;
    char *field3;
} DataRecord;

typedef struct {
    DataRecord **records;
    int count;
    int capacity;
} DataBatch;

DataBatch* create_batch(int initial_capacity);
void add_record(DataBatch *batch, DataRecord *record);
void process_batch(DataBatch *batch);
void free_batch(DataBatch *batch);

#endif
