Mix.install([
  {:unzip, "~> 0.12.0"}
])

ExUnit.start()

defmodule Helpers do
  @doc """
  Open a local zip file for programmatic access.
  """
  def open_zip!(filename) do
    zip_file = Unzip.LocalFile.open(filename)
    {:ok, unzip} = Unzip.new(zip_file)
    unzip
  end

  @doc """
  List the names of all the files contained in a zip.
  """
  def list_zip_entries(zip) do
    zip
    |> Unzip.list_entries()
    |> Enum.map(& &1.file_name)
  end

  @doc """
  Read the content of an entry in a zip file.
  """
  def read_entry!(zip, filename) do
    zip
    |> Unzip.file_stream!(filename)
    |> Enum.into(<<>>, &IO.iodata_to_binary/1)
  end

  @doc """
  Ensure a list contains a single element and return it. Otherwise raise an error.
  """
  def one!([item]), do: item

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
  Given a raw `xmerl` structure and a XPath query, list the elements
  appearing together with their counts. Order is preserved.
  """
  def count_xmerl_elements!(xmerl, xpath) do
    xmerl
    |> xpath!(xpath)
    |> Enum.map(&elem(&1, 2))
    |> Enum.chunk_by(& &1)
    |> Enum.map(fn chunk -> {hd(chunk), length(chunk)} end)
  end
end

defmodule TestCase do
  use ExUnit.Case

  @input __DIR__ <> "/data/ca_rochefort_ocean-aggregated-netex-2025-03-03.zip"

  import Helpers

  test "it dumps all" do
    zip = open_zip!(@input)
    entries = zip |> list_zip_entries()

    entries
    |> Enum.reject(&String.ends_with?(&1, "/"))
    |> Enum.each(fn entry ->
      IO.puts("== #{entry} ==")

      content = read_entry!(zip, entry)
      xmerl = string_to_xmerl!(content)

      general_frames = xpath!(xmerl, "//GeneralFrame")

      general_frames
      |> Enum.each(fn general_frame ->
        count_xmerl_elements!(general_frame, "members/*")
        |> IO.inspect(IEx.inspect_opts())
      end)
    end)
  end
end
