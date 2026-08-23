import Foundation

actor IngestionEngine {
    private(set) var processedCount: Int = 0
    private(set) var failedCount: Int = 0
    
    func recordSuccess() {
        processedCount += 1
    }
    
    func recordFailure() {
        failedCount += 1
    }
    
    func getStatus() -> String {
        return "Success: \(processedCount), Failures: \(failedCount)"
    }
}
