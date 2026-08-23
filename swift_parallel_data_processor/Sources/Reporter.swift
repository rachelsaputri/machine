import Foundation

struct ReportGenerator {
    static func generateReport(results: [ProcessingResult]) {
        print("\n--- Processing Report ---")
        let successes = results.filter { $0.success }.count
        let failures = results.filter { !$0.success }.count
        let totalTime = results.reduce(0) { $0 + $1.processingTime }
        let avgTime = results.isEmpty ? 0 : totalTime / Double(results.count)
        
        print("Total Records Processed: \(results.count)")
        print("Successful: \(successes)")
        print("Failed: \(failures)")
        print("Average Processing Time: \(avgTime.formatted(.number.precision(.fractionLength(3))) s)")
        print("--- End Report ---\n")
    }
}
