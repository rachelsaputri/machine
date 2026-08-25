#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "processor.h"
#include "validator.h"
#include "transformer.h"
#include "reporter.h"

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <input.csv>\n", argv[0]);
        return 1;
    }

    const char *input_path = argv[1];
    const char *output_path = "output_report.txt";

    FILE *f = fopen(input_path, "r");
    if (!f) {
        fprintf(stderr, "Error opening input file\n");
        return 1;
    }

    DataBatch *batch = create_batch(10);
    char line[1024];

    while (fgets(line, sizeof(line), f)) {
        // Simple CSV parsing: Field1,Field2,Field3
        char *token = strtok(line, ",\n");
        if (!token) continue;
        char *field1 = strdup(token);

        token = strtok(NULL, ",\n");
        char *field2 = token ? strdup(token) : strdup("");

        token = strtok(NULL, ",\n");
        char *field3 = token ? strdup(token) : strdup("");

        DataRecord *record = (DataRecord*)malloc(sizeof(DataRecord));
        record->field1 = field1;
        record->field2 = field2;
        record->field3 = field3;

        add_record(batch, record);
    }
    fclose(f);

    // Validate
    if (!validate_batch(batch)) {
        fprintf(stderr, "Batch validation failed.\n");
        free_batch(batch);
        return 1;
    }

    // Transform
    transform_batch(batch);

    // Process
    process_batch(batch);

    // Generate Report
    generate_report(batch, output_path);

    // Cleanup
    free_batch(batch);

    printf("Processing complete. Report saved to %s\n", output_path);
    return 0;
}
