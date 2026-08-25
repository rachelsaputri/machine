! Transformer Module
! Applies data transformations

USING: kernel math sequences ;
IN: transformer

: add-calculated-field ( data -- new-data )
    ! Example: Add a calculated field based on existing fields
    [ 
        ! Assume data is a sequence of associations
        [ 
            ! For each record
            [ 
                ! Example: Add a field 'total' as sum of 'price' and 'tax'
                dup 
                "price" get 
                "tax" get + 
                "total" set-at
            ] each
        ]
    ]

: normalize-values ( data -- normalized-data )
    ! Example: Normalize numeric values to a standard range
    [ 
        ! Assume data is a sequence of associations
        [ 
            ! For each record
            [ 
                ! Example: Normalize 'score' field to 0-1 range
                dup 
                "score" get 
                100 / 
                "score" set-at
            ] each
        ]
    ]

! Exported words
EXPORTS:
    add-calculated-field
    normalize-values
