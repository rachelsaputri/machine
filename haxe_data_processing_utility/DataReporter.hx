package;

import haxe.io.Output;
import haxe.ds.StringMap;

/**
 * Handles reporting and output generation.
 */
class DataReporter {

    /**
     * Generates a JSON summary report of the processing results.
     */
    public static function generateJsonReport(result: ProcessingResult, processedData: Array<DataRecord>): String {
        var reportMap: Map<String, Dynamic> = new StringMap();
        reportMap.set("totalRecords", result.totalRecords);
        reportMap.set("processedRecords", result.processedRecords);
        reportMap.set("failedRecords", result.failedRecords);
        reportMap.set("errors", result.errors);
        reportMap.set("isSuccess", result.isSuccess());
        reportMap.set("recordsProcessed", processedData.length);
        
        return haxe.Json.stringify(reportMap, "  ");
    }

    /**
     * Writes a processed record to a text representation.
     */
    public static function formatRecord(record: DataRecord): String {
        var sb = new haxe.io.BytesOutput();
        sb.writeString("ID: " + record.id);
        sb.writeString("\nData: ");
        
        var first = true;
        for (key in record.data.keys()) {
            if (!first) sb.writeString(", ");
            sb.writeString(key + ": " + record.data[key]);
            first = false;
        }
        return sb.toString();
    }

    /**
     * Prints the summary report to stdout.
     */
    public static function printSummary(result: ProcessingResult, processedCount: Int): Void {
        Sys.println("\n========== Processing Report ==========");
        Sys.println("Total Records Ingested: " + result.totalRecords);
        Sys.println("Successfully Processed: " + processedCount);
        Sys.println("Failed/Filtered: " + result.failedRecords);
        
        if (result.errors.length > 0) {
            Sys.println("\nValidation Errors:");
            for (err in result.errors) {
                Sys.println("  - " + err);
            }
        } else {
            Sys.println("No errors detected.");
        }
        
        Sys.println("=======================================\n");
    }
}
