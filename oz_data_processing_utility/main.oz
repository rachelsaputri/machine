functor Main
import
   App
   OzSystem
   Ingester
   Transformer
   Validator
   Reporter
   StdLib
   List
   Stream

define
   {Unlock App}
   
   declare
      ProcessingPipeline :: {NewThreadRef}
   end

   %% Main entry point
   local
      DataSource = os.getenv 'DATA_SOURCE' | 'in-memory'
      OutputDest = os.getenv 'OUTPUT_DEST' | 'stdout'
   in
      %% Initialize the processing pipeline
      declare
         Pipeline :: {New Process}
         Results :: {New Port}
      end
      
      {Process.start 
         fun {$} 
            %% 1. Ingest Data
            declare
               RawData :: Object
            end
            RawData := {Ingester.ingest DataSource}
            
            %% 2. Transform Data
            declare
               TransformedData :: Object
            end
            TransformedData := {Transformer.transform RawData}
            
            %% 3. Validate Data
            declare
               ValidationResult :: Object
            end
            ValidationResult := {Validator.validate TransformedData}
            
            %% 4. Report Results
            {Reporter.report ValidationResult OutputDest}
            {Show 'Processing complete.'}
            return ok
         end 
      }
   end

define
   %% Helper to start the main process
   {Process.launch Main}
   
   {System.exit 0}
end

export
   % Expose main entry point if needed by other modules
   % (Usually handled by the system loader, but explicit export for clarity)

define
   % Empty export list for the module structure
end
