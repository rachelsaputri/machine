MODULE
INCLUDE('std.inc')

DATA
    SourceFile            STRING[255]
    DataBuffer            STRING[1024]

CODE

PROCEDURE CreateDataIngestor(), LONG
    ! Allocate memory for the ingester handle
    RETURN AllocateMemory(SIZEOF(LONG))
END

PROCEDURE DestroyDataIngestor(HANDLE LONG), LONG
    ! Free the allocated memory for the ingester handle
    FreeMemory(HANDLE)
END

PROCEDURE IngestData(HANDLE LONG, SourceFile STRING[255]), STRING[1024]
    DATA
        FileHandle          LONG
        LineBuffer          STRING[255]
        TotalData           STRING[1024]

    CODE
    ! Open the source file
    FileHandle = OPEN(SourceFile, #READ)
    IF FileHandle = 0
        RETURN ''
    END

    ! Read data line by line
    DO WHILE READ(FileHandle, LineBuffer) = 0
        TotalData &+= LineBuffer &CRLF
    END

    ! Close the file
    CLOSE(FileHandle)

    RETURN TotalData
END
