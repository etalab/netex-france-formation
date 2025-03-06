Mix.install([
  {:req, "~> 0.5.8"},
  {:xml_query, "~> 2.0"},
  {:unzip, "~> 0.12.0"}
])

ExUnit.start()

defmodule Helpers do
  def open_zip!(filename) do
    zip_file = Unzip.LocalFile.open(filename)
    {:ok, unzip} = Unzip.new(zip_file)
    unzip
  end

  def list_zip_entries(zip) do
    Unzip.list_entries(zip)
    |> Enum.map(& &1.file_name)
  end

  def read_entry!(zip, filename) do
    stream = Unzip.file_stream!(zip, filename)
    Enum.into(stream, <<>>, &IO.iodata_to_binary/1)
  end

  def one!([item]), do: item
end

defmodule TestCase do
  use ExUnit.Case

  @input __DIR__ <> "/data/ca_rochefort_ocean-aggregated-netex-2025-03-03.zip"

  import Helpers

  test "it works" do
    zip = open_zip!(@input)
    entries = zip |> list_zip_entries()

    commun =
      one!(entries |> Enum.filter(&(&1 =~ ~r/commun/)))

    read_entry!(zip, commun)
    |> String.split("\n")
    |> IO.inspect(IEx.inspect_opts())
  end
end
