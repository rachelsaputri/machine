package;

import haxe.Json;
import haxe.ds.StringMap;

/**
 * Handles ingestion of raw data strings into DataRecord objects.
 */
class DataIngestor {

    /**
     * Ingests a JSON string containing an array of objects.
     * Returns an array of DataRecords.
     */
    public static function ingestJson(input: String): Array<DataRecord> {
        var records: Array<DataRecord> = [];
        
        try {
            var rawData: Array<Map<String, Dynamic>> = haxe.Json.parse(input);
            for (i in 0...rawData.length) {
                var item = rawData[i];
                var id: String = 
                    if (item.exists("id")) { item["id"] + ""; }
                    else { "record_" + i; };
                
                records.push(new DataRecord(id, item, input));
            }
        } catch (e: Dynamic) {
            throw "JSON Ingestion Error: " + e;
        }
        
        return records;
    }

    /**
     * Ingests a CSV-formatted string.
     * Assumes the first line is the header.
     */
    public static function ingestCsv(input: String): Array<DataRecord> {
        var records: Array<DataRecord> = [];
        var lines: Array<String> = input.split("\n");
        
        if (lines.length == 0) return records;

        var headers: Array<String> = lines[0].split(",");
        
        for (i in 1...lines.length) {
            var line = lines[i].trim();
            if (line.length == 0) continue;
            
            var values: Array<String> = line.split(",");
            var dataMap: Map<String, Dynamic> = new StringMap();
            
            for (j in 0...headers.length) {
                var key = headers[j].trim();
                var value = j < values.length ? values[j].trim() : "";
                dataMap.set(key, value);
            }
            
            var id = "record_" + i;
            if (dataMap.exists("id")) {
                id = dataMap.get("id") + "";
            }
            
            records.push(new DataRecord(id, dataMap, input));
        }
        
        return records;
    }

    /**
     * Ingests a single JSON object as a record.
     */
    public static function ingestSingleJson(input: String): DataRecord {
        var rawData: Map<String, Dynamic> = haxe.Json.parse(input);
        var id: String = 
            if (rawData.exists("id")) { rawData["id"] + ""; }
            else { "single_record"; };
            
        return new DataRecord(id, rawData, input);
    }
}
