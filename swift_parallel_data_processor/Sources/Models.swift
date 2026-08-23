import Foundation

enum ProcessingError: Error, LocalizedError {
    case decodingFailed
    case transformationFailed
    case validationFailed
    case processingCancelled
    case networkTimeout
    
    var errorDescription: String? {
        switch self {
        case .decodingFailed:
            return "Failed to decode input record"
        case .transformationFailed:
            return "Failed to transform record"
        case .validationFailed:
            return "Failed to validate record"
        case .processingCancelled:
            return "Processing was cancelled"
        case .networkTimeout:
            return "Network request timed out"
        }
    }
}

struct ProcessingConfig: Sendable {
    let maxConcurrency: Int
    let batchSize: Int
    let retryAttempts: Int
    
    init(maxConcurrency: Int = 4, batchSize: Int = 10, retryAttempts: Int = 3) {
        self.maxConcurrency = maxConcurrency
        self.batchSize = batchSize
        self.retryAttempts = retryAttempts
    }
}

struct ProcessingResult: Sendable {
    let inputId: Int
    let outputPayload: String
    let success: Bool
    let error: String?
    let processingTime: TimeInterval
}
