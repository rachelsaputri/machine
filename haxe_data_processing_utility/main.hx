package;

/**
 * Entry point for the Haxe Data Processing Utility.
 */
class Main {

    static function main() {
        Sys.println("Haxe Data Processing Utility v1.0");
        Sys.println("Initializing processor...");

        // Define processing configuration
        var config = new ProcessingConfig(
            50,      // batchSize
            true,    // strictValidation
            []       // custom transform functions
        );

        var processor = new DataProcessor(config);

        // Sample JSON Input
        var jsonInput = 
            '[
                {
                    "id": "101",
                    "name": "  Widget A  ",
                    "value": 120.5,
                    "category": "ELECTRONICS"
                },
                {
                    "id": "102",
                    "name": "Gadget B",
                    "value": "not_a_number",
                    "category": "HOME"
                },
                {
                    "id": "103",
                    "name": "Tool C",
                    "value": 50,
                    "category": "TOOLS"
                },
                {
                    "name": "Missing ID Record",
                    "value": 10
                }
            ]';

        Sys.println("\nProcessing JSON Input...");
        var result = processor.process(jsonInput);

        // Output Report
        DataReporter.printSummary(result, result.processedRecords);
        
        Sys.println("JSON Report:");
        Sys.println(DataReporter.generateJsonReport(result, []));

        // Sample CSV Input
        var csvInput = 
            "id,name,value,category\n"
            + "201,Widget D,200,GADGETS\n"
            + "202,,300,TOOLS";

        Sys.println("\nProcessing CSV Input...");
        var result2 = processor.process(csvInput);
        
        DataReporter.printSummary(result2, result2.processedRecords);
        Sys.println("JSON Report:");
        Sys.println(DataReporter.generateJsonReport(result2, []));
    }
}
