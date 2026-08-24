module main

import ingestor
import validator
import transformer
import reporter

export main

// Entry point for the data processing utility
function main(args: String[]): Unit
    println("Starting Fortress Data Processing Utility...")

    val rawData: List[String] = ingestor.getData()
    println("Raw data ingested: " + rawData.length)

    val isValid: Boolean = validator.validate(rawData)
    if isValid
        val transformedData: List[String] = transformer.process(rawData)
        reporter.output(transformedData)
        println("Processing complete.")
    else
        println("Validation failed. Aborting.")

end main
