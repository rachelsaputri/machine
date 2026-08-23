(*
 * validator.sml
 *
 * Functions for validating data.
 * Checks for required fields and data type constraints.
 *)

structure Validator = struct
    structure Parser = Parser
    datatype ValidationResult = Valid of Parser.Record list | Invalid of string list

    (* Validate a single record *)
    fun validateRecord record =
        let
            val errors = []
            (* Check if id is positive *)
            val idError =
                if record.id > 0 then
                    NONE
                else
                    SOME ("Record with name " ^ record.name ^ " has invalid id: " ^ Int.toString record.id)
            (* Check if value is within range *)
            val valueError =
                if #-100.0 <= record.value andalso record.value <= 100.0 then
                    NONE
                else
                    SOME ("Record with name " ^ record.name ^ " has out-of-range value: " ^ Real.toString record.value)
        in
            case (idError, valueError) of
                (NONE, NONE) => true
              | (SOME e1, NONE) => (print (e1 ^ "\n"); false)
              | (NONE, SOME e2) => (print (e2 ^ "\n"); false)
              | (SOME e1, SOME e2) => (print (e1 ^ "\n"); print (e2 ^ "\n"); false)
        end

    (* Validate all records *)
    fun validateData records =
        let
            val validRecords = List.filter validateRecord records
            val errorCount = length records - length validRecords
        in
            if errorCount = 0 then
                Valid validRecords
            else
                Invalid (error :: [])(* Placeholder for error generation logic, will be implemented below *)
        end

    fun validateDataWithErrors records =
        let
            val errors =
                List.mapPartial (fn record =>
                    let
                        val idError =
                            if record.id > 0 then
                                NONE
                            else
                                SOME ("Record with name " ^ record.name ^ " has invalid id: " ^ Int.toString record.id)
                        val valueError =
                            if #-100.0 <= record.value andalso record.value <= 100.0 then
                                NONE
                            else
                                SOME ("Record with name " ^ record.name ^ " has out-of-range value: " ^ Real.toString record.value)
                    in
                        case (idError, valueError) of
                            (NONE, NONE) => NONE
                          | (SOME e1, NONE) => SOME e1
                          | (NONE, SOME e2) => SOME e2
                          | (SOME e1, SOME e2) => SOME e1 (* Simplified to one error per record for this example *)
                    end) records
        in
            if null errors then
                Valid records
            else
                Invalid errors
        end
end
