/**
 * Data Reporter class.
 * Generates reports and exports data.
 */

class DataReporter {
  /**
   * @param {string} outputSheetName - Name of the sheet to write output to
   */
  constructor(outputSheetName) {
    this.outputSheetName = outputSheetName;
  }

  /**
   * Generates a report summary.
   * @param {Array<Object>} validData
   * @param {Array<Object>} processedData
   * @param {number} errorsCount
   * @returns {Object}
   */
  generateReport(validData, processedData) {
    const report = {
      validCount: validData.length,
      processedCount: processedData.length,
      timestamp: new Date().toISOString()
    };
    return report;
  }

  /**
   * Exports processed data to a Google Sheet.
   * @param {Array<Object>} data
   */
  exportData(data) {
    if (data.length === 0) {
      Logger.log('No data to export.');
      return;
    }

    const spreadsheet = SpreadsheetApp.getActiveSpreadsheet();
    let sheet = spreadsheet.getSheetByName(this.outputSheetName);
    
    if (!sheet) {
      sheet = spreadsheet.insertSheet(this.outputSheetName);
    } else {
      sheet.clear();
    }

    // Get headers from first record
    const headers = Object.keys(data[0]);
    
    // Write headers
    sheet.appendRow(headers);
    
    // Write data
    const values = data.map(record => {
      return headers.map(header => record[header] || '');
    });
    
    if (values.length > 0) {
      sheet.getRange(2, 1, values.length, headers.length).setValues(values);
    }

    // Auto-resize columns
    sheet.autoResizeColumns(1, headers.length);
    
    Logger.log(`Exported ${data.length} records to sheet '${this.outputSheetName}'.`);
  }
}
