(*
 * main.sml
 *
 * Main entry point for the SML Data Processing Utility.
 * Reads input data, processes it through validation and transformation,
 * and generates a report.
 *)

structure Main = struct
    structure Parser = Parser
    structure Validator = Validator
    structure Transformer = Transformer
    structure Reporter = Reporter

    val inputFilePath = "input.txt"
    val outputFilePath = "output.txt"

    val _ =
        let
            (* Read input file *)
            val inputLines = Parser.readFile inputFilePath

            (* Parse data *)
            val parsedData = Parser.parseData inputLines

            (* Validate data *)
            val validationResult = Validator.validateData parsedData

            case validationResult of
                Validator.Valid validData =>
                    let
                        (* Transform data *)
                        val transformedData = Transformer.transformData validData

                        (* Generate report *)
                        val report = Reporter.generateReport validData transformedData

                        (* Write report to file *)
                        Reporter.writeReport outputFilePath report

                        print ("Data processing completed successfully. Report written to " ^ outputFilePath ^ "\n")
                    end
              | Validator.Invalid errors =>
                    let
                        val errorMessage = String.concatWith "\n" errors
                    in
                        print ("Data validation failed:\n" ^ errorMessage ^ "\n")
                    end
        end
end
