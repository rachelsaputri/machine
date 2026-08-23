// Data Validation Module

#include "config.prg"

FUNCTION ValidateData()
    LOCAL aRecords := LoadRecords()
    LOCAL aValidRecords := {}
    LOCAL aInvalidRecords := {}
    LOCAL i
    LOCAL oRecord
    LOCAL bRule := GetValidationRule()

    FOR i := 1 TO Len(aRecords)
        oRecord := aRecords[i]
        
        // Check for pre-existing errors
        IF !Empty(oRecord:"error")
            INSERT INTO aInvalidRecords VALUE oRecord
            LOOP
        ENDIF

        // Business Rule: Value must be positive
        IF oRecord:"value" < 0
            oRecord:"error" := "Value must be positive"
            INSERT INTO aInvalidRecords VALUE oRecord
        ELSE
            // Custom validation rule
            IF Eval(bRule, oRecord)
                INSERT INTO aValidRecords VALUE oRecord
            ELSE
                oRecord:"error" := "Validation failed"
                INSERT INTO aInvalidRecords VALUE oRecord
            ENDIF
        ENDIF
    NEXT

    SaveRecords(aValidRecords)
    ::aInvalidRecords := aInvalidRecords
    RETURN Len(aInvalidRecords) == 0

FUNCTION SaveRecords(aRecords)
    // Save validated records back to global structure
    ::aGlobalData := aRecords
    RETURN .T.
