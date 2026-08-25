#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

typedef struct {
    int id;
    char name[50];
    double value;
} Record;

Record* ingest_batch(int *count) {
    *count = 10;
    Record *records = (Record*)malloc(sizeof(Record) * (*count));
    if (!records) {
        printf("Memory allocation failed.\n");
        return NULL;
    }
    srand(time(NULL));
    for (int i = 0; i < (*count); i++) {
        records[i].id = i + 1;
        snprintf(records[i].name, 50, "Record_%d", i + 1);
        records[i].value = (double)rand() / RAND_MAX * 100.0;
    }
    return records;
}
