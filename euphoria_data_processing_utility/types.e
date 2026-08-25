-- types.e
-- Defines core data structures for the processing utility.

-- A single record (row) in the dataset
-- Format: {field1_value, field2_value, ...}
typedef sequence ROW

-- The entire dataset is a sequence of ROWs
typedef sequence DATASET

-- Configuration structure for transforms
typedef record TRANSFORM_CONFIG
    atom field_index
    atom min_val
    atom max_val
end record
