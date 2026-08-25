MODULE Main;

IMPORT In;
FROM In; IMPORT StdLog;

VAR
  inputText: ARRAY [0..255] OF CHAR;
  outputText: ARRAY [0..255] OF CHAR;

BEGIN
  StdLog.String("=== Modula Data Processing Pipeline ===");
  StdLog.Ln;
  
  StdLog.String("Enter data to process (press Enter to finish):");
  In.String(inputText, 255, TRUE);
  In.Fix; In.OpenResult(outputText, 255);
  
  IF In.Done THEN
    StdLog.String("Original data: ");
    StdLog.String(inputText);
    StdLog.Ln;
    
    (
      StdLog.String("Processed data (uppercase): ");
      StdLog.String(outputText);
      StdLog.Ln;
    );
  ELSE
    StdLog.String("Error reading input.");
    StdLog.Ln;
  END;
  
  StdLog.String("=== End of Execution ===");
  StdLog.Ln;
END Main.
