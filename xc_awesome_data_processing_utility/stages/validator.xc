import std.string;

// Simple validation: check for empty strings and max length
int validator_run(char** data, int count, int max_errors, int* errors_out) {
    int errors = 0;
    for (int i = 0; i < count; i++) {
        if (strlen(data[i]) == 0) {
            errors++;
        }
        if (strlen(data[i]) > 255) {
            errors++;
        }
        if (errors > max_errors) {
            break;
        }
    }
    *errors_out = errors;
    return 0;
}
