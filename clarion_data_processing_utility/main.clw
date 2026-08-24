MODULE
INCLUDE('std.inc')
INCLUDE('DataIngestor.clw')
INCLUDE('DataValidator.clw')
INCLUDE('DataTransformer.clw')
INCLUDE('DataReporter.clw')

PROGRAM

DATA
    IngestorHandle        LONG
    ValidatorHandle       LONG
    TransformerHandle     LONG
    ReporterHandle        LONG
    ProcessedData         STRING[1024]

CODE
    ! Initialize the data processing pipeline
    IngestorHandle = CreateDataIngestor()
    ValidatorHandle = CreateDataValidator()
    TransformerHandle = CreateDataTransformer()
    ReporterHandle = CreateDataReporter()

    ! Ingest data
    ProcessedData = IngestData(IngestorHandle, 'source_data.txt')

    ! Validate data
    IsValid = ValidateData(ValidatorHandle, ProcessedData)
    IF NOT IsValid
        Message('Data validation failed.')
        RETURN
    END

    ! Transform data
    ProcessedData = TransformData(TransformerHandle, ProcessedData)

    ! Generate report
    GenerateReport(ReporterHandle, ProcessedData, 'output_report.txt')

    ! Clean up
    DestroyDataIngestor(IngestorHandle)
    DestroyDataValidator(ValidatorHandle)
    DestroyDataTransformer(TransformerHandle)
    DestroyDataReporter(ReporterHandle)

END
