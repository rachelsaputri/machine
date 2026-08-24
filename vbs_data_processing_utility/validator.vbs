' ============================================================================
' validator.vbs - Data Validation Engine
' ============================================================================

Function ValidateData(pData, pConfig)
    Dim arrValid
    Dim i, j, arrRow
    Dim blnValid
    
    ReDim arrValid(0)
    arrValid(0) = Empty
    
    For i = 0 To UBound(pData)
        blnValid = True
        arrRow = pData(i)
        
        ' Example Validation: Check if first column is not empty
        If Trim(arrRow(0)) = "" Then
            blnValid = False
        End If
        
        If blnValid Then
            arrValid(UBound(arrValid)) = arrRow
            ReDim Preserve arrValid(UBound(arrValid) + 1)
        End If
    Next
    
    If UBound(arrValid) > 0 Then
        ReDim Preserve arrValid(UBound(arrValid) - 1)
        ValidateData = arrValid
    Else
        ValidateData = Empty
    End If
End Function
