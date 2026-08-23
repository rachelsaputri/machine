/*
 * Data Reporter Implementation in Phrogram
 * This file has been duplicated in the previous output. 
 * I will provide the corrected, unique reporter.ph content here.
 */

include "config.ph"
include "data_types.ph"
include "logger.ph"

module Reporter

    class Reporter
        private
            var logger: Logger
            var logFile: String

        public
            constructor(logger, logFile)
                this.logger := logger
                this.logFile := logFile
            end constructor

            function initialize():
                logger.info("Initializing Reporter")
                createLogDir()
            end function

            function generateReport(report: ProcessingReport):
                logger.info("Generating processing report")
                var content := "Processing Report\n"
                content += "=====================\n"
                content += "Total Records: " + report.totalRecords + "\n"
                content += "Processed Records: " + report.processedRecords + "\n"
                content += "Failed Records: " + report.failedRecords + "\n"
                content += "Warnings: " + report.warnings + "\n"
                content += "Start Time: " + report.startTime + "\n"
                content += "End Time: " + report.endTime + "\n"
                content += "Duration: " + report.durationMs + "ms\n"
                content += "=====================\n"

                writeFile(this.logFile, content, true)
                logger.info("Report generated at " + this.logFile)
            end function

            function finalize():
                logger.info("Finalizing Reporter")
            end function

        private
            function createLogDir():
                if !fileExists(Config.OUTPUT_DIR)
                    createDir(Config.OUTPUT_DIR)
                end if
            end function

    end module
