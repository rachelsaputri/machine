' ============================================================================
' transformer.vbs - Data Transformation Engine
' ============================================================================

Function TransformData(pData, pConfig)
    Dim arrTransformed
    Dim i, arrRow, newArr
    Dim strTrim
    
    strTrim = CBool(pConfig.Item("TrimWhitespace"))
    ReDim arrTransformed(UBound(pData))
    
    For i = 0 To UBound(pData)
        arrRow = pData(i)
        ReDim newArr(UBound(arrRow))
        
        For j = 0 To UBound(arrRow)
            If strTrim Then
                newArr(j) = Trim(arrRow(j))
            Else
                newArr(j) = arrRow(j)
            End If
        Next
        
        arrTransformed(i) = newArr
    Next
    
    TransformData = arrTransformed
End Function
