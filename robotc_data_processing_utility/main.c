/**
 * Main entry point for the RobotC Data Processing Utility.
 * Demonstrates the pipeline: Ingest -> Validate -> Transform -> Report.
 */

#include "sensor_ingester.h"
#include "data_validator.h"
#include "data_transformer.h"
#include "reporter.h"

// Global data buffer
SensorDataBuffer g_buffer;

task main() {
    // Initialize the system
    initSensorBuffer(&g_buffer);
    
    while (true) {
        // 1. Ingest Data
        ingestSensorData(&g_buffer);
        
        // 2. Validate Data
        if (validateBuffer(&g_buffer)) {
            // 3. Transform Data
            transformBuffer(&g_buffer);
            
            // 4. Report/Act on Data
            reportProcessedData(&g_buffer);
        } else {
            // Handle invalid data (e.g., log error, reset)
            logError("Invalid sensor data detected.");
        }
        
        // Pause to allow sensor updates and prevent CPU overload
        wait1Msec(50);
    }
}
