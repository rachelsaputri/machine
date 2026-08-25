import std.stdio;
import std.string;
import std.file;
import std.json;
import std.algorithm;
import std.conv;
import std.array;
import std.exception;

import types;
import ingester;
import transformer;
import validator;
import reporter;

import std.getopt;

void main(string[] args)
{
    string inputFile;
    string outputFile;
    string format = "json";
    string reportFormat = "json";
    string[] transformers;
    bool showHelp;

    try
    {
        std.getopt(std.getopt.options(
            "input", &inputFile,
            "Output file path", &outputFile,
            "Format (json, csv)", &format,
            "Report format (json, csv)", &reportFormat,
            "Transformers", &transformers,
            "help", &showHelp
        ), std.getput.required(&inputFile, "Input file is required."),
           std.getput.required(&outputFile, "Output file is required."));
    }
    catch (GetOptException e)
    {
        writeln("Error: ", e.msg);
        writeln("Use --help for usage information.");
        exit(1);
    }

    if (showHelp)
    {
        writeln("D Data Processing Utility");
        writeln("=========================");
        writeln();
        writeln("Usage: d_data_processing_utility [options]");
        writeln();
        writeln("Options:");
        writeln("  --input FILE      Input data file path (required)");
        writeln("  --output FILE     Output report file path (required)");
        writeln("  --format FORMAT   Input format: json or csv (default: json)");
        writeln("  --report-format FORMAT Output format: json or csv (default: json)");
        writeln("  --transformers LIST Comma-separated list of transformers");
        writeln("                    Supported: remove_empty, uppercase, lowercase, trim_whitespace");
        writeln("  --help            Show this help message");
        return;
    }

    // Validate format
    format = toLower(format);
    reportFormat = toLower(reportFormat);

    if (format !in ["json", "csv"])
    {
        writeln("Error: Unsupported input format \'\', please use json or csv.");
        exit(1);
    }

    if (reportFormat !in ["json", "csv"])
    {
        writeln("Error: Unsupported output format \'\', please use json or csv.");
        exit(1);
    }

    // Parse transformer list
    string[] parsedTransformers;
    foreach (t; transformers)
    {
        foreach (name; t.split(","))
        {
            string trimmed = name.strip();
            if (trimmed !in ["remove_empty", "uppercase", "lowercase", "trim_whitespace"])
            {
                writeln("Warning: Unknown transformer \'\', skipping.");
                continue;
            }
            parsedTransformers ~= trimmed;
        }
    }

    writeln("Starting data processing...");
    writeln("Input file: ", inputFile);
    writeln("Output file: ", outputFile);
    writeln("Input format: ", format);
    writeln("Output format: ", reportFormat);
    writeln("Transformers: ", parsedTransformers.join(", "));

    // 1. Ingest Data
    auto data = try
    {
        if (format == "json")
        {
            ingestJSON(inputFile);
        }
        else
        {
            ingestCSV(inputFile);
        }
    }
    catch (Exception e)
    {
        writeln("Error during ingestion: ", e.msg);
        exit(1);
    }

    if (data.empty)
    {
        writeln("Warning: No data ingested from input file.");
        // Still create an empty report
        reporter.writeReport(outputFile, [], reportFormat);
        writeln("Empty report generated at ", outputFile);
        return;
    }

    writeln("Ingested ", data.length, " records.");

    // 2. Transform Data
    try
    {
        data = transformData(data, parsedTransformers);
    }
    catch (Exception e)
    {
        writeln("Error during transformation: ", e.msg);
        exit(1);
    }

    // 3. Validate Data
    auto validationResults = validateData(data);
    if (validationResults.hasErrors)
    {
        writeln("Validation Errors:");
        foreach (err; validationResults.errors)
        {
            writeln("  - ", err);
        }
        // Decide whether to fail or continue. For this utility, we continue but log.
        // In production, you might want to exit(1) here.
    }
    else
    {
        writeln("All records passed validation.");
    }

    // 4. Generate Report
    try
    {
        reporter.writeReport(outputFile, data, reportFormat);
    }
    catch (Exception e)
    {
        writeln("Error during report generation: ", e.msg);
        exit(1);
    }

    writeln("Processing complete. Report saved to ", outputFile);
}
