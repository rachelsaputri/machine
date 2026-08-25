! Validator Module
! Contains validation logic and error handling

USING: kernel sequences math prettyprint ;
IN: validator

: check-field ( field-name value -- ? )
    ! Example: Check if field exists and is not null
    [ "> null" compare ] keep 
    [ "null" = not ] 
    [ "" = not ] and ;

: validate-data ( data -- valid-data | error )
    ! Example validation logic
    data 
    [ 
        ! Check if data is a sequence
        [ "> sequence?" ] keep 
        [ 
            ! Check each item in the sequence
            [ 
                ! Example: Ensure each item has a required field "id"
                [ "id" key? ] keep 
                [ 
                    ! Example: Ensure "id" is a number
                    "id" get number? 
                    [ 
                        ! Example: Ensure "value" is present
                        [ "value" key? ] keep 
                        [ "value" get not-null? ] and 
                    ] [ "Missing 'value' field" throw ] if 
                ] [ "Missing 'id' field" throw ] if 
            ] each
        ] [ "Data is not a sequence" throw ] if 
    ] [ "Data is not valid" throw ] if ;

! Exported words
EXPORTS:
    check-field
    validate-data
