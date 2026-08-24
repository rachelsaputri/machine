// Main entry point for the Metacard Data Processing Utility

import parser
import processor
import reporter

function main() {
    let data = parser.read_data("input.json")
    let validated_data = processor.validate(data)
    let transformed_data = processor.transform(validated_data)
    reporter.write_report(transformed_data, "report.md")
}

main()
