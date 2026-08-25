defmodule ElixirDataProcessingEngine.Ingestor do
  @moduledoc """
  Handles the ingestion of raw data into the processing system.
  Supports multiple sources (lists, streams, etc.) and converts them into a unified format.
  """

  @doc """
  Ingests a list of raw data records.
  Validates that the input is a list and returns a normalized tuple.
  """
  def ingest(data) when is_list(data) do
    records = Enum.map(data, &normalize_record/1)
    {:ok, Enum.count(records), records}
  end

  def ingest(data) do
    {:error, "Invalid data format: expected a list"}
  end

  defp normalize_record(record) when is_map(record) do
    record
    |> Map.put_new(:source, :manual)
    |> Map.put_new(:processed_at, DateTime.utc_now())
  end

  defp normalize_record(record) do
    IO.warn("Record was not a map: #{inspect(record)}")
    %{}
  end
end
