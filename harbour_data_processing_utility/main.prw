// Main entry point for Harbour Data Processing Utility

#xcommand INCLUDE "config.prg"
#xcommand INCLUDE "data_ingester.prg"
#xcommand INCLUDE "data_validator.prg"
#xcommand INCLUDE "data_transformer.prg"
#xcommand INCLUDE "data_reporter.prg"

PROCEDURE Main()
    LOCAL lSuccess := .T.
    LOCAL oLog

    oLog := CreateObject("TLogManager")
    oLog:SetOutputLevel(1) // Verbose
    oLog:WriteLog("Starting Data Processing Utility...")

    // Initialize Configuration
    InitConfiguration()

    // Step 1: Ingest Data
    oLog:WriteLog("Step 1: Ingesting Data...")
    IF !IngestData()
        oLog:WriteLog("ERROR: Data ingestion failed.")
        lSuccess := .F.
    ELSE
        oLog:WriteLog("Data ingestion completed successfully.")
    ENDIF

    // Step 2: Validate Data
    IF lSuccess
        oLog:WriteLog("Step 2: Validating Data...")
        IF !ValidateData()
            oLog:WriteLog("ERROR: Data validation failed.")
            lSuccess := .F.
        ELSE
            oLog:WriteLog("Data validation passed.")
        ENDIF
    ENDIF

    // Step 3: Transform Data
    IF lSuccess
        oLog:WriteLog("Step 3: Transforming Data...")
        IF !TransformData()
            oLog:WriteLog("ERROR: Data transformation failed.")
            lSuccess := .F.
        ELSE
            oLog:WriteLog("Data transformation completed successfully.")
        ENDIF
    ENDIF

    // Step 4: Report Results
    IF lSuccess
        oLog:WriteLog("Step 4: Generating Report...")
        IF !GenerateReport()
            oLog:WriteLog("ERROR: Report generation failed.")
            lSuccess := .F.
        ELSE
            oLog:WriteLog("Report generation completed successfully.")
        ENDIF
    ENDIF

    IF lSuccess
        oLog:WriteLog("Processing completed successfully.")
    ELSE
        oLog:WriteLog("Processing encountered errors.")
    ENDIF

    oLog:Destroy()
    RETURN

PROCEDURE InitConfiguration()
    // Default configuration values
    ::cInputFile := "data/input.csv"
    ::cOutputFile := "data/output.csv"
    ::cReportFile := "reports/processing_report.txt"
    ::bValidRecord := {|oRecord| Empty(oRecord:cError) }
    RETURN
