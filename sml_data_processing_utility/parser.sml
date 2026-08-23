(*
 * parser.sml
 *
 * Functions for parsing input data.
 * Supports reading text files and parsing lines into records.
 *)

structure Parser = struct
    datatype Record = Record {
        id : int,
        name : string,
        value : real
    }

    (* Read all lines from a file *)
    fun readFile filePath =
        let
            val stream = TextIO.openIn filePath
            val lines =
                let
                    fun readLines [] = []
                      | readLines acc =
                        case TextIO.inputLine stream of
                            SOME line => readLines (line :: acc)
                          | NONE => acc
                in
                    readLines []
                end
            val _ = TextIO.closeIn stream
        in
            List.rev lines
        end

    (* Parse a single line into a Record *)
    fun parseLine line =
        let
            val tokens = String.tokens (fn c => c = #\,) line
            val idStr = List.nth (tokens, 0)
            val nameStr = List.nth (tokens, 1)
            val valueStr = List.nth (tokens, 2)
            val id = Int.fromString idStr
            val name = nameStr
            val value = Real.fromString valueStr
        in
            case (id, value) of
                (SOME i, SOME v) => SOME (Record {
                    id = i,
                    name = name,
                    value = v
                })
              | _ => NONE
        end

    (* Parse all lines into a list of Records *)
    fun parseData lines =
        let
            fun parseLine' (line, acc) =
                case parseLine line of
                    SOME record => record :: acc
                  | NONE => acc
        in
            foldl parseLine' [] lines
        end
end
