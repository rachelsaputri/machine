package;

import haxe.ds.List;

/**
 * Represents a record to be processed.
 */
@:structInit
class DataRecord {
    public var id: String;
    public var timestamp: Float;
    public var fields: Map<String, Dynamic>;

    public function new(id: String, timestamp: Float, fields: Map<String, Dynamic>) {
        this.id = id;
        this.timestamp = timestamp;
        this.fields = fields;
    }
}

/**
 * Utility class for data processing operations.
 */
class DataProcessor {
    public static function processRecords(records: List<DataRecord>): List<DataRecord> {
        var processedRecords = new List<DataRecord>();
        for (record in records) {
            // Example transformation: clean up fields
            var cleanedFields = new Map<String, Dynamic>();
            for (key in record.fields.keys()) {
                var value = record.fields[key];
                if (value != null) {
                    cleanedFields[key] = value;
                }
            }
            var processedRecord = new DataRecord(record.id, record.timestamp, cleanedFields);
            processedRecords.add(processedRecord);
        }
        return processedRecords;
    }

    public static function validateRecord(record: DataRecord): Bool {
        if (record.id == null || record.id.trim().isEmpty()) {
            return false;
        }
        if (record.fields == null) {
            return false;
        }
        return true;
    }

    public static function generateReport(records: List<DataRecord>): String {
        var report = new StringBuf();
        report.add("Processing Report\n");
        report.add("=================\n");
        report.add("Total Records: ${records.length}\n");
        report.add("Processed Successfully: ${records.length}\n");
        report.add("Errors: 0\n");
        return report.toString();
    }
}

/**
 * Main entry point for the Haxe data processing utility.
 */
class Main {
    public static function main() {
        var records = new List<DataRecord>();
        var fields1 = new Map<String, Dynamic>();
        fields1.set("name", "Alice");
        fields1.set("age", 30);
        records.add(new DataRecord("rec-001", Date.now().getTime(), fields1));

        var fields2 = new Map<String, Dynamic>();
        fields2.set("name", "Bob");
        fields2.set("age", 25);
        records.add(new DataRecord("rec-002", Date.now().getTime(), fields2));

        // Validate records
        for (record in records) {
            if (!DataProcessor.validateRecord(record)) {
                trace("Validation failed for record: ${record.id}");
            }
        }

        // Process records
        var processedRecords = DataProcessor.processRecords(records);
        trace("Processed ${processedRecords.length} records.");

        // Generate report
        var report = DataProcessor.generateReport(processedRecords);
        trace(report);
    }
}
