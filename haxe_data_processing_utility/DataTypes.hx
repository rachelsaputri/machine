package;

/**
 * Represents a single data record being processed.
 */
@:structInit
class DataRecord {
    public var id: String;
    public var data: Map<String, Dynamic>;
    public var raw: String;

    public function new(id: String, data: Map<String, Dynamic>, raw: String = "") {
        this.id = id;
        this.data = data;
        this.raw = raw;
    }

    /**
     * Gets a specific field from the data map.
     */
    public function getField(fieldName: String): Dynamic {
        return data.exists(fieldName) ? data[fieldName] : null;
    }

    /**
     * Sets a specific field in the data map.
     */
    public function setField(fieldName: String, value: Dynamic): Void {
        data[fieldName] = value;
    }
}

/**
 * Configuration for the data processing pipeline.
 */
@:structInit
class ProcessingConfig {
    public var batchSize: Int;
    public var strictValidation: Bool;
    public var transformFunctions: Array<String>;

    public function new(batchSize: Int = 100, strictValidation: Bool = true, transformFunctions: Array<String> = []) {
        this.batchSize = batchSize;
        this.strictValidation = strictValidation;
        this.transformFunctions = transformFunctions;
    }
}

/**
 * Represents the outcome of a processing operation.
 */
@:structInit
class ProcessingResult {
    public var totalRecords: Int;
    public var processedRecords: Int;
    public var failedRecords: Int;
    public var errors: Array<String>;

    public function new(totalRecords: Int = 0, processedRecords: Int = 0, failedRecords: Int = 0, errors: Array<String> = []) {
        this.totalRecords = totalRecords;
        this.processedRecords = processedRecords;
        this.failedRecords = failedRecords;
        this.errors = errors;
    }

    public function isSuccess(): Bool {
        return failedRecords == 0;
    }
}
