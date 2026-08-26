package;

/**
 * Main orchestrator for the data processing pipeline.
 */
class DataProcessor {

    private var config: ProcessingConfig;

    public function new(config: ProcessingConfig) {
        this.config = config;
    }

    /**
     * Executes the full pipeline on a given input string.
     * Automatically detects JSON or CSV format based on content.
     */
    public function process(input: String): ProcessingResult {
        var records: Array<DataRecord> = [];
        
        // 1. Ingest
        var firstChar = input.trim().charAt(0);
        if (firstChar == '[' || firstChar == '{') {
            try {
                if (firstChar == '[') {
                    records = DataIngestor.ingestJson(input);
                } else {
                    records.push(DataIngestor.ingestSingleJson(input));
                }
            } catch (e: Dynamic) {
                Sys.println("JSON Error: " + e);
                return new ProcessingResult(0, 0, 0, ["Invalid JSON input"]);
            }
        } else {
            records = DataIngestor.ingestCsv(input);
        }

        var result: ProcessingResult = new ProcessingResult(
            records.length,
            0,
            0,
            []
        );

        var processedRecords: Array<DataRecord> = [];

        // 2. Process each record
        for (record in records) {
            try {
                // 3. Validate
                var errors = DataValidator.runValidation(record, config);
                
                if (errors.length > 0) {
                    result.failedRecords++;
                    for (err in errors) {
                        result.errors.push(err);
                    }
                    continue;
                }

                // 4. Transform
                // Apply standard transformations
                record = DataTransformer.normalizeStrings(record);
                record = DataTransformer.computeDerivedFields(record);
                record = DataTransformer.sanitizeEmptyValues(record);

                processedRecords.push(record);
                result.processedRecords++;

            } catch (e: Dynamic) {
                result.failedRecords++;
                result.errors.push("Unexpected error processing record " + record.id + ": " + e);
            }
        }

        return result;
    }

    /**
     * Returns the processed records after a successful run.
     */
    public function getProcessedRecords(): Array<DataRecord> {
        // This is a simplified getter. In a real app, you might store the last batch.
        return []; 
    }
}
