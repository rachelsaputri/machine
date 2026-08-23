#!/usr/bin/env s

# Function: generate_report
# Description: Generates a summary report of the processed data and validation results.
# Arguments:
#   data: A data frame containing the processed data.
#   validation_results: A list or data frame containing validation results.

generate_report <- function(data, validation_results) {
  cat("\n=== Data Processing Report ===\n")
  
  # Data Summary
  cat("\n--- Data Summary ---\n")
  cat("Number of Rows:", nrow(data), "\n")
  cat("Number of Columns:", ncol(data), "\n")
  cat("Column Names:\n")
  print(colnames(data))
  
  # Statistical Summary for Numeric Columns
  numeric_cols <- sapply(data, is.numeric)
  if (any(numeric_cols)) {
    cat("\n--- Statistical Summary for Numeric Columns ---\n")
    summary_stats <- summary(data[, numeric_cols, drop = FALSE])
    print(summary_stats)
  }
  
  # Missing Values Summary
  missing_counts <- colSums(is.na(data))
  if (any(missing_counts > 0)) {
    cat("\n--- Missing Values Summary ---\n")
    print(missing_counts[missing_counts > 0])
  } else {
    cat("\nNo missing values detected.\n")
  }
  
  # Validation Results Summary
  if (!is.null(validation_results)) {
    cat("\n--- Validation Results ---\n")
    if (is.data.frame(validation_results)) {
      print(validation_results)
    } else if (is.list(validation_results)) {
      for (item in validation_results) {
        cat(item, "\n")
      }
    } else {
      cat(validation_results, "\n")
    }
  } else {
    cat("\nNo validation results available.\n")
  }
  
  cat("\n=== End of Report ===\n")
}

# Function: export_report
# Description: Exports the data and validation results to a specified file.
# Arguments:
#   data: A data frame containing the processed data.
#   validation_results: A list or data frame containing validation results.
#   output_file: Character string specifying the path to save the report.

export_report <- function(data, validation_results, output_file) {
  # Create a report data frame
  report <- data.frame(
    Metric = c("Number of Rows", "Number of Columns"),
    Value = c(nrow(data), ncol(data)),
    stringsAsFactors = FALSE
  )
  
  # Add validation results if available
  if (!is.null(validation_results)) {
    if (is.data.frame(validation_results)) {
      report <- rbind(report, data.frame(Metric = "Validation Results", Value = as.character(validation_results), stringsAsFactors = FALSE))
    } else if (is.list(validation_results)) {
      for (i in seq_along(validation_results)) {
        report <- rbind(report, data.frame(Metric = paste("Validation Item", i), Value = as.character(validation_results[[i]]), stringsAsFactors = FALSE))
      }
    } else {
      report <- rbind(report, data.frame(Metric = "Validation Result", Value = as.character(validation_results), stringsAsFactors = FALSE))
    }
  }
  
  # Write the report to a CSV file
  write.csv(report, output_file, row.names = FALSE)
  cat("Report exported to:", output_file, "\n")
}
