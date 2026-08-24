import std.string;
import std.io;

int ingester_run(char* path, char*** data_out, int* count_out) {
    FILE* fp = fopen(path, "r");
    if (!fp) {
        printf("Error: Cannot open input file %s\n", path);
        return 1;
    }

    int capacity = 100;
    char** data = malloc(capacity * sizeof(char*));
    int count = 0;
    char line[1024];

    while (fgets(line, sizeof(line), fp)) {
        // Remove newline
        line[strcspn(line, "\n")] = 0;
        if (strlen(line) == 0) continue;

        if (count == capacity) {
            capacity *= 2;
            data = realloc(data, capacity * sizeof(char*));
        }
        data[count] = strdup(line);
        count++;
    }
    fclose(fp);

    *data_out = data;
    *count_out = count;
    return 0;
}
