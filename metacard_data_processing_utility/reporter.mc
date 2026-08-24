// Reporter module for Metacard Data Processing Utility

function write_report(data, filepath) {
    let report = "# Data Processing Report\n\n"
    report += "## Processed Records\n\n"
    for record in data {
        report += `- ID: ${record.id}, Value: ${record.transformed_value}, Status: ${record.status}\n`
    }
    file.write(filepath, report)
}
