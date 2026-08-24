#!/usr/bin/awk -f
# reporter.awk - Handles output generation

function generate_report(    i, line) {
    if (output_format == "csv") {
        # Output current row as CSV
        line = ""
        for (i = 1; i <= record_count; i++) {
            if (i > 1) line = line OFS
            line = line current_row[i]
        }
        print line
    } else if (output_format == "json") {
        # Output current row as JSON
        line = "{"
        for (i = 1; i <= record_count; i++) {
            if (i > 1) line = line ","
            # Simple key generation
            line = line "\"field_" i "\":\"" current_row[i] "\""
        }
        line = line "}"
        print line
    } else {
        # Default output
        for (i = 1; i <= record_count; i++) {
            printf "%s ", current_row[i]
        }
        print ""
    }
}
