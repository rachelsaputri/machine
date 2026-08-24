module validator

export validate

// Validates the data list
function validate(data: List[String]): Boolean
    if data.isEmpty
        println("Data is empty.")
        return false
    end if
    println("Data validation successful.")
    return true

end validate
