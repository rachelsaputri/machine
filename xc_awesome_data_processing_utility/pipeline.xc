import std.string;
import std.io;

// Forward declarations of stages
extern int ingester_run(char* path, char*** data_out, int* count_out);
extern int validator_run(char** data, int count, int max_errors, int* errors_out);
extern int transformer_run(char** data, int count, char*** transformed_out, int* transformed_count_out);
extern int reporter_run(char** data, int count, char* output_path);

// Pipeline handle
typedef struct {
    PipelineConfig config;
    char** raw_data;
    int raw_count;
    char** processed_data;
    int processed_count;
    int error_count;
} Pipeline;

Pipeline CreatePipeline(PipelineConfig config) {
    Pipeline pipe;
    pipe.config = config;
    pipe.raw_data = NULL;
    pipe.raw_count = 0;
    pipe.processed_data = NULL;
    pipe.processed_count = 0;
    pipe.error_count = 0;
    return pipe;
}

int ExecutePipeline(Pipeline* pipe) {
    // 1. Ingest
    int status = ingester_run(pipe->config.input_path, &pipe->raw_data, &pipe->raw_count);
    if (status != 0) {
        printf("Ingestion failed.\n");
        return status;
    }
    if (pipe->config.verbose) {
        printf("Ingested %d records.\n", pipe->raw_count);
    }

    // 2. Validate
    status = validator_run(pipe->raw_data, pipe->raw_count, pipe->config.max_errors, &pipe->error_count);
    if (status != 0) {
        printf("Validation failed. Errors: %d\n", pipe->error_count);
        // Proceed with transformation even if there are errors, or fail based on policy
    }
    if (pipe->config.verbose) {
        printf("Validation complete. Errors: %d\n", pipe->error_count);
    }

    // 3. Transform
    status = transformer_run(pipe->raw_data, pipe->raw_count, &pipe->processed_data, &pipe->processed_count);
    if (status != 0) {
        printf("Transformation failed.\n");
        return status;
    }
    if (pipe->config.verbose) {
        printf("Transformed %d records.\n", pipe->processed_count);
    }

    // 4. Report
    status = reporter_run(pipe->processed_data, pipe->processed_count, pipe->config.output_path);
    if (status != 0) {
        printf("Reporting failed.\n");
        return status;
    }
    if (pipe->config.verbose) {
        printf("Report generated.\n");
    }

    return 0;
}
