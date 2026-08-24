/**
 * D Data Processing Utility
 * 
 * A complete utility for reading, processing, and analyzing structured text data.
 */

import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.array;
import std.exception;

struct DataRecord {
    string id;
    string category;
    double value1;
    double value2;
    string status;
}

struct DataStats {
    int count;
    double sumValue1;
    double sumValue2;
    double minVal1;
    double maxVal1;
    double minVal2;
    double maxVal2;
}

/**
 * Parses a single line of data into a DataRecord.
 * Expects format: ID,Category,Value1,Value2,Status
 */
DataRecord parseRecord(string line) {
    auto trimmed = line.strip();
    if (trimmed.empty || trimmed.startsWith("#")) {
        throw new Exception("Invalid or empty line: " ~ line);
    }
    
    auto parts = trimmed.split(",");
    if (parts.length != 5) {
        throw new Exception("Malformed record with " ~ to!string(parts.length) ~ " fields: " ~ line);
    }
    
    // Simple validation for numeric fields
    double val1;
    double val2;
    
    try {
        val1 = to!double(parts[2].strip());
    } catch (Exception e) {
        throw new Exception("Invalid Value1 in line: " ~ line);
    }
    
    try {
        val2 = to!double(parts[3].strip());
    } catch (Exception e) {
        throw new Exception("Invalid Value2 in line: " ~ line);
    }
    
    return DataRecord(
        parts[0].strip(),
        parts[1].strip(),
        val1,
        val2,
        parts[4].strip()
    );
}

/**
 * Processes the input file, parses records, calculates statistics, and prints a report.
 */
void main(string[] args) {
    if (args.length < 2) {
        stderr.writeln("Usage: " ~ args[0] ~ " <input_file>");
        exit(1);
    }
    
    string filename = args[1];
    
    try {
        auto file = File(filename, "r");
        
        DataStats stats = DataStats(0, 0, 0, double.infinity, -double.infinity, double.infinity, -double.infinity);
        
        foreach (line; file.byLineCopy) {
            auto record = parseRecord(line);
            stats.count++;
            
            stats.sumValue1 += record.value1;
            stats.sumValue2 += record.value2;
            
            if (record.value1 < stats.minVal1) stats.minVal1 = record.value1;
            if (record.value1 > stats.maxVal1) stats.maxVal1 = record.value1;
            if (record.value2 < stats.minVal2) stats.minVal2 = record.value2;
            if (record.value2 > stats.maxVal2) stats.maxVal2 = record.value2;
        }
        
        file.close();
        
        // Print Report
        stdout.writeln("===== DATA PROCESSING REPORT =====");
        stdout.writeln("Input File: " ~ filename);
        stdout.writeln("Records Processed: " ~ to!string(stats.count));
        stdout.writeln("");
        stdout.writeln("--- Statistics for Value1 ---");
        stdout.writeln("Sum: " ~ format("%.2f", stats.sumValue1));
        if (stats.count > 0) {
            stdout.writeln("Average: " ~ format("%.2f", stats.sumValue1 / stats.count));
        }
        stdout.writeln("Min: " ~ format("%.2f", stats.minVal1));
        stdout.writeln("Max: " ~ format("%.2f", stats.maxVal1));
        stdout.writeln("");
        stdout.writeln("--- Statistics for Value2 ---");
        stdout.writeln("Sum: " ~ format("%.2f", stats.sumValue2));
        if (stats.count > 0) {
            stdout.writeln("Average: " ~ format("%.2f", stats.sumValue2 / stats.count));
        }
        stdout.writeln("Min: " ~ format("%.2f", stats.minVal2));
        stdout.writeln("Max: " ~ format("%.2f", stats.maxVal2));
        stdout.writeln("");
        stdout.writeln("==================================");
        
    } catch (Exception e) {
        stderr.writeln("Error processing file: " ~ e.msg);
        exit(1);
    }
}
