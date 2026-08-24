' ============================================================================
' reporter.vbs - Reporting and Export Engine
' ============================================================================

Function GenerateReport(pData, pConfig)
    Dim intCount
    intCount = UBound(pData)
    GenerateReport = "Processed " & (intCount + 1) & " records successfully."
End Function

Sub ExportData(pData, pFilePath)
    Dim objFile, i, j, strLine
    
    Set objFile = objFSO.CreateTextFile(pFilePath, True)
    For i = 0 To UBound(pData)
        strLine = ""
        For j = 0 To UBound(pData(i))
            If j > 0 Then strLine = strLine & ","
            strLine = strLine & pData(i)(j)
        Next
        objFile.WriteLine strLine
    Next
    objFile.Close
End Sub
