defmodule ElixirDataProcessingEngine.Reporter do
  @moduledoc """
  Generates reports on the data processing pipeline status and results.
  """

  @doc """
  Prints a summary report to the console.
  """
  def print_summary(ingested, transformed, validated) do
    IO.puts("=== Data Processing Report ===")
    IO.puts("Ingested Records: #{ingested}")
    IO.puts("Transformed Records: #{transformed}")
    IO.puts("Valid Records: #{validated[:valid_count]}")
    IO.puts("Invalid Records: #{validated[:invalid_count]}")
    IO.puts("==============================")
  end

  @doc """
  Generates a structured map summary for programmatic access.
  """
  def generate_summary(ingested, transformed, validated) do
    %{
      timestamp: DateTime.utc_now(),
      ingested: ingested,
      transformed: transformed,
      valid_count: validated[:valid_count],
      invalid_count: validated[:invalid_count],
      total_processed: ingested
    }
  end
end
