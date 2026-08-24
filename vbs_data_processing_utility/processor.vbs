' ============================================================================
' processor.vbs - Main Processing Logic
' ============================================================================
Option Explicit

' Global references to other modules
Dim objDataValidator, objDataTransformer, objDataReporter

' Initialize objects
Set objDataValidator = CreateObject("Scripting.Dictionary")
Set objDataTransformer = CreateObject("Scripting.Dictionary")
Set objDataReporter = CreateObject("Scripting.Dictionary")

' Load other modules
Dim objFSO, strScriptPath
Set objFSO = CreateObject("Scripting.FileSystemObject")
strScriptPath = objFSO.GetParentFolderName(WScript.ScriptFullName)

ExecuteGlobal objFSO.OpenTextFile(strScriptPath & "\validator.vbs").ReadAll
ExecuteGlobal objFSO.OpenTextFile(strScriptPath & "\transformer.vbs").ReadAll
ExecuteGlobal objFSO.OpenTextFile(strScriptPath & "\reporter.vbs").ReadAll
ExecuteGlobal objFSO.OpenTextFile(strScriptPath & "\parser.vbs").ReadAll

' Main Processing Function
Function Process(pConfig)
    Dim strInputFile, strOutputFile
    strInputFile = pConfig.Item("InputFile")
    strOutputFile = pConfig.Item("OutputFile")
    
    If Not objFSO.FileExists(strInputFile) Then
        WScript.Echo "Error: Input file not found: " & strInputFile
        Process = False
        Exit Function
    End If
    
    ' 1. Parse/Ingest
    Dim arrData
    arrData = ParseCSV(strInputFile, CBool(pConfig.Item("SkipHeaderRow")))
    If IsEmpty(arrData) Then
        WScript.Echo "Error: No data parsed."
        Process = False
        Exit Function
    End If
    
    ' 2. Validate
    Dim arrValidData
    arrValidData = ValidateData(arrData, pConfig)
    If IsEmpty(arrValidData) Then
        WScript.Echo "Error: Validation failed for all records."
        Process = False
        Exit Function
    End If
    
    ' 3. Transform
    Dim arrProcessedData
    arrProcessedData = TransformData(arrValidData, pConfig)
    
    ' 4. Report & Export
    Dim strLog, strExport
    strLog = GenerateReport(arrProcessedData, pConfig)
    ExportData arrProcessedData, strOutputFile
    
    WScript.Echo "Success: Processed " & UBound(arrProcessedData) & " records."
    Process = True
End Function
