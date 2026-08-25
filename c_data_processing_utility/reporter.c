#include "reporter.h"

void generate_report(DataBatch *batch, const char *output_path) {
    FILE *f = fopen(output_path, "w");
    if (!f) {
        fprintf(stderr, "Error opening output file\n");
        return;
    }
    fprintf(f, "Data Processing Report\n");
    fprintf(f, "----------------------\n");
    fprintf(f, "Total Records Processed: %d\n", batch->count);
    fprintf(f, "\nRecord Details:\n");
    for (int i = 0; i < batch->count; i++) {
        DataRecord *rec = batch->records[i];
        fprintf(f, "[%d] Field1: %s, Field2: %s, Field3: %s\n",
                i, rec->field1 ? rec->field1 : "N/A",
                rec->field2 ? rec->field2 : "N/A",
                rec->field3 ? rec->field3 : "N/A");
    }
    fclose(f);
}
