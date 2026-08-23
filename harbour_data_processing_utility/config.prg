// Configuration Management

STATIC cInputFile
STATIC cOutputFile
STATIC cReportFile
STATIC bValidRecord

FUNCTION SetInputFile(cFile)
    cInputFile := cFile
    RETURN Nil

FUNCTION GetInputFile()
    RETURN If(Empty(cInputFile), "data/input.csv", cInputFile)

FUNCTION SetOutputFile(cFile)
    cOutputFile := cFile
    RETURN Nil

FUNCTION GetOutputFile()
    RETURN If(Empty(cOutputFile), "data/output.csv", cOutputFile)

FUNCTION SetReportFile(cFile)
    cReportFile := cFile
    RETURN Nil

FUNCTION GetReportFile()
    RETURN If(Empty(cReportFile), "reports/processing_report.txt", cReportFile)

FUNCTION SetValidationRule(bRule)
    bValidRecord := bRule
    RETURN Nil

FUNCTION GetValidationRule()
    RETURN If(Empty(bValidRecord), {|o| .T.}, bValidRecord)
