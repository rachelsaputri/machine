defmodule ElixirDataProcessingEngine.Transformer do
  @moduledoc """
  Handles the transformation of ingested data records.
  Applies a series of transformation functions to each record.
  """

  @doc """
  Applies a list of transformation functions to the data records.
  """
  def transform(records, transformation_funcs) when is_list(records) and is_list(transformation_funcs) do
    Enum.map(records, fn record ->
      Enum.reduce(transformation_funcs, record, fn func, acc ->
        apply_transform(func, acc)
      end)
    end)
  end

  defp apply_transform(func, record) when is_function(func, 1) do
    func.(record)
  end

  defp apply_transform({mod, fun, args}, record) when is_atom(mod) and is_atom(fun) do
    apply(mod, fun, args ++ [record])
  end

  defp apply_transform(_func, record), do: record
end
