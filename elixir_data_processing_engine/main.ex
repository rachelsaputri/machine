defmodule ElixirDataProcessingEngine.Main do
  @moduledoc """
  Main entry point for the Elixir Data Processing Engine.
  Orchestrates the ingestion, transformation, validation, and reporting phases.
  """

  require Logger

  alias ElixirDataProcessingEngine.Ingestor
  alias ElixirDataProcessingEngine.Transformer
  alias ElixirDataProcessingEngine.Validator
  alias ElixirDataProcessingEngine.Reporter

  @doc """
  Runs the full data processing pipeline.
  """
  def run(raw_data, transformation_funcs, validator_func) do
    Logger.info("Starting Data Processing Pipeline...")

    # 1. Ingest
    {:ok, ingested_count, records} = Ingestor.ingest(raw_data)
    Logger.info("Ingested #{ingested_count} records.")

    # 2. Transform
    transformed_records = Transformer.transform(records, transformation_funcs)
    Logger.info("Transformation complete.")

    # 3. Validate
    validation_result = Validator.validate(transformed_records, validator_func)
    Logger.info("Validation complete. Valid: #{validation_result[:valid_count]}, Invalid: #{validation_result[:invalid_count]}")

    # 4. Report
    Reporter.print_summary(ingested_count, length(transformed_records), validation_result)

    validation_result[:valid_records]
  end

  @doc """
  Example usage and demo run.
  """
  def demo do
    sample_data = [
      %{id: 1, name: "Alice", score: 85, active: true},
      %{id: 2, name: "Bob", score: 92, active: false},
      %{id: 3, name: "Charlie", score: 78, active: true},
      %{id: 4, name: "David", score: 88, active: true},
      %{name: "Eve", score: 95, active: true} # Missing ID to trigger validation error
    ]

    transform_funcs = [
      fn record -> Map.put(record, :normalized_name, String.trim(record[:name])) end,
      fn record -> Map.put(record, :upper_score, record[:score] * 2) end
    ]

    validator = fn record -> Map.has_key?(record, :id) end

    run(sample_data, transform_funcs, validator)
  end
end
