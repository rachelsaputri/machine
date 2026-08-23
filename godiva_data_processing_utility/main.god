/**
 * Godiva Data Processing Utility - Main Entry Point
 * Orchestrates the data processing pipeline.
 */

module Main

import Processor
import std::io
import std::log
import std::fs

const OUTPUT_DIR = "./output"

func validate_input(filepath: string) -> bool {
    if !fs::exists(filepath) {
        log::error("Input file not found: {}", filepath)
        return false
    }
    if !fs::is_file(filepath) {
        log::error("Input path is not a file: {}", filepath)
        return false
    }
    return true
}

func ensure_output_dir() -> bool {
    if !fs::exists(OUTPUT_DIR) {
        log::info("Creating output directory: {}", OUTPUT_DIR)
        if !fs::create_dir(OUTPUT_DIR) {
            log::error("Failed to create output directory")
            return false
        }
    }
    return true
}

func run_pipeline(input_file: string) {
    if !validate_input(input_file) {
        return
    }

    if !ensure_output_dir() {
        return
    }

    var raw_data = std::io::read_file(input_file)
    if raw_data == null {
        log::error("Could not read data from {}", input_file)
        return
    }

    var records = Processor.process_data(raw_data.unwrap())
    
    if length(records) == 0 {
        log::warn("No valid records processed from {}", input_file)
        return
    }

    // In a real scenario, we would write these records to a file
    // For this utility, we just log the count and status
    for record in records {
        if record.status == "PROCESSED" {
            // Simulate successful processing
        }
    }

    log::info("Pipeline finished successfully.")
}

func main() {
    log::info("Godiva Data Processing Utility starting...")
    
    if std::arg::count() < 2 {
        log::info("Usage: godiva_processor <input_file>")
        std::sys::exit(1)
        return
    }

    var input_file = std::arg::get(1)
    run_pipeline(input_file)
    
    log::info("Utility shutting down.")
}
