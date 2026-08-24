// Processor module for Metacard Data Processing Utility

function validate(data) {
    if data == null {
        return []
    }
    // Basic validation logic
    let valid_records = []
    for record in data {
        if record.id != null && record.value != null {
            valid_records.append(record)
        }
    }
    return valid_records
}

function transform(data) {
    let transformed = []
    for record in data {
        transformed.append({
            id: record.id,
            transformed_value: record.value * 2,
            status: "processed"
        })
    }
    return transformed
}
