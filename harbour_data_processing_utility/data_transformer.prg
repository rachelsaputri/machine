// Data Transformation Module

#include "config.prg"

FUNCTION TransformData()
    LOCAL aRecords := LoadRecords()
    LOCAL aTransformed := {}
    LOCAL i
    LOCAL oRecord

    FOR i := 1 TO Len(aRecords)
        oRecord := Clone(oRecords[i])
        
        // Transformation Rule 1: Normalize Name to Upper Case
        oRecord:"name" := Upper(oRecord:"name")
        
        // Transformation Rule 2: Double Value
        oRecord:"value" := oRecord:"value" * 2
        
        // Transformation Rule 3: Add Timestamp
        oRecord:"transformed_at" := DTOC(Date())
        
        INSERT INTO aTransformed VALUE oRecord
    NEXT

    SaveRecords(aTransformed)
    RETURN .T.

FUNCTION Clone(oObj)
    LOCAL aKeys
    LOCAL aNewObj := {}
    LOCAL k
    
    aKeys := ObjKeys(oObj)
    FOR EACH k IN aKeys
        aNewObj[k] := oObj[k]
    NEXT
    RETURN aNewObj
