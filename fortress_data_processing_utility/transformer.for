module transformer

export process

// Transforms the data
function process(data: List[String]): List[String]
    val result = List[String]()
    for item in data
        result.add("Transformed: " + item)
    end for
    return result

end process
