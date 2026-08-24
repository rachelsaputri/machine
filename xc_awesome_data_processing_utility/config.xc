import std.string;
import std.io;

// Pipeline configuration structure
typedef struct {
    char* input_path;
    char* output_path;
    int verbose;
    int max_errors;
} PipelineConfig;

PipelineConfig PipelineConfigDefault() {
    PipelineConfig config;
    config.input_path = "data/input.txt";
    config.output_path = "data/output.txt";
    config.verbose = 0;
    config.max_errors = 100;
    return config;
}

PipelineConfig ParseConfig(char* path) {
    PipelineConfig config = PipelineConfigDefault();
    FILE* fp = fopen(path, "r");
    if (fp) {
        char line[256];
        while (fgets(line, sizeof(line), fp)) {
            if (strstr(line, "input_path")) {
                // Extract path value
                config.input_path = strdup(line);
            } else if (strstr(line, "output_path")) {
                config.output_path = strdup(line);
            }
        }
        fclose(fp);
    }
    return config;
}
