module reporter

export output

// Outputs the processed data
function output(data: List[String]): Unit
    println("Report Generation:")
    for item in data
        println("  - " + item)
    end for
    println("Report complete.")

end output
