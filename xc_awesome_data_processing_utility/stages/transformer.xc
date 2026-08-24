import std.string;
import std.io;

int transformer_run(char** data, int count, char*** transformed_out, int* transformed_count_out) {
    char** transformed = malloc(count * sizeof(char*));
    int valid_count = 0;

    for (int i = 0; i < count; i++) {
        // Simple transformation: uppercase and add prefix
        char* line = data[i];
        int len = strlen(line);
        char* new_line = malloc(len + 10);
        snprintf(new_line, len + 10, "PROCESSED_%s", line);
        
        // In a real scenario, we might skip invalid lines here
        transformed[valid_count] = new_line;
        valid_count++;
    }

    *transformed_out = transformed;
    *transformed_count_out = valid_count;
    return 0;
}
