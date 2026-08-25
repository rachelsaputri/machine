/**
 * Data Ingester class.
 * Handles reading data from various sources (Google Sheets, CSV, JSON).
 */

class DataIngester {
  /**
   * @param {string} sourceType - Type of source: 'SHEET', 'CSV', 'JSON'
   * @param {string} sourceId - Spreadsheet ID or File ID or JSON string
   * @param {string} sheetName - Name of the sheet (for SHEET type)
   * @param {number} batchSize - Number of rows to process at once (for large datasets)
   */
  constructor(sourceType, sourceId, sheetName, batchSize) {
    this.sourceType = sourceType;
    this.sourceId = sourceId;
    this.sheetName = sheetName;
    this.batchSize = batchSize;
  }

  /**
   * Ingests data from the configured source.
   * @returns {Array<Object>} An array of objects representing rows of data.
   */
  ingest() {
    if (this.sourceType === 'SHEET') {
      return this.ingestFromSheet();
    } else if (this.sourceType === 'CSV') {
      return this.ingestFromCSV();
    } else if (this.sourceType === 'JSON') {
      return this.ingestFromJSON();
    } else {
      throw new Error(`Unsupported source type: ${this.sourceType}`);
    }
  }

  /**
   * Reads data from a Google Sheet.
   * @returns {Array<Object>}
   */
  ingestFromSheet() {
    const spreadsheet = SpreadsheetApp.openById(this.sourceId);
    const sheet = spreadsheet.getSheetByName(this.sheetName);
    
    if (!sheet) {
      throw new Error(`Sheet '${this.sheetName}' not found in spreadsheet.`);
    }

    const data = sheet.getDataRange().getValues();
    
    if (data.length === 0) {
      return [];
    }

    // First row is headers
    const headers = data[0];
    const rows = data.slice(1);

    return rows.map(row => {
      const record = {};
      headers.forEach((header, index) => {
        record[header] = row[index];
      });
      return record;
    });
  }

  /**
   * Reads data from a CSV file in Google Drive.
   * @returns {Array<Object>}
   */
  ingestFromCSV() {
    try {
      const file = DriveApp.getFileById(this.sourceId);
      const content = file.getBlob().getDataAsString();
      const lines = content.split('\n').filter(line => line.trim() !== '');
      
      if (lines.length === 0) {
        return [];
      }

      // Simple CSV parsing (handles basic cases, not quoted commas)
      const headers = this.parseCSVLine(lines[0]);
      const records = [];

      for (let i = 1; i < lines.length; i++) {
        const values = this.parseCSVLine(lines[i]);
        const record = {};
        headers.forEach((header, index) => {
          record[header] = values[index] || '';
        });
        records.push(record);
      }
      
      return records;
    } catch (e) {
      throw new Error(`Error reading CSV file: ${e.message}`);
    }
  }

  /**
   * Helper to parse a CSV line into an array of values.
   * @param {string} line
   * @returns {Array<string>}
   */
  parseCSVLine(line) {
    const result = [];
    let current = '';
    let inQuotes = false;
    
    for (let i = 0; i < line.length; i++) {
      const char = line[i];
      if (char === '"') {
        inQuotes = !inQuotes;
      } else if (char === ',' && !inQuotes) {
        result.push(current.trim());
        current = '';
      } else {
        current += char;
      }
    }
    result.push(current.trim());
    return result;
  }

  /**
   * Reads data from a JSON source.
   * @returns {Array<Object>}
   */
  ingestFromJSON() {
    try {
      let jsonContent = this.sourceId;
      
      // If sourceId is a file ID, read the file
      if (!this.sourceId.startsWith('{')) {
        const file = DriveApp.getFileById(this.sourceId);
        jsonContent = file.getBlob().getDataAsString();
      }
      
      const jsonData = JSON.parse(jsonContent);
      
      // Handle both array and object with array property
      if (Array.isArray(jsonData)) {
        return jsonData;
      } else if (jsonData.data && Array.isArray(jsonData.data)) {
        return jsonData.data;
      } else {
        throw new Error('JSON does not contain an array of records.');
      }
    } catch (e) {
      throw new Error(`Error parsing JSON: ${e.message}`);
    }
  }
}
