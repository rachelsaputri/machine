import std.string;
import std.io;

int reporter_run(char** data, int count, char* output_path) {
    FILE* fp = fopen(output_path, "w");
    if (!fp) {
        printf("Error: Cannot open output file %s\n", output_path);
        return 1;
    }

    for (int i = 0; i < count; i++) {
        fprintf(fp, "%s\n", data[i]);
    }
    fclose(fp);
    return 0;
}
