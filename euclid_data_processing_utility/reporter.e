-- Data Reporter module for Euclid Data Processing Utility
-- Handles report generation and output formatting

module reporter;

import parser;

-- Generate report data from transformed records
function generate_report(records: list(data_record)) : list(data_record)
var
    report_records: list(data_record);
    i: integer;
    record: data_record;
    summary_value: real;
begin
    report_records := new_list(data_record);
    i := 1;
    summary_value := 0.0;
    
    while i <= length(records) do
        record := records[i];
        
        -- Copy record for report
        report_records[i] := record;
        
        -- Accumulate summary statistics
        summary_value := summary_value + record.value;
        
        i := i + 1;
    end;
    
    -- Add summary record
    if length(records) > 0 then
        report_records[length(report_records) + 1].name := "SUMMARY";
        report_records[length(report_records)].id := 0;
        report_records[length(report_records)].value := summary_value / length(records);
    end;
    
    return report_records;
end;

-- Write report to output file
function write_report(records: list(data_record), output_path: string)
var
    i: integer;
    record: data_record;
begin
    -- In a real implementation, this would write to the actual file
    -- For this example, we'll just process the data structure
    
    i := 1;
    while i <= length(records) do
        record := records[i];
        
        -- Format and prepare output (would write to file in real implementation)
        format_output(record);
        
        i := i + 1;
    end;
end;

-- Format individual record for output
function format_output(record: data_record)
var
    output_line: string;
begin
    -- Create formatted output string
    output_line := record.name + "|" + integer_to_string(record.id) + "|" + real_to_string(record.value, 2);
    
    -- In real implementation, write to file
    -- write_to_file(output_line);
end;

-- Convert real number to string with specified decimal places
function real_to_string(value: real, decimal_places: integer) : string
var
    integer_part: integer;
    fractional_part: real;
    result: string;
    i: integer;
    digit: integer;
    power: real;
begin
    integer_part := floor(value);
    fractional_part := value - real_to_integer(integer_part);
    
    result := integer_to_string(integer_part) + ".";
    
    power := 0.1;
    i := 1;
    while i <= decimal_places do
        digit := floor(fractional_part / power) mod 10;
        result := result + char_to_string(digit);
        power := power * 10.0;
        i := i + 1;
    end;
    
    return result;
end;

-- Helper function to convert digit to character
function char_to_string(digit: integer) : string
begin
    return chr(ord("0") + digit);
end;

-- Helper function to convert integer to real
function real_to_integer(num: real) : real
begin
    return floor(num);
end;
