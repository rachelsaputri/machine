package groovy_data_processing_utility

/**
 * Validates data records against predefined rules.
 */
class DataValidator {

    /**
     * Validates a single record.
     *
     * @param record The map representing the data record.
     * @return A map containing 'valid' (boolean) and 'errors' (List<String>).
     */
    static Map validate(Map record) {
        def errors = []

        // Rule 1: ID must be present and numeric
        if (!record.containsKey('id')) {
            errors.add("Missing 'id' field")
        } else if (!(record.id instanceof Number)) {
            errors.add("'id' must be a number")
        }

        // Rule 2: Name must be present and non-empty string
        if (!record.containsKey('name')) {
            errors.add("Missing 'name' field")
        } else if (!(record.name instanceof String) || record.name.trim().isEmpty()) {
            errors.add("'name' must be a non-empty string")
        }

        // Rule 3: Score must be present and between 0 and 100
        if (!record.containsKey('score')) {
            errors.add("Missing 'score' field")
        } else if (!(record.score instanceof Number)) {
            errors.add("'score' must be a number")
        } else if ((record.score as double) < 0 || (record.score as double) > 100) {
            errors.add("'score' must be between 0 and 100")
        }

        return [
            valid: errors.isEmpty(),
            errors: errors
        ]
    }

    /**
     * Validates a list of records.
     *
     * @param records The list of maps representing the data records.
     * @return A map containing 'validRecords' (List<Map>), 'invalidRecords' (List<Map>), and 'validationResults' (List<Map>).
     */
    static Map validateAll(List<Map> records) {
        def validRecords = []
        def invalidRecords = []
        def validationResults = []

        records.eachWithIndex { record, index ->
            def result = validate(record)
            validationResults << [
                index: index,
                result: result
            ]
            if (result.valid) {
                validRecords << record
            } else {
                invalidRecords << record
            }
        }

        return [
            validRecords: validRecords,
            invalidRecords: invalidRecords,
            validationResults: validationResults
        ]
    }
}
