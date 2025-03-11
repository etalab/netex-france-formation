defmodule XmlSupport do
  @doc """
  Given an Elixir string, parse it as XML and return an `xmerl` raw structure.
  """
  def string_to_xmerl!(string) do
    string
    |> :erlang.binary_to_list()
    |> :xmerl_scan.string()
    |> elem(0)
  end

  def xpath!(xmerl, xpath) do
    xpath
    |> :erlang.binary_to_list()
    |> :xmerl_xpath.string(xmerl)
  end

  @doc """
  Given a raw `xmerl` structure, list the elements
  appearing together with their counts. Order is preserved.
  """
  def count_xmerl_elements!(xmerl) do
    xmerl
    |> Enum.map(&elem(&1, 2))
    |> Enum.chunk_by(& &1)
    |> Enum.map(fn chunk -> {hd(chunk), length(chunk)} end)
  end
end
