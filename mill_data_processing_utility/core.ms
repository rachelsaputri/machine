"""
Core utilities for the MillScript Data Processing Utility.
Provides configuration loading, logging, and exit functions.
"""

function loadConfig(path) {
    // Simulate loading a JSON-like configuration
    // In a real implementation, this would parse a file
    let content = readFile(path);
    if (content == "") {
        return null;
    }
    // Simple key-value parsing for demonstration
    let config = {};
    let lines = content.split('\n');
    for (let line in lines) {
        line = trim(line);
        if (line.startsWith('#') || line == "") {
            continue;
        }
        let parts = line.split(':');
        if (parts.length == 2) {
            config[trim(parts[0])] = trim(parts[1]);
        }
    }
    return config;
}

function readFile(path) {
    // Stub for file reading
    // In a real implementation, this would read from the filesystem
    // For this demo, we'll return a dummy string
    return "input_data_path: ./input_data.json\noutput_report_path: ./output_report.json\nlog_level: info";
}

function trim(str) {
    return str.replace(/^\s+|\s+$/g, '');
}

function logInfo(message) {
    print("[INFO] " + message);
}

function logError(message) {
    print("[ERROR] " + message);
}

function exitSuccess() {
    exit(0);
}

function exitFailure(code) {
    exit(code);
}

function exit(code) {
    // Stub for process exit
    // In a real implementation, this would terminate the program
    if (code != 0) {
        print("Process exited with code " + code);
    }
}
