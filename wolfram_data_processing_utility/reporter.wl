(* wolfram_data_processing_utility/reporter.wl *)
(* Generates reports and visualizations *)

BeginPackage["WolframDataProcessingUtility`reporter"]; 

WolframDataReporter::usage = "WolframDataReporter[data] generates a summary report.";

Begin["Private"]; 

WolframDataReporter[data_] := Module[
  {len, numericCols, summary, viz},
  
  len = Length[data]; 
  summary = <|
    "Total Records" -> len,
    "Columns" -> Keys[data[[1]]],
    "Status" -> "Complete"
  |>; 
  
  If[len > 0 && DatasetQ[data], 
    (* Visualizations *)
    numericCols = Select[Keys[data[[1]]], 
      NumberQ[data[[1]][#]] || Head[data[[1]][#]] === Real || Head[data[[1]][#]] === Integer &
    ]; 
    
    If[Length[numericCols] > 0, 
      viz = Histogram[data[[All, numericCols[[1]]]], 20]; 
      Print[viz]
    ]
  ]; 
  
  Return[summary]
]; 

End[]; 

EndPackage[];
