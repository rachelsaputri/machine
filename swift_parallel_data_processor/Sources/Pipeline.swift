import Foundation

struct ProcessPipeline {
    static func process(
        inputs: [InputRecord],
        config: ProcessingConfig
    ) async throws -> [ProcessingResult] {
        print("Pipeline initialized with \(inputs.count) records.")
        let startTime = Date()
        
        let chunks = inputs.chunked(into: config.batchSize)
        var allResults: [ProcessingResult] = []
        
        for chunk in chunks {
            let chunkResults = try await Task.withGroup {\n                for input in chunk {
                    Task.detached(priority: .userInitiated) {
                        do {
                            let result = try await processSingleRecord(input, config: config)
                            // Accessing shared mutable state in a concurrent context is unsafe,
                            // but for this demonstration we are appending directly.
                            // In production, use an actor or lock.
                            allResults.append(result)
                        } catch {
                            allResults.append(ProcessingResult(
                                inputId: input.id,
                                outputPayload: "",
                                success: false,
                                error: error.localizedDescription,
                                processingTime: 0
                            ))
                        }
                    }
                }
            }
            
            _ = chunkResults
        }
        
        let duration = Date().timeIntervalSince(startTime)
        print("Processing completed in \(duration.formatted()) seconds.")
        return allResults.sorted { $0.inputId < $1.inputId }
    }
    
    private static func processSingleRecord(
        _ input: InputRecord,
        config: ProcessingConfig
    ) async throws -> ProcessingResult {
        let startTime = Date()
        print("Processing record ID: \(input.id)")
        
        do {
            let transformed = try await TransformationEngine.transform(input.payload)
            let isValid = try await ValidationEngine.validate(transformed)
            
            let result = ProcessingResult(
                inputId: input.id,
                outputPayload: transformed,
                success: true,
                error: nil,
                processingTime: Date().timeIntervalSince(startTime)
            )
            
            print("Record ID: \(input.id) processed successfully.")
            return result
        } catch {
            print("Record ID: \(input.id) failed: \(error)")
            return ProcessingResult(
                inputId: input.id,
                outputPayload: "",
                success: false,
                error: error.localizedDescription,
                processingTime: Date().timeIntervalSince(startTime)
            )
        }
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        var chunks: [[Element]] = []
        for index in stride(from: 0, to: count, by: size) {
            let end = min(index + size, count)
            chunks.append(Array(self[index..<end]))
        }
        return chunks
    }
}
