/**
 * Data Transformer class.
 * Applies transformations to validated data.
 */

class DataTransformer {
  constructor() {
    this.transformations = [
      { field: 'name', action: 'trim' },
      { field: 'email', action: 'toLowerCase' },
      { field: 'age', action: 'parseInt' },
      { field: 'fullName', action: 'concat', fields: ['name', 'email'], separator: ' - ' }
    ];
  }

  /**
   * Transforms an array of records.
   * @param {Array<Object>} records
   * @returns {Array<Object>}
   */
  transform(records) {
    const transformedRecords = records.map(record => {
      return this.transformRecord(record);
    });
    return transformedRecords;
  }

  /**
   * Transforms a single record.
   * @param {Object} record
   * @returns {Object}
   */
  transformRecord(record) {
    // Create a copy to avoid mutating original
    const transformed = Object.assign({}, record);

    this.transformations.forEach(transformation => {
      if (!transformed[transformation.field] && !transformation.fields) {
        return;
      }

      if (transformation.action === 'trim') {
        if (typeof transformed[transformation.field] === 'string') {
          transformed[transformation.field] = transformed[transformation.field].trim();
        }
      } else if (transformation.action === 'toLowerCase') {
        if (typeof transformed[transformation.field] === 'string') {
          transformed[transformation.field] = transformed[transformation.field].toLowerCase();
        }
      } else if (transformation.action === 'parseInt') {
        if (typeof transformed[transformation.field] === 'string') {
          transformed[transformation.field] = parseInt(transformed[transformation.field], 10);
        }
      } else if (transformation.action === 'concat') {
        const values = transformation.fields.map(f => transformed[f] || '');
        transformed[transformation.field] = values.join(transformation.separator || '');
      }
    });

    return transformed;
  }
}
