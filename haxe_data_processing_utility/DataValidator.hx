package;

/**
 * Handles validation logic for data records.
 */
class DataValidator {

    /**
     * Checks if a record contains all required fields.
     */
    public static function validateRequiredFields(record: DataRecord, requiredFields: Array<String>): Bool {
        for (field in requiredFields) {
            if (!record.data.exists(field)) {
                return false;
            }
        }
        return true;
    }

    /**
     * Checks if specific fields are non-null.
     */
    public static function validateNonEmpty(record: DataRecord, fields: Array<String>): Bool {
        for (field in fields) {
            if (!record.data.exists(field)) {
                return false;
            }
            var val = record.data[field];
            if (val == null) return false;
            if (val is String && (val + "").trim().length == 0) return false;
        }
        return true;
    }

    /**
     * Validates that a specific field is a valid number.
     */
    public static function validateNumeric(record: DataRecord, field: String): Bool {
        if (!record.data.exists(field)) return false;
        var val = record.data[field];
        if (val is String) {
            var strVal: String = cast val;
            if (strVal.trim().length == 0) return false;
            return !isNaN(Std.parseFloat(strVal));
        }
        return Std.isOfType(val, Float) || Std.isOfType(val, Int);
    }

    /**
     * Runs a comprehensive validation suite on a record.
     * Returns an array of error messages if any validation fails.
     */
    public static function runValidation(record: DataRecord, config: ProcessingConfig): Array<String> {
        var errors: Array<String> = [];
        
        // Basic required fields check (example: 'id' is always required)
        if (!record.data.exists("id") || (record.data["id"] + "").trim().length == 0) {
            errors.push("Record ID is missing or empty for: " + record.id);
        }

        // Custom required fields if provided in config or hardcoded logic
        // Here we assume 'name' and 'value' are critical for this generic example
        if (!validateRequiredFields(record, ["name", "value"])) {
            errors.push("Record " + record.id + " is missing required fields 'name' or 'value'.");
        }

        // Numeric validation for 'value'
        if (!validateNumeric(record, "value")) {
            errors.push("Record " + record.id + " has invalid numeric 'value'.");
        }
        
        return errors;
    }
}
