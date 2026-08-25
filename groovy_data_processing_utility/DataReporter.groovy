package groovy_data_processing_utility

import groovy.json.JsonOutput

/**
 * Generates and displays processing reports.
 */
class DataReporter {

    /**
     * Generates a report based on processing results.
     *
     * @param results A map containing 'validRecords', 'invalidRecords', and 'validationResults'.
     * @param transformedRecords The list of transformed valid records.
     */
    static void generateReport(Map results, List<Map> transformedRecords) {
        println "=" * 60
        println "DATA PROCESSING REPORT"
        println "=" * 60
        println ""

        // Validation Summary
        println "Validation Summary:"
        println "  Total Records: ${results.validRecords.size() + results.invalidRecords.size()}"
        println "  Valid Records: ${results.validRecords.size()}"
        println "  Invalid Records: ${results.invalidRecords.size()}"
        println ""

        // Invalid Record Details
        if (results.invalidRecords) {
            println "Invalid Record Details:"
            results.validationResults.each { vr ->
                if (!vr.result.valid) {
                    println "  Record Index ${vr.index}:"
                    println "    Errors: ${vr.result.errors.join(', ')}"
                }
            }
            println ""
        }

        // Transformed Data Summary
        println "Transformed Data Summary:"
        println "  Total Transformed Records: ${transformedRecords.size()}"
        println ""

        // Transformed Data Table
        if (transformedRecords) {
            println "Transformed Records:"
            def headers = ['ID', 'Name', 'Score', 'Grade', 'Processed At']
            def maxColWidths = headers.collect { it.length() }

            transformedRecords.each { record ->
                def row = [
                    record.id,
                    record.name,
                    record.score,
                    record.grade,
                    record.processedAt
                ]
                row.eachWithIndex { val, idx ->
                    def valStr = val.toString()
                    if (valStr.length() > maxColWidths[idx]) {
                        maxColWidths[idx] = valStr.length()
                    }
                }
            }

            def headerLine = headers.collect { it.padRight(maxColWidths[headers.indexOf(it)]) }.join(' | ')
            def separatorLine = maxColWidths.collect { '-' * it }.join('-+-')

            println " | ${headerLine} |"
            println "+-${separatorLine}-+"

            transformedRecords.each { record ->
                def row = [
                    record.id.toString(),
                    record.name,
                    record.score.toString(),
                    record.grade,
                    record.processedAt
                ]
                def paddedRow = row.collect { val -> val.padRight(maxColWidths[headers.indexOf(val)]) }.join(' | ')
                println " | ${paddedRow} |"
            }
            println ""
        }

        println "=" * 60
    }

    /**
     * Outputs the transformed records as JSON.
     *
     * @param transformedRecords The list of maps representing the transformed records.
     */
    static void outputJson(List<Map> transformedRecords) {
        println ""
        println "JSON Output:"
        println JsonOutput.prettyPrint(JsonOutput.toJson(transformedRecords))
    }
}
