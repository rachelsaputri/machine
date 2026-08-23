#!/usr/bin/env s

# Function: transform_data
# Description: Cleans, normalizes, and reshapes the data.
# Arguments:
#   data: A data frame containing the raw data.
# Returns:
#   A cleaned and transformed data frame.

transform_data <- function(data) {
  cat("Transforming data...\n")
  
  # Remove duplicate rows
  data <- data[!duplicated(data), ]
  
  # Replace NA values with column means for numeric columns
  numeric_cols <- sapply(data, is.numeric)
  for (col in names(data)[numeric_cols]) {
    mean_val <- mean(data[[col]], na.rm = TRUE)
    data[[col]][is.na(data[[col]])] <- mean_val
  }
  
  # Replace NA values with "Unknown" for character columns
  char_cols <- sapply(data, is.character)
  for (col in names(data)[char_cols]) {
    data[[col]][is.na(data[[col]])] <- "Unknown"
  }
  
  # Trim whitespace from character columns
  for (col in names(data)[char_cols]) {
    data[[col]] <- trimws(data[[col]])
  }
  
  # Convert character columns to factors
  for (col in names(data)[char_cols]) {
    data[[col]] <- as.factor(data[[col]])
  }
  
  # Normalize numeric columns
  for (col in names(data)[numeric_cols]) {
    min_val <- min(data[[col]])
    max_val <- max(data[[col]])
    if (max_val != min_val) {
      data[[col]] <- (data[[col]] - min_val) / (max_val - min_val)
    } else {
      data[[col]] <- 0
    }
  }
  
  cat("Data transformation completed.\n")
  return(data)
}

# Function: reshape_data
# Description: Reshapes the data from wide to long format or vice versa.
# Arguments:
#   data: A data frame containing the data to reshape.
#   id_vars: Character vector specifying the identifier variables.
#   measure_vars: Character vector specifying the measure variables.
#   direction: Character string specifying the direction of reshaping ("long" or "wide").
# Returns:
#   A reshaped data frame.

reshape_data <- function(data, id_vars, measure_vars, direction = "long") {
  if (direction == "long") {
    # Reshape from wide to long
    long_data <- reshape(data, 
                         varying = list(measure_vars), 
                         v.names = "value", 
                         timevar = "time", 
                         ids = id_vars,
                         direction = "long")
    return(long_data)
  } else if (direction == "wide") {
    # Reshape from long to wide
    wide_data <- reshape(data, 
                         idvar = id_vars, 
                         timevar = "time", 
                         direction = "wide")
    return(wide_data)
  } else {
    stop("Invalid direction: ", direction)
  }
}
