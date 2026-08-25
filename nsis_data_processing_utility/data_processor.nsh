; NSIS Data Processing Utility
; This script demonstrates data processing capabilities in NSIS
; It includes data ingestion, transformation, validation, and reporting modules

; Include modern UI library for better UX
!include "MUI2.nsh"

; Configuration Constants
!define APP_NAME "NSIS Data Processor"
!define APP_VERSION "1.0.0"
!define INPUT_FILE "${TEMP}\input_data.txt"
!define OUTPUT_FILE "${TEMP}\output_data.txt"
!define LOG_FILE "${TEMP}\processing_log.txt"

; UI Configuration
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_FINISH
!insertmacro MUI_LANGUAGE "English"

; Main Application Functions
Function .onInit
    InitPluginsDir
    StrCpy $0 ""
    StrCpy $1 ""
    StrCpy $2 ""
    StrCpy $3 ""
    StrCpy $4 ""
FunctionEnd

Function data_ingestion
    ; Ingest data from input file
    Exch $0 ; Input file path
    Push $1
    Push $2
    Push $3
    Push $4
    Push $5
    Push $6
    Push $7
    
    StrCpy $1 "" ; Line counter
    StrCpy $2 "" ; Data storage buffer
    
    IfFileExists $0 data_ingestion_read_data data_ingestion_error
    
data_ingestion_read_data:
    ClearErrors
    FileOpen $3 $0 "r"
    
    loop:
    ClearErrors
    FileRead $3 $4
    ${If} $4 == "" 
        Goto data_ingestion_close_file
    ${EndIf}
    
    IntOp $1 $1 + 1
    StrCpy $2 "$2$4$$
"
    
    Goto loop
    
data_ingestion_close_file:
    FileClose $3
    
data_ingestion_error:
    Pop $7
    Pop $6
    Pop $5
    Pop $4
    Pop $3
    Pop $2
    Pop $1
    Exch $0
    StrCpy $R0 $1 ; Store line count
    StrCpy $R1 $2 ; Store data buffer
    Pop $0 ; Get return value
    Exch $0
FunctionEnd

Function data_transformation
    ; Transform data in buffer
    Push $0 ; Input buffer
    Push $1
    Push $2
    Push $3
    Push $4
    Push $5
    Push $6
    
    Exch $0
    StrCpy $1 $0 ; Working buffer
    StrCpy $2 "" ; Result buffer
    StrCpy $3 "" ; Line counter
    
    loop_transform:
    ClearErrors
    StrCpy $4 $1 0 $
    ${If} $4 == ""
        Goto transform_clean_remaining
    ${EndIf}
    
    StrCpy $5 $1 0 $3
    StrCpy $4 $1 1 $3
    IntOp $3 $3 + 1
    
    ; Simple transformation: convert to uppercase and trim
    StrCpy $4 "$4" ; In real implementation, would use proper transformation
    StrCpy $2 "$2$4$$
"
    
    StrCpy $1 $1 $3
    Goto loop_transform
    
transform_clean_remaining:
    Pop $6
    Pop $5
    Pop $4
    Pop $3
    Pop $2
    Pop $1
    Pop $0
    StrCpy $R1 $2
    Pop $0
    Exch $0
FunctionEnd

Function data_validation
    ; Validate processed data
    Exch $0 ; Data to validate
    Push $1
    Push $2
    Push $3
    Push $4
    
    StrCpy $1 0 ; Valid line counter
    StrCpy $2 0 ; Invalid line counter
    StrCpy $3 "" ; Error messages
    
    loop_validate:
    ClearErrors
    ${If} $0 == ""
        Goto validation_complete
    ${EndIf}
    
    StrCpy $4 $0 0 50 ; Check first 50 chars
    ${If} $4 != ""
        IntOp $1 $1 + 1
    ${Else}
        IntOp $2 $2 + 1
        StrCpy $3 "$3Invalid line$$
"
    ${EndIf}
    
    StrCpy $0 $0 51
    Goto loop_validate
    
validation_complete:
    Pop $4
    Pop $3
    Pop $2
    Pop $1
    Exch $0
    StrCpy $R2 $1 ; Valid count
    StrCpy $R3 $2 ; Invalid count
    Pop $0
    Exch $0
FunctionEnd

Function data_export
    ; Export processed data to output file
    Exch $0 ; Output file path
    Exch
    Exch $0 ; Data buffer
    Push $1
    Push $2
    
    FileOpen $1 $0 "w"
    IfErrors export_error export_write
    
export_write:
    IfThen $0 "" export_close_file
    StrCpy $2 $0 0 50
    IfThen $2 "" export_write
    FileWrite $1 $2
    
    ${If} $0 != ""
        StrCpy $0 $0 51
        Goto export_write
    ${EndIf}
    
export_close_file:
    FileClose $1
    Goto export_success
    
export_error:
    StrCpy $R4 "Export failed"
    Goto export_success
    
export_success:
    Pop $2
    Pop $1
    Exch $0
    Exch
    Exch $0
    Pop $0
FunctionEnd

Function generate_report
    ; Generate processing report
    Exch $0 ; Report filename
    Push $1
    Push $2
    Push $3
    Push $4
    
    FileOpen $1 $0 "w"
    IfErrors report_error report_write_header
    
report_write_header:
    FileWrite $1 "=== DATA PROCESSING REPORT ===$$
"
    FileWrite $1 "Generated: ${CURRENT_DATE} ${CURRENT_TIME} $$
"
    FileWrite $1 "Application: ${APP_NAME} v${APP_VERSION} $$
"
    FileWrite $1 "=============================$$
$$
"
    
report_write_stats:
    StrCpy $2 "Lines Processed: $
"
    StrCpy $3 $2
    StrCpy $3 $3 -1 ; Remove newline
    StrCpy $3 $3 0 -1 ; Get count
    FileWrite $1 "$3 $$
"
    
    StrCpy $2 "Valid Lines: $
"
    StrCpy $3 $2
    StrCpy $3 $3 -1
    StrCpy $3 $3 0 -1
    FileWrite $1 "$3 $$
"
    
    StrCpy $2 "Invalid Lines: $
"
    StrCpy $3 $2
    StrCpy $3 $3 -1
    StrCpy $3 $3 0 -1
    FileWrite $1 "$3 $$
"
    
report_write_footer:
    FileWrite $1 "=============================$$
"
    FileWrite $1 "Processing completed successfully$$
"
    
    FileClose $1
    Goto report_success
    
report_error:
    StrCpy $R4 "Report generation failed"
    
report_success:
    Pop $4
    Pop $3
    Pop $2
    Pop $1
    Exch $0
FunctionEnd

Section "Data Processing Pipeline"
    SetOutPath $TEMP
    
    ; Step 1: Ingest data
    ${If} $INPUT_FILE != ""
        Push $INPUT_FILE
        Call data_ingestion
        Pop $0
    ${EndIf}
    
    ; Step 2: Transform data
    Push $R1
    Call data_transformation
    Pop $0
    
    ; Step 3: Validate data
    Push $R1
    Call data_validation
    Pop $0
    
    ; Step 4: Export processed data
    Push $OUTPUT_FILE
    Push $R1
    Call data_export
    Pop $0
    
    ; Step 5: Generate report
    StrCpy $0 "$TEMP\report.txt"
    Call generate_report
    Pop $0
    
    MessageBox MB_OK|MB_ICONINFORMATION "Data processing completed successfully!$$
Check output files in ${TEMP}"
SectionEnd

Section "-Additional Info"
SectionEnd
