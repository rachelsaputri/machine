MODULE DataTypes;

FROMInOut IMPORT WriteString, WriteLn, ReadString, Read;

(* Core Data Structure *)
TYPE
  RecordId = INTEGER;
  Severity = (Low, Medium, High, Critical);

  DataRecord = RECORD
    id: RecordId;
    timestamp: INTEGER; (* Simple integer representation for portability *)
    source: ARRAY [0..31] OF CHAR;
    message: ARRAY [0..63] OF CHAR;
    severity: Severity;
    processed: BOOLEAN;
  END;

  DataSet = ARRAY [0..99] OF DataRecord;

  ProcessingStats = RECORD
    totalProcessed: INTEGER;
    errors: INTEGER;
    warnings: INTEGER;
  END;

END DataTypes.
