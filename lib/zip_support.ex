defmodule ZipSupport do
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
end
