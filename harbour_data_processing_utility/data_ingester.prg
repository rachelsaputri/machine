// Data Ingestion Module

#include "config.prg"

FUNCTION IngestData()
    LOCAL cFile := GetInputFile()
    LOCAL aRecords := {}
    LOCAL aLine
    LOCAL oFile
    LOCAL nLineNum := 0

    IF !FileExist(cFile)
        // Create sample data for demonstration if file doesn't exist
        CreateSampleData(cFile)
    ENDIF

    oFile := FOpen(cFile, FO_READ)
    IF oFile == NIL
        MsgInfo("Could not open file: " + cFile)
        RETURN .F.
    ENDIF

    // Read header
    FReadLine(oFile, @aLine)
    // Parse header to define structure
    // Assuming CSV: ID,Name,Value
    
    WHILE .T.
        nLineNum++
        IF FEOF(oFile)
            EXIT
        ENDIF
        IF FReadLine(oFile, @aLine)
            // Simple CSV parsing
            IF Len(aLine) >= 3
                INSERT INTO aRecords VALUE (;
                    { ;
                        "id": Val(aLine[1]), ;
                        "name": Alltrim(aLine[2]), ;
                        "value": Val(aLine[3]), ;
                        "error": ""
                    } ;
                )
            ELSE
                INSERT INTO aRecords VALUE (;
                    { ;
                        "id": nLineNum, ;
                        "name": "", ;
                        "value": 0, ;
                        "error": "Malformed row " + Ltrim(Str(nLineNum))
                    } ;
                )
            ENDIF
        ENDIF
    ENDDO

    FClose(oFile)
    aRecords := LoadRecords()
    RETURN .T.

FUNCTION LoadRecords()
    // Simulate loading records into a global or class structure
    ::aGlobalData := aRecords
    RETURN aRecords

PROCEDURE CreateSampleData(cFile)
    LOCAL oFile
    DirCreate(Dir( cFile ) )
    oFile := FCreate(cFile)
    IF oFile != NIL
        FWriteLine(oFile, "ID,Name,Value")
        FWriteLine(oFile, "1,Item A,100")
        FWriteLine(oFile, "2,Item B,200")
        FWriteLine(oFile, "3,Item C,300")
        FClose(oFile)
    ENDIF
    RETURN
