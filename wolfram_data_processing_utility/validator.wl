(* wolfram_data_processing_utility/validator.wl *)
(* Validates data types and schemas *)

BeginPackage["WolframDataProcessingUtility`validator"]; 

WolframDataValidator::usage = "WolframDataValidator[data] validates the dataset.";

Begin["Private"]; 

WolframDataValidator[data_] := Module[
  {valid, headers, errors, count, len},
  
  If[! AssociationQ[data] && ! DatasetQ[data], 
    Return[False]
  ]; 
  
  len = Length[data]; 
  
  (* If it's a Dataset, check the underlying rules *)
  If[DatasetQ[data], 
    data = Normal[data]
  ]; 
  
  errors = {};
  
  (* Validate that we have a list of associations *)
  If[Head[data] =!= List, Return[False]]; 
  If[len == 0, Return[False]]; 
  
  valid = True; 
  
  (* Check basic type consistency for the first few rows *)
  Do[
    If[Head[data[[i]]] =!= Association, valid = False; Break[]]; 
  , {i, Min[10, len]}]; 
  
  If[! valid, Return[False]]; 
  
  Return[True]
]; 

End[]; 

EndPackage[];
