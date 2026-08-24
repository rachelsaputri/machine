(* wolfram_data_processing_utility/transformer.wl *)
(* Transforms data, calculates basic statistics, removes duplicates *)

BeginPackage["WolframDataProcessingUtility`transformer"]; 

WolframDataTransformer::usage = "WolframDataTransformer[data] performs transformations.";

Begin["Private"]; 

WolframDataTransformer[data_] := Module[
  {dataset, cleaned, numericCols, stats, transformed},
  
  (* Ensure we have a Dataset *)
  If[AssociationQ[data], 
    dataset = Dataset[{data}], 
    dataset = Dataset[data]
  ]; 
  
  (* 1. Remove empty rows *)
  cleaned = Select[dataset, Length[#] > 0 &]; 
  
  (* 2. Basic numeric aggregation if numeric columns exist *)
  If[Length[cleaned] > 0, 
    numericCols = Select[Keys[cleaned[[1]]], 
      NumberQ[cleaned[[1]][#]] || Head[cleaned[[1]][#]] === Real || Head[cleaned[[1]][#]] === Integer &
    ]; 
    
    stats = Association[]; 
    Do[
      stats = AssociateTo[stats, 
        # -> {
          Mean[cleaned[[All, #]], IgnoreMissing -> True], 
          Median[cleaned[[All, #]], IgnoreMissing -> True]
        }
      ]; 
    , {#}]; 
  ]; 
  
  Return[cleaned]
]; 

End[]; 

EndPackage[];
