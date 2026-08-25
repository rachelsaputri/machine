defmodule ElixirDataProcessingEngine.Validator do
  @moduledoc """
  Validates data records against a set of rules or schema expectations.
  """

  @doc """
  Validates a list of records against a validation function.
  Returns a map with :valid and :invalid counts.
  """
  def validate(records, validator_func) when is_list(records) and is_function(validator_func, 1) do
    {valid, invalid} = Enum.split_with(records, &validator_func.())
    %{
      valid_count: Enum.count(valid),
      invalid_count: Enum.count(invalid),
      valid_records: valid,
      invalid_records: invalid
    }
  end

  @doc """
  Generic schema validator: checks if a record contains required keys.
  """
  def validate_schema(records, required_keys) when is_list(records) and is_list(required_keys) do
    Enum.map(records, fn record ->
      missing = required_keys -- Map.keys(record)
      if Enum.empty?(missing) do
        {:ok, record}
      else
        {:error, :missing_keys, missing, record}
      end
    end)
  end
end
