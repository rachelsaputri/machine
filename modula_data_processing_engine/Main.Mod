MODULE Main;

FROMInOut IMPORT WriteLn, WriteString;
FROMTexts IMPORT Reader, Writer, OpenReader, OpenText, ReadString, WriteString;

IMPORT DataTypes, Processor, Reporter;

VAR
  dataset: DataTypes.DataSet;
  stats: DataTypes.ProcessingStats;
  i: INTEGER;

PROCEDURE InitSampleData;  
VAR
  j: INTEGER;
BEGIN
  FOR j := 0 TO 99 DO
    dataset[j].id := j + 1000;
    dataset[j].timestamp := 1678886400; 
    dataset[j].source := "NETWORK_LOG";
    IF j MOD 2 = 0 THEN
      dataset[j].severity := DataTypes.Low;
    ELSE
      dataset[j].severity := DataTypes.High;
    END;
    dataset[j].message := "Standard event payload";
    dataset[j].processed := FALSE;
  END;
  dataset[5].severity := DataTypes.Critical;
  dataset[5].source := "DATABASE_SERVER";
END InitSampleData;

BEGIN
  WriteLn("Initializing Modula Data Engine...");
  InitSampleData;
  
  WriteLn("Starting Data Enrichment Pipeline...");
  Processor.EnrichData(dataset, stats);
  
  Reporter.PrintSummary(stats);
  
  WriteLn("Sample Output:");
  Reporter.PrintRecord(dataset[0]);
  Reporter.PrintRecord(dataset[5]);
  
  WriteLn("Execution Complete.");
END Main.
