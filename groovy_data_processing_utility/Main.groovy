package groovy_data_processing_utility

/**
 * Main entry point for the data processing utility.
 */
class Main {

    static void main(String[] args) {
        if (args.length != 1) {
            println "Usage: groovy Main.groovy <input_json_file>"
            System.exit(1)
        }

        def inputFile = args[0]

        try {
            // Ingest Data
            println "Ingesting data from: ${inputFile}"
            def records = DataIngestor.ingestFromJsonFile(inputFile)
            println "Ingested ${records.size()} records."

            // Validate Data
            println "Validating data..."
            def validationResults = DataValidator.validateAll(records)

            // Transform Valid Data
            println "Transforming valid data..."
            def transformedRecords = DataTransformer.transformAll(validationResults.validRecords)

            // Generate Report
            println "Generating report..."
            DataReporter.generateReport(validationResults, transformedRecords)

            // Output JSON
            DataReporter.outputJson(transformedRecords)

        } catch (Exception e) {
            println "Error during data processing: ${e.message}"
            e.printStackTrace()
            System.exit(1)
        }
    }
}
