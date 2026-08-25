! Ingester Module
! Handles loading data from JSON and CSV files

USING: io io.files io.streams io.encodings.utf8 io.json io.csv ;
IN: ingester

: ingest-json-file ( file-path -- data )
    utf8 [ read-json ] with-file-input ;

: ingest-csv-file ( file-path -- rows )
    utf8 [ read-csv ] with-file-input ;

: ingest-data ( file-path -- data )
    ! Determine file type based on extension
    extname 
    "json" = 
    [ ingest-json-file ] 
    [ "csv" = [ ingest-csv-file ] [ drop "Unsupported format" throw ] if ] if ;

! Exported words
EXPORTS:
    ingest-json-file
    ingest-csv-file
    ingest-data
