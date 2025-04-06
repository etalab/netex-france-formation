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
  # NOTE: for much larger docs later, this is the way https://github.com/qcam/saxy/pull/100
  defmodule SaxHandler do
    @behaviour Saxy.Handler

    def format_line([item]), do: item
    def format_line(items = [item | _tail]), do: "#{item} (x#{items |> length})"

    def handle_event(:start_document, _options, []) do
      {:ok, %{level: 0, output: []}}
    end

    def handle_event(:end_document, _options, state) do
      output = state.output
      |> Enum.chunk_by(& &1)
      |> Enum.map(&format_line(&1))
      |> Enum.join("\n")

      {:ok, output}
    end

    def handle_event(:start_element, {name, _attributes}, state) do
      indent = String.duplicate("  ", state.level)

      state = state
      |> Map.update!(:level, &(&1 + 1))

      state = state
      |> Map.update!(:output, fn(output) ->
        cond do
          state.level > 5 -> output
          state.level in (2..3) -> output ++ [indent <> "(...)"]
          true -> output ++ [indent <> name]
        end
      end)
      {:ok, state}
    end

    def handle_event(:end_element, _, state) do
      state = state |> Map.update!(:level, &(&1 - 1))
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

    {:ok, output} = zip
    |> Unzip.file_stream!(filename)
    |> Stream.map(&IO.iodata_to_binary(&1))
    |> Saxy.parse_stream(SaxHandler, [])

    IO.puts output
  end
end
