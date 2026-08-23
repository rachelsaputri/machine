#!/usr/bin/env s

# Function: ingest_data
# Description: Reads a CSV file and returns a data frame.
# Arguments:
#   file_path: Character string specifying the path to the CSV file.
# Returns:
#   A data frame containing the loaded data.

ingest_data <- function(file_path) {
  # Check if file exists
  if (!file.exists(file_path)) {
    stop("File not found: ", file_path)
  }
  
  # Read the CSV file
  data <- read.csv(file_path, stringsAsFactors = FALSE, na.strings = c("", "NA", "N/A", "null"))
  
  # Return the data frame
  return(data)
}

# Function: ingest_text
# Description: Reads a text file and returns a vector of lines.
# Arguments:
#   file_path: Character string specifying the path to the text file.
# Returns:
#   A character vector containing the lines of the file.

ingest_text <- function(file_path) {
  # Check if file exists
  if (!file.exists(file_path)) {
    stop("File not found: ", file_path)
  }
  
  # Read the text file
  lines <- readLines(file_path, warn = FALSE)
  
  # Return the vector of lines
  return(lines)
}

# Function: ingest_multiple_csvs
# Description: Reads multiple CSV files and combines them into a single data frame.
# Arguments:
#   file_paths: Character vector specifying the paths to the CSV files.
# Returns:
#   A data frame containing the combined data from all CSV files.

ingest_multiple_csvs <- function(file_paths) {
  # Check if file paths exist
  if (!all(file.exists(file_paths))) {
    missing_files <- file_paths[!file.exists(file_paths)]
    stop("Some files were not found: ", paste(missing_files, collapse = ", "))
  }
  
  # Initialize an empty data frame
  combined_data <- data.frame()
  
  # Loop through each file path and read the CSV
  for (file in file_paths) {
    data <- read.csv(file, stringsAsFactors = FALSE, na.strings = c("", "NA", "N/A", "null"))
    combined_data <- rbind(combined_data, data)
  }
  
  # Return the combined data frame
  return(combined_data)
}
