(* wolfram_data_processing_utility/main.wl *)
(* Orchestrates the ETL pipeline *)

BeginPackage["WolframDataProcessingUtility"]; 

RunWolframPipeline::usage = "RunWolframPipeline[file] loads, validates, transforms, and reports on the data in file.";

Begin["Private"]; 

(* Load sub-modules *)
Needs["WolframDataProcessingUtility`ingestor`"]; 
Needs["WolframDataProcessingUtility`validator`"]; 
Needs["WolframDataProcessingUtility`transformer`"]; 
Needs["WolframDataProcessingUtility`reporter`"]; 

RunWolframPipeline[file_] := Module[
  {data, isValid, transformed, summary},
  
  Print["[INFO] Starting Wolfram Data Processing Pipeline..."]; 
  
  (* 1. Ingest *)
  data = WolframDataIngestor[file]; 
  Print["[INFO] Data ingested successfully. " <> ToString[Length[data]] <> " records found."]; 
  
  (* 2. Validate *)
  If[data === $Failed || Length[data] == 0, 
    Return["Error: Failed to ingest data."]
  ]; 
  
  isValid = WolframDataValidator[data]; 
  If[! isValid, 
    Print["[WARNING] Validation warnings occurred. Proceeding with available data."]; 
  ]; 
  
  (* 3. Transform *)
  transformed = WolframDataTransformer[data]; 
  Print["[INFO] Data transformation complete."]; 
  
  (* 4. Report *)
  summary = WolframDataReporter[transformed]; 
  Print["[INFO] Pipeline execution complete. Summary:"]; 
  Print[summary]; 
  
  transformed
]; 

End[]; 

EndPackage[];
