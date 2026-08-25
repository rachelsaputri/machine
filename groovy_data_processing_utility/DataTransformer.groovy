package groovy_data_processing_utility

/**
 * Transforms validated data records.
 */
class DataTransformer {

    /**
     * Transforms a single record.
     *
     * @param record The map representing the data record.
     * @return A new map representing the transformed record.
     */
    static Map transform(Map record) {
        def transformed = record.clone()

        // Transformation 1: Normalize name to title case
        if (transformed.containsKey('name')) {
            transformed.name = transformed.name.trim().toLowerCase().replaceAll(/\b\w/) { it[0].toUpperCase() }
        }

        // Transformation 2: Calculate grade based on score
        if (transformed.containsKey('score')) {
            def score = transformed.score as double
            def grade
            if (score >= 90) {
                grade = 'A'
            } else if (score >= 80) {
                grade = 'B'
            } else if (score >= 70) {
                grade = 'C'
            } else if (score >= 60) {
                grade = 'D'
            } else {
                grade = 'F'
            }
            transformed.grade = grade
        }

        // Transformation 3: Add processing timestamp
        transformed.processedAt = new Date().format('yyyy-MM-dd HH:mm:ss')

        return transformed
    }

    /**
     * Transforms a list of records.
     *
     * @param records The list of maps representing the data records.
     * @return A list of maps representing the transformed records.
     */
    static List<Map> transformAll(List<Map> records) {
        return records.collect { record ->
            transform(record)
        }
    }
}
