/**
 * Main entry point for the data processing pipeline.
 * Configures the pipeline stages and executes them.
 */

function processData() {
  Logger.log('Starting data processing pipeline...');
  
  // Configuration for the pipeline
  const config = {
    sourceType: 'SHEET', // SHEET, CSV, JSON
    sourceId: SpreadsheetApp.getActiveSpreadsheet().getId(), // Use active sheet ID for SHEET type
    sheetName: 'DataInput', // Sheet to read from
    batchSize: 100, // Process records in batches
    outputSheetName: 'DataOutput', // Sheet to write results to
    enableValidation: true,
    enableTransformation: true
  };

  try {
    // Stage 1: Ingest
    Logger.log('Stage 1: Ingesting data...');
    const ingester = new DataIngester(config.sourceType, config.sourceId, config.sheetName, config.batchSize);
    const rawData = ingester.ingest();
    Logger.log(`Ingested ${rawData.length} raw records.`);

    if (rawData.length === 0) {
      Logger.log('No data to process.');
      return;
    }

    // Stage 2: Validate
    let validData = rawData;
    if (config.enableValidation) {
      Logger.log('Stage 2: Validating data...');
      const validator = new DataValidator();
      validData = validator.validate(rawData);
      const errors = validator.getErrors();
      Logger.log(`Validation complete. ${validData.length} valid records, ${errors.length} errors.`);
      
      // Log validation errors if any
      if (errors.length > 0) {
        Logger.log('Validation Errors:');
        errors.slice(0, 10).forEach(err => Logger.log(`  - ${err}`));
        if (errors.length > 10) Logger.log(`  ... and ${errors.length - 10} more errors.`);
      }
    }

    if (validData.length === 0) {
      Logger.log('No valid records to transform.');
      return;
    }

    // Stage 3: Transform
    let processedData = validData;
    if (config.enableTransformation) {
      Logger.log('Stage 3: Transforming data...');
      const transformer = new DataTransformer();
      processedData = transformer.transform(validData);
      Logger.log(`Transformation complete. ${processedData.length} transformed records.`);
    }

    // Stage 4: Report/Output
    Logger.log('Stage 4: Generating report and outputting data...');
    const reporter = new DataReporter(config.outputSheetName);
    const report = reporter.generateReport(validData, processedData);
    reporter.exportData(processedData);
    
    Logger.log('Pipeline complete.');
    Logger.log('Summary:');
    Logger.log(`  Total Input: ${rawData.length}`);
    Logger.log(`  Valid Records: ${validData.length}`);
    Logger.log(`  Processed Records: ${processedData.length}`);
    Logger.log(`  Errors: ${report.errorsCount}`);
    Logger.log(`  Execution Time: ${report.executionTime}ms`);
    
    return report;
  } catch (e) {
    Logger.log('Fatal Error in Pipeline: ' + e.message);
    throw e;
  }
}

// Initialize the pipeline when the script is run
// processData();
