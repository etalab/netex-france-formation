# self-contained tests embryo

Mix.install([
  {:unzip, "~> 0.12.0"},
  {:saxy, "~> 1.6"}
])

ExUnit.start()
Code.require_file("../zip_support.ex", __DIR__)
Code.require_file("../xml_support.ex", __DIR__)
Code.require_file("../helpers.ex", __DIR__)

defmodule Tests do
  use ExUnit.Case

  @folder_root Path.join(__DIR__, "../..")
  @file_path "data/ca_rochefort_ocean-aggregated-netex-2025-03-03.zip"

  # TODO: port to xmerl_sax_handler to reduce external dependencies
  defmodule SaxHandler do
    @behaviour Saxy.Handler

    def handle_event(:start_element, {name, _attributes}, state) do
      IO.puts name
      {:ok, state}
    end

    def handle_event(:end_element, _, state) do
      {:ok, state}
    end

    def handle_event(_, _, state), do: {:ok, state}
  end

  def one!(list, regexp) do
    list
    |> Enum.filter(& &1 =~ regexp)
    |> Helpers.one!()
  end

  test "summarises" do
    zip = @file_path
    |> Path.expand(@folder_root)
    |> ZipSupport.open_zip!()

    filename = zip
    |> ZipSupport.list_zip_entries()
    |> one!(~r/commun/)

    zip
    |> Unzip.file_stream!(filename)
    |> Stream.into(<<>>, &IO.iodata_to_binary/1)
    |> Saxy.parse_stream(SaxHandler, [])
    |> IO.puts
  end
end
