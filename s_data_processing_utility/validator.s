#!/usr/bin/env s

# Function: validate_data
# Description: Validates the data for integrity and consistency.
# Arguments:
#   data: A data frame containing the data to validate.
# Returns:
#   A list containing validation results.

validate_data <- function(data) {
  cat("Validating data...\n")
  
  validation_results <- list()
  
  # Check for empty data
  if (nrow(data) == 0 || ncol(data) == 0) {
    validation_results$empty_data <- "Data is empty."
    return(validation_results)
  }
  
  # Check for duplicate rows
  duplicate_count <- sum(duplicated(data))
  if (duplicate_count > 0) {
    validation_results$duplicates <- paste("Found", duplicate_count, "duplicate rows.")
  } else {
    validation_results$duplicates <- "No duplicate rows found."
  }
  
  # Check for missing values
  missing_counts <- colSums(is.na(data))
  if (any(missing_counts > 0)) {
    validation_results$missing_values <- paste("Missing values in columns:", paste(names(missing_counts[missing_counts > 0]), collapse = ", "))
  } else {
    validation_results$missing_values <- "No missing values found."
  }
  
  # Check for consistent data types
  type_consistency <- TRUE
  for (col in names(data)) {
    if (!is.numeric(data[[col]]) && !is.character(data[[col]]) && !is.factor(data[[col]])) {
      type_consistency <- FALSE
      break
    }
  }
  if (!type_consistency) {
    validation_results$type_consistency <- "Inconsistent data types detected."
  } else {
    validation_results$type_consistency <- "Data types are consistent."
  }
  
  # Check for outliers in numeric columns
  numeric_cols <- sapply(data, is.numeric)
  if (any(numeric_cols)) {
    outliers <- list()
    for (col in names(data)[numeric_cols]) {
      q1 <- quantile(data[[col]], 0.25)
      q3 <- quantile(data[[col]], 0.75)
      iqr <- q3 - q1
      lower_bound <- q1 - 1.5 * iqr
      upper_bound <- q3 + 1.5 * iqr
      outlier_count <- sum(data[[col]] < lower_bound | data[[col]] > upper_bound)
      if (outlier_count > 0) {
        outliers[[col]] <- outlier_count
      }
    }
    if (length(outliers) > 0) {
      validation_results$outliers <- paste("Outliers found in columns:", paste(names(outliers), collapse = ", "))
    } else {
      validation_results$outliers <- "No outliers detected."
    }
  } else {
    validation_results$outliers <- "No numeric columns to check for outliers."
  }
  
  cat("Data validation completed.\n")
  return(validation_results)
}

# Function: validate_schema
# Description: Validates data against a predefined schema.
# Arguments:
#   data: A data frame containing the data to validate.
#   schema: A list specifying the expected schema (column names and types).
# Returns:
#   A list containing schema validation results.

validate_schema <- function(data, schema) {
  cat("Validating data against schema...\n")
  
  schema_results <- list()
  
  # Check for required columns
  required_columns <- names(schema)
  missing_columns <- setdiff(required_columns, colnames(data))
  if (length(missing_columns) > 0) {
    schema_results$missing_columns <- paste("Missing columns:", paste(missing_columns, collapse = ", "))
  } else {
    schema_results$missing_columns <- "All required columns are present."
  }
  
  # Check for data types
  type_mismatches <- list()
  for (col in required_columns) {
    expected_type <- schema[[col]]
    actual_type <- class(data[[col]])
    if (expected_type != actual_type && !actual_type %in% expected_type) {
      type_mismatches[[col]] <- paste("Expected:", expected_type, "Actual:", actual_type)
    }
  }
  if (length(type_mismatches) > 0) {
    schema_results$type_mismatches <- type_mismatches
  } else {
    schema_results$type_mismatches <- "All data types match the schema."
  }
  
  cat("Schema validation completed.\n")
  return(schema_results)
}
