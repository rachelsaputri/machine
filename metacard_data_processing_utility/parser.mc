// Parser module for Metacard Data Processing Utility

function read_data(filepath) {
    let content = file.read(filepath)
    return json.parse(content)
}
