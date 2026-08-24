import pipeline;
import stages.ingester;
import stages.validator;
import stages.transformer;
import stages.reporter;

int main(int argc, char** argv) {
    // Initialize configuration
    PipelineConfig config = PipelineConfigDefault();
    
    // Parse command line arguments if provided
    if (argc > 1) {
        config = ParseConfig(argv[1]);
    }
    
    // Create pipeline instance
    Pipeline pipe = CreatePipeline(config);
    
    // Run the pipeline
    int status = ExecutePipeline(&pipe);
    
    if (status == 0) {
        printf("Pipeline executed successfully.\n");
    } else {
        printf("Pipeline execution failed with status: %d\n", status);
    }
    
    return status;
}
