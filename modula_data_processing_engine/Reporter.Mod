MODULE Reporter;

FROMInOut IMPORT WriteString, WriteLn, Write;
FROMFormat IMPORT FormatString;

IMPORT DataTypes;

PROCEDURE PrintSummary(stats: DataTypes.ProcessingStats);  
VAR
  msg: ARRAY [0..50] OF CHAR;
BEGIN
  WriteLn("--- PROCESSING SUMMARY ---");
  FormatString("Records Processed: %d", stats.totalProcessed, msg);
  WriteString(msg); WriteLn;
  FormatString("Warnings Generated: %d", stats.warnings, msg);
  WriteString(msg); WriteLn;
  FormatString("Errors: %d", stats.errors, msg);
  WriteString(msg); WriteLn;
  WriteLn("--------------------------");
END PrintSummary;

PROCEDURE PrintRecord(rec: DataTypes.DataRecord);  
VAR
  msg: ARRAY [0..80] OF CHAR;
BEGIN
  FormatString("ID: %d | Source: %-32s | Status: %s", rec.id, rec.source, IF rec.processed THEN "OK" ELSE "ERR" END, msg);
  WriteString(msg); WriteLn;
END PrintRecord;

END Reporter.
