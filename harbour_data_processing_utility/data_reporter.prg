// Data Reporting Module

#include "config.prg"

FUNCTION GenerateReport()
    LOCAL cReportFile := GetReportFile()
    LOCAL cValidCount := Ltrim(Str(Len(LoadRecords())))
    LOCAL cInvalidCount := Ltrim(Str(Len(::aInvalidRecords)))
    LOCAL oFile

    DirCreate(Dir(cReportFile))
    
    oFile := FCreate(cReportFile)
    IF oFile == NIL
        MsgInfo("Could not create report file: " + cReportFile)
        RETURN .F.
    ENDIF

    FWriteLine(oFile, "========================================")
    FWriteLine(oFile, "DATA PROCESSING REPORT")
    FWriteLine(oFile, "========================================")
    FWriteLine(oFile, "Date: " + DTOC(Date()))
    FWriteLine(oFile, "----------------------------------------")
    FWriteLine(oFile, "Records Validated: " + cValidCount)
    FWriteLine(oFile, "Records Rejected:  " + cInvalidCount)
    FWriteLine(oFile, "----------------------------------------")

    IF Len(::aInvalidRecords) > 0
        FWriteLine(oFile, "\nREJECTED RECORDS:")
        FOR EACH oRec IN ::aInvalidRecords
            FWriteLine(oFile, "ID: " + Ltrim(Str(oRec:"id")) + " | Name: " + oRec:"name" + " | Error: " + oRec:"error")
        NEXT
    ENDIF

    FWriteLine(oFile, "========================================")
    FWriteLine(oFile, "END OF REPORT")
    FWriteLine(oFile, "========================================")

    FClose(oFile)
    RETURN .T.
