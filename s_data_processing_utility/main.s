#!/usr/bin/env s

# Load required modules
source("ingester.s")
source("transformer.s")
source("validator.s")
source("reporter.s")

# Main function: process_data
# Description: Executes the data processing pipeline.
# Arguments:
#   data_path: Character string specifying the path to the input data file.
#   output_path: Character string specifying the path to save the processed data.
# Returns:
#   Invisibly returns the processed data frame.

process_data <- function(data_path, output_path) {
  # Step 1: Ingest Data
  cat("Step 1: Ingesting data...\n")
  data <- ingest_data(data_path)
  
  # Step 2: Transform Data
  cat("Step 2: Transforming data...\n")
  transformed_data <- transform_data(data)
  
  # Step 3: Validate Data
  cat("Step 3: Validating data...\n")
  validation_results <- validate_data(transformed_data)
  
  # Print validation results
  print(validation_results)
  
  # Step 4: Report Data
  cat("Step 4: Generating report...\n")
  generate_report(transformed_data, validation_results)
  
  # Step 5: Save Processed Data
  cat("Saving processed data...\n")
  write.csv(transformed_data, output_path, row.names = FALSE)
  
  cat("Data processing completed successfully.\n")
  
  # Return the processed data invisibly
  invisible(transformed_data)
}

# Execute main function with example paths
# process_data("./input.csv", "./output.csv")
