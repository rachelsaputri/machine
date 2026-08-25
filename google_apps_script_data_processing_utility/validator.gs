/**
 * Data Validator class.
 * Validates records against predefined rules.
 */

class DataValidator {
  constructor() {
    this.errors = [];
    this.validationRules = [
      { field: 'id', type: 'number', required: true },
      { field: 'name', type: 'string', required: true },
      { field: 'email', type: 'email', required: false },
      { field: 'age', type: 'number', required: false, min: 0, max: 150 },
      { field: 'status', type: 'enum', values: ['active', 'inactive', 'pending'], required: false }
    ];
  }

  /**
   * Validates an array of records.
   * @param {Array<Object>} records
   * @returns {Array<Object>} Valid records
   */
  validate(records) {
    this.errors = [];
    const validRecords = [];

    records.forEach((record, index) => {
      const isValid = this.validateRecord(record, index);
      if (isValid) {
        validRecords.push(record);
      }
    });

    return validRecords;
  }

  /**
   * Validates a single record.
   * @param {Object} record
   * @param {number} rowIndex
   * @returns {boolean}
   */
  validateRecord(record, rowIndex) {
    let isValid = true;

    this.validationRules.forEach(rule => {
      // Check required fields
      if (rule.required && (record[rule.field] === undefined || record[rule.field] === null || record[rule.field] === '')) {
        this.errors.push(`Row ${rowIndex + 1}: Field '${rule.field}' is required but missing.`);
        isValid = false;
        return;
      }

      // Skip further validation if field is not present and not required
      if (record[rule.field] === undefined || record[rule.field] === null || record[rule.field] === '') {
        return;
      }

      // Check type
      if (rule.type === 'number') {
        if (typeof record[rule.field] !== 'number' || isNaN(record[rule.field])) {
          this.errors.push(`Row ${rowIndex + 1}: Field '${rule.field}' must be a number.`);
          isValid = false;
        }
      } else if (rule.type === 'string') {
        if (typeof record[rule.field] !== 'string') {
          this.errors.push(`Row ${rowIndex + 1}: Field '${rule.field}' must be a string.`);
          isValid = false;
        }
      } else if (rule.type === 'email') {
        if (!this.isValidEmail(record[rule.field])) {
          this.errors.push(`Row ${rowIndex + 1}: Field '${rule.field}' is not a valid email.`);
          isValid = false;
        }
      } else if (rule.type === 'enum') {
        if (!rule.values.includes(record[rule.field])) {
          this.errors.push(`Row ${rowIndex + 1}: Field '${rule.field}' must be one of: ${rule.values.join(', ')}.`);
          isValid = false;
        }
      }

      // Check min/max for numbers
      if (rule.type === 'number') {
        if (rule.min !== undefined && record[rule.field] < rule.min) {
          this.errors.push(`Row ${rowIndex + 1}: Field '${rule.field}' must be >= ${rule.min}.`);
          isValid = false;
        }
        if (rule.max !== undefined && record[rule.field] > rule.max) {
          this.errors.push(`Row ${rowIndex + 1}: Field '${rule.field}' must be <= ${rule.max}.`);
          isValid = false;
        }
      }
    });

    return isValid;
  }

  /**
   * Helper to check if a string is a valid email.
   * @param {string} email
   * @returns {boolean}
   */
  isValidEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(String(email).toLowerCase());
  }

  /**
   * Gets all validation errors.
   * @returns {Array<string>}
   */
  getErrors() {
    return this.errors;
  }
}
