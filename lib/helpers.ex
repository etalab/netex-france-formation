defmodule Helpers do
  @doc """
  Ensure a list contains a single element and return it. Otherwise raise an error.
  """
  def one!([item]), do: item
end
