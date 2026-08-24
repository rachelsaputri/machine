(* wolfram_data_processing_utility/ingestor.wl *)
(* Handles loading data from CSV and JSON *)

BeginPackage["WolframDataProcessingUtility`ingestor"]; 

WolframDataIngestor::usage = "WolframDataIngestor[file] loads data.";

Begin["Private"]; 

WolframDataIngestor[file_] := Module[
  {ext, data, error},
  
  ext = ToLowerCase[FileExtension[file]]; 
  
  Switch[ext, 
    "csv", 
      data = Import[file, "CSV"]; 
      If[Length[data] > 0, Head[data[[1]]] === List, 
        Return[$Failed]; 
      ]; 
      (* Extract headers and convert to dataset *)
      If[Length[data] > 0, 
        Return[Dataset[AssociationThread[First[data] -> #] & /@ Rest[data]]]; 
      , 
        Return[$Failed]
      ], 
    "json", 
      data = Import[file, "JSON"]; 
      If[Head[data] === List, 
        Return[Dataset[data]], 
        Return[Dataset[{data}]]
      ], 
    "wl", 
      Return[Import[file, "WDX"]] 
  ]; 
  
  Return[$Failed]
]; 

End[]; 

EndPackage[];
