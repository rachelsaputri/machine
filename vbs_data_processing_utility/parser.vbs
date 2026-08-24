' ============================================================================
' parser.vbs - Data Ingestion and Parsing
' ============================================================================

Function ParseCSV(pFilePath, pSkipHeader)
    Dim objFile, strLine, arrLines, arrHeaders, arrRows
    Dim i, j, arrFields, intCount
    
    Set objFile = objFSO.OpenTextFile(pFilePath, 1)
    arrLines = Split(objFile.ReadAll, vbCrLf)
    objFile.Close
    
    intCount = UBound(arrLines)
    If intCount < 0 Then Exit Function
    
    If pSkipHeader Then
        arrHeaders = Split(arrLines(0), ",")
        ReDim arrRows(0 To intCount - 1)
        For i = 1 To intCount
            arrRows(i - 1) = Split(arrLines(i), ",")
        Next
        ParseCSV = arrRows
    Else
        ReDim arrRows(0 To intCount)
        For i = 0 To intCount
            arrRows(i) = Split(arrLines(i), ",")
        Next
        ParseCSV = arrRows
    End If
End Function
