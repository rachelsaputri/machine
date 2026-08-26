package;

/**
 * Handles transformation logic for data records.
 */
class DataTransformer {

    /**
     * Applies a standard normalization to all string values in a record.
     * Converts strings to uppercase and trims whitespace.
     */
    public static function normalizeStrings(record: DataRecord): DataRecord {
        for (key in record.data.keys()) {
            var val = record.data[key];
            if (val is String) {
                var strVal: String = cast val;
                record.setField(key, strVal.toUpperCase().trim());
            }
        }
        return record;
    }

    /**
     * Adds a computed field based on existing data.
     * Example: If 'price' and 'quantity' exist, add 'total'.
     */
    public static function computeDerivedFields(record: DataRecord): DataRecord {
        if (record.data.exists("price") && record.data.exists("quantity")) {
            var price: Float = Std.parseFloat(record.data["price"] + "");
            var quantity: Float = Std.parseFloat(record.data["quantity"] + "");
            record.setField("total", price * quantity);
        }
        return record;
    }

    /**
     * Filters out null or empty values from the data map.
     */
    public static function sanitizeEmptyValues(record: DataRecord): DataRecord {
        var keysToRemove: Array<String> = [];
        
        for (key in record.data.keys()) {
            var val = record.data[key];
            if (val == null || (val is String && (val + "").trim().length == 0)) {
                keysToRemove.push(key);
            }
        }
        
        for (key in keysToRemove) {
            record.data.remove(key);
        }
        
        return record;
    }

    /**
     * Applies a chain of transformations.
     */
    public static function applyPipeline(record: DataRecord, pipeline: Array<Dynamic->DataRecord>): DataRecord {
        var currentRecord: DataRecord = record;
        for (transformFunc in pipeline) {
            currentRecord = transformFunc(currentRecord);
        }
        return currentRecord;
    }
}
