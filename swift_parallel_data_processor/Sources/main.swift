import Foundation
import SwiftParallelDataProcessor

struct InputRecord: Decodable, Sendable {
    let id: Int
    let payload: String
    let timestamp: Date
}

struct OutputRecord: Encodable, Sendable {
    let id: Int
    let transformedPayload: String
    let processedAt: Date
    let isValid: Bool
}

@main
struct MainProcessor {
    static func main() async throws {
        let rawInput: [String] = [
            "{\"id\": 1, \"payload\": \"test_data_alpha\", \"timestamp\": \"2023-10-01T12:00:00Z\"}",
            "{\"id\": 2, \"payload\": \"test_data_beta\", \"timestamp\": \"2023-10-01T12:01:00Z\"}",
            "{\"id\": 3, \"payload\": \"test_data_gamma\", \"timestamp\": \"2023-10-01T12:02:00Z\"}",
            "{\"id\": 4, \"payload\": \"test_data_delta\", \"timestamp\": \"2023-10-01T12:03:00Z\"}",
            "{\"id\": 5, \"payload\": \"test_data_epsilon\", \"timestamp\": \"2023-10-01T12:04:00Z\"}"
        ]
        
        print("Starting Swift Parallel Data Processor...")
        
        do {
            let records = try rawInput.map { input -> InputRecord in
                let data = Data(input.utf8)
                guard let record = try? JSONDecoder().decode(InputRecord.self, from: data) else {
                    throw ProcessingError.decodingFailed
                }
                return record
            }
            
            let results = try await ProcessPipeline.process(
                inputs: records,
                config: ProcessingConfig(maxConcurrency: 3)
            )
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let outputData = try encoder.encode(results)
            if let outputString = String(data: outputData, encoding: .utf8) {
                print("Processing Results:")
                print(outputString)
            }
        } catch {
            print("Processing failed: \(error)")
        }
    }
}
