package groovy_data_processing_utility

import groovy.json.JsonSlurper
import java.nio.file.Files
import java.nio.file.Paths

/**
 * Handles ingestion of data from JSON files or standard input.
 */
class DataIngestor {

    /**
     * Reads data from a specified JSON file.
     *
     * @param filePath Path to the JSON file.
     * @return A list of maps representing the data records.
     * @throws IOException if the file cannot be read.
     */
    static List<Map> ingestFromJsonFile(String filePath) {
        if (!Files.exists(Paths.get(filePath))) {
            throw new FileNotFoundException("Input file not found: ${filePath}")
        }

        def content = new File(filePath).text
        if (!content.trim()) {
            return []
        }

        try {
            def jsonSlurper = new JsonSlurper()
            def result = jsonSlurper.parseText(content)
            if (result instanceof List) {
                return result.collect { record ->
                    if (record instanceof Map) {
                        return record
                    } else {
                        throw new IllegalArgumentException("Record in JSON array is not a map: ${record.class.name}")
                    }
                }
            } else if (result instanceof Map) {
                return [result]
            } else {
                throw new IllegalArgumentException("JSON root element is neither a list nor a map")
            }
        } catch (Exception e) {
            throw new IllegalArgumentException("Failed to parse JSON file: ${e.message}", e)
        }
    }

    /**
     * Reads data from standard input.
     *
     * @return A list of maps representing the data records.
     */
    static List<Map> ingestFromStdin() {
        def input = System.in.text
        if (!input.trim()) {
            return []
        }
        return ingestFromJsonFile(null, input)
    }

    private static List<Map> ingestFromJsonFile(String filePath, String content) {
        try {
            def jsonSlurper = new JsonSlurper()
            def result = jsonSlurper.parseText(content)
            if (result instanceof List) {
                return result.collect { record ->
                    if (record instanceof Map) {
                        return record
                    } else {
                        throw new IllegalArgumentException("Record in JSON array is not a map: ${record.class.name}")
                    }
                }
            } else if (result instanceof Map) {
                return [result]
            } else {
                throw new IllegalArgumentException("JSON root element is neither a list nor a map")
            }
        } catch (Exception e) {
            throw new IllegalArgumentException("Failed to parse JSON content: ${e.message}", e)
        }
    }
}
