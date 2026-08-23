functor Reporter
import
   App
   OzSystem
   StdLib
   List
   Stream
   Parser

define
   %% Reports validation results and processing metrics
   fun {Report ValidationResults OutputDest}
      case ValidationResults of
         {tuple ValidRecords:Valid InvalidRecords:Invalid Violations:Violations}
            local
               TotalRecords :: int
               ValidCount :: int
               InvalidCount :: int
               PassRate :: float
            in
               TotalRecords := {Length ValidRecords} + {Length InvalidRecords}
               ValidCount := {Length ValidRecords}
               InvalidCount := {Length InvalidRecords}
               
               if TotalRecords > 0 then
                  PassRate := {Float.fromReal ValidCount} / {Float.fromReal TotalRecords}
               else
                  PassRate := 0.0
               end
               
               local
                  ReportStr :: string
               in
                  ReportStr := 'Processing Report:\n'
                             | '---------------------\n'
                             | 'Total Records: '|{Int.toString TotalRecords}|'\n'
                             | 'Valid: '|{Int.toString ValidCount}|'\n'
                             | 'Invalid: '|{Int.toString InvalidCount}|'\n'
                             | 'Pass Rate: '|{Float.toString PassRate}|'\n'
                             | '---------------------\n'
                             | 'Violations:\n'
                             | {List.fold1 
                                  fun {$ V Acc}
                                     Acc | V | '\n'
                                  end 
                                  '' 
                                  Violations
                                }
                  
                  case OutputDest of
                     'stdout'
                        {Show ReportStr}
                     
                     'file://'{Path}
                        {Parser.writeToFile Path ReportStr}
                     
                     else
                        {Show 'Unsupported output destination: '|OutputDest}
                  end
               end
            end
         
         else
            {Error.raise 'Invalid validation results structure'}
      end
   end

define
   %% Wrapper function for external access
   fun {report ValidationResults OutputDest}
      {Report ValidationResults OutputDest}
   end

define
   % Exported function
end

export
   report: Reporter.report

define
   % Implementation
   local
      Report :: Reporter.report
   in
      Report := {Report}
   end
end
