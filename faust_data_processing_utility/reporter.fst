// reporter.fst - Faust Data Reporting Module
// Handles data reporting and output

import std

type Data = {
    raw: String
    timestamp: Int
    source: String
    metadata: {String: String}
}

type Reporter = {
    report: func(data: Data, status: String) -> Unit
}

// Console reporter
console_reporter: Reporter = {
    report: func(data: Data, status: String) -> Unit {
        println("Data processed: " + data.source + " - Status: " + status)
    }
}

// JSON reporter
json_reporter(output_file: String): Reporter = {
    return {
        report: func(data: Data, status: String) -> Unit {
            var json_str: String = "{" + 
                "\"source\": \"" + data.source + "\", " + 
                "\"status\": \"" + status + "\", " + 
                "\"raw\": \"" + data.raw + "\", " + 
                "\"timestamp\": " + data.timestamp.to_string() + 
                "}"
            
            println(json_str)
        }
    }
}

// CSV reporter
csv_reporter(output_file: String): Reporter = {
    return {
        report: func(data: Data, status: String) -> Unit {
            println(data.source + "," + status + "," + data.raw + "," + data.timestamp.to_string())
        }
    }
}
