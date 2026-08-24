MODULE Processor;

IMPORT DataTypes;

PROCEDURE NormalizeSource(VAR record: DataTypes.DataRecord);   
VAR
  i: INTEGER;
BEGIN
  i := 0;
  WHILE i < LEN(record.source) DO
    IF record.source[i] >= 'A' THEN
      record.source[i] := CHAR(ORD(record.source[i]) + 32); 
    END;
    INC(i);
  END;
END NormalizeSource;

PROCEDURE EnrichData(VAR dataset: DataTypes.DataSet; stats: VAR DataTypes.ProcessingStats);  
VAR
  i: INTEGER;
  current: DataTypes.DataRecord;
BEGIN
  stats.totalProcessed := 0;
  stats.errors := 0;
  stats.warnings := 0;

  FOR i := 0 TO 99 DO
    current := dataset[i];
    current.processed := TRUE;
    NormalizeSource(current);
    
    CASE current.severity OF
      | DataTypes.High:
        current.message := "[HIGH_PRIORITY] " & current.message
      | DataTypes.Critical:
        current.message := "[CRITICAL_ALERT] " & current.message
      | ELSE
    END;
    
    INC(stats.totalProcessed);
    IF current.severity >= DataTypes.Medium THEN
      INC(stats.warnings);
    END;
    dataset[i] := current;
  END;
END EnrichData;

END Processor.
